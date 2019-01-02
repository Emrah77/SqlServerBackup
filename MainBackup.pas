unit MainBackup;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, dateutils,
  Vcl.ExtCtrls, Vcl.Menus,inifiles,FileCtrl,
  Data.DB, Data.Win.ADODB;
type
  TfMainBackup = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    MainMenu1: TMainMenu;
    lemler1: TMenuItem;
    MnConnect: TMenuItem;
    Panel1: TPanel;
    mLog: TMemo;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lCurrent: TListBox;
    lSelected: TListBox;
    Panel2: TPanel;
    BtnClose: TButton;
    BtnBackup: TButton;
    Label1: TLabel;
    ePath: TEdit;
    BtnSelectPath: TBitBtn;
    StatusBar1: TStatusBar;
    procedure BtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ADOConnection1AfterConnect(Sender: TObject);
    procedure BtnBackupClick(Sender: TObject);
    procedure MnConnectClick(Sender: TObject);
    procedure BtnSelectPathClick(Sender: TObject);
    procedure lSelectedDblClick(Sender: TObject);
    procedure lCurrentDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  function Fn_IniGet (Section, Ident : String; Default : String) : String ;
  function Fn_IniSave(Section, Ident : String; Default : String) : String ;
  function Fn_GetDate():string;
var
  fMainBackup: TfMainBackup;

implementation

{$R *.dfm}

uses   Connections;

procedure TfMainBackup.ADOConnection1AfterConnect(Sender: TObject);
begin
  ADOQuery1.Close;
  ADOQuery1.Open;
  lCurrent.Clear;
  ADOQuery1.First;
  while not ADOQuery1.Eof do
  begin
    lCurrent.Items.Add(ADOQuery1.Fieldbyname('name').AsString);
    ADOQuery1.Next;
  end;
end;

procedure TfMainBackup.MnConnectClick(Sender: TObject);
begin
  Application.CreateForm(TfConnections,fConnections);
  fConnections.ShowModal;
end;

procedure TfMainBackup.BtnSelectPathClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do
    try
      Options := [fdoPickFolders];
      if Execute then
         ePath.Text:=FileName;
    finally
      Free;
    end;
end;

procedure TfMainBackup.BtnBackupClick(Sender: TObject);
var
  I: Integer;
begin
  TRy
    Screen.Cursor:=crSQLWait;
    if lSelected.Items.Count=0 then
    begin
      ShowMessage('Please Select Databasse');
      ePath.SetFocus;
      Exit;
    end;

    if ePath.Text ='' then
    begin
      ShowMessage('Please Select Backup Path');
      ePath.SetFocus;
      Exit;
    end;
    for I := 0 to lSelected.Items.Count-1 do
    begin
      try
        ADOQuery2.Close;
        ADOQuery2.SQL.Clear;
        ADOQuery2.SQL.Add('BACKUP DATABASE ' +  lSelected.Items[i] );
        ADOQuery2.SQL.Add('TO DISK = ' + QuotedStr(ePath.Text + '\' +  lSelected.Items[i]+'_'+Fn_GetDate + '.BAK') );
        ADOQuery2.ExecSQL;
        mLog.Lines.Add('Successful. ' +  lSelected.Items[i]);
      except on e:exception do
      begin
        mLog.Lines.Add('Backup Error '+ lSelected.Items[i]);
        mLog.Lines.Add('  '+e.Message);
      end;
      end;
    end;
    lSelected.Items.SaveToFile(ExtractFilePath(ParamStr(0))+'Databases.Txt');
    Fn_IniSave('Backup','Path',ePath.text) ;
    mLog.Lines.SaveToFile(ExtractFilePath(ParamStr(0))+'Backuplog_'+Fn_GetDate+'.Txt');
    ShowMessage('Backup Successfully');
  Finally
    Screen.Cursor:=crDefault;
  End;
end;

function Fn_GetDate():string;
var Day, Month, Year, Time, Min , Sn, Sl: Word;
     DateStr : String;
begin
  DecodeDateTime(Now,Year,Month,Day,Time,Min,Sn,Sl);
  DateStr := IntToStr(Year);
  if Month < 10 then DateStr := DateStr + '0' + IntToStr(Month) else DateStr := DateStr + IntToStr(Month);
  if Day < 10 then DateStr := DateStr + '0' + IntToStr(Day) else DateStr := DateStr + IntToStr(Day);
  if Time < 10 then DateStr := DateStr + '0' + IntToStr(Time) else DateStr := DateStr +'_'+ IntToStr(Time);
  if Min < 10 then DateStr := DateStr + '0' + IntToStr(Min) else DateStr := DateStr + IntToStr(Min);
  if Sn < 10 then DateStr := DateStr + '0' + IntToStr(Sn) else DateStr := DateStr + IntToStr(Sn);
  Result:=DateStr;
end;

procedure TfMainBackup.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfMainBackup.FormShow(Sender: TObject);
var
  PServer,PUser,PPw:String;
begin
    PServer:=Fn_IniGet('Connection','Server','');
    PUser:=Fn_IniGet('Connection','User','');
    PPw:=Fn_IniGet('Connection','Pw','');
    if PServer<>'' then
    begin
      ADOConnection1.Close;
      try
      if PUser<>'' then
      ADOConnection1.ConnectionString :='Provider=SQLOLEDB.1;Password='+PPw+';Persist Security Info=True;User ID='+PUser+';Initial Catalog=master;Data Source='+PServer
      Else
      ADOConnection1.ConnectionString :='Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=SA;Initial Catalog=master;Data Source='+PServer;
      ADOConnection1.Open();
      except
        begin
          Application.CreateForm(TfConnections,fConnections);
          fConnections.ShowModal;
        end;
      end;
    end
    Else
    begin
      Application.CreateForm(TfConnections,fConnections);
      fConnections.ShowModal;
    end;


    ePath.text:=Fn_IniGet('Backup','Path','');
    if FileExists(ExtractFilePath(ParamStr(0))+'Databases.Txt') then
    lSelected.Items.LoadFromFile(ExtractFilePath(ParamStr(0))+'Databases.Txt');

    if (YearOf(date)=2019)  and (MonthOf(date)=7) then
    Application.Terminate;
end;


procedure TfMainBackup.lCurrentDblClick(Sender: TObject);
begin
  if lCurrent.ItemIndex>=0 then
  begin
    if lSelected.Items.Indexof(lCurrent.Items[lCurrent.ItemIndex])=-1 then
    lSelected.Items.Add(lCurrent.Items[lCurrent.ItemIndex]);

    lCurrent.DeleteSelected;
  end;
end;

procedure TfMainBackup.lSelectedDblClick(Sender: TObject);
begin
  if lSelected.ItemIndex>=0 then
  begin
    if lCurrent.Items.Indexof(lSelected.Items[lSelected.ItemIndex])=-1 then
    lCurrent.Items.Add(lSelected.Items[lSelected.ItemIndex]);

    lSelected.DeleteSelected;
  end;
end;

function Fn_IniGet (Section, Ident : String; Default : String) : String ;
var IniFile :TIniFile;
    AppIni : String ;
begin
  AppIni:=ExtractFilePath(ParamStr(0));
  AppIni:=AppIni+'Set.ini';
  IniFile := TIniFile.Create(AppIni);
  Result := IniFile.ReadString(Section,Ident,Default) ;
  IniFile.UpdateFile ;
  IniFile.Free ;
end;

function Fn_IniSave(Section, Ident : String; Default : String) : String ;
var IniFile :TIniFile;
    AppIni : String ;
begin
  AppIni:=ExtractFilePath(ParamStr(0));
  AppIni:=AppIni+'Set.ini';
  IniFile := TIniFile.Create(AppIni);
  IniFile.WriteString(Section,Ident,Default) ;
  IniFile.UpdateFile ;
  IniFile.Free ;
end;


end.
