unit Connections;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfConnections = class(TForm)
    eServer: TEdit;
    eUser: TEdit;
    ePw: TEdit;
    BtnTest: TButton;
    BtnClose: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure cxButton3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConnections: TfConnections;

implementation

{$R *.dfm}

uses MainBackup;



procedure TfConnections.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfConnections.BtnTestClick(Sender: TObject);
begin
  Try
  with fMainBackup do
  begin
    ADOConnection1.Close;

    if ePw.Text<>'' then
    ADOConnection1.ConnectionString :='Provider=SQLOLEDB.1;Password='+ePw.Text+';Persist Security Info=True;User ID='+eUser.Text+';Initial Catalog=master;Data Source='+eServer.Text
    Else
    ADOConnection1.ConnectionString :='Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;User ID=SA;Initial Catalog=master;Data Source='+eServer.Text;

    ADOConnection1.Open();
    ShowMessage('Connected Successfully');
    Fn_IniSave('Connection','Server',eServer.Text);
    Fn_IniSave('Connection','User',eUser.Text);
    Fn_IniSave('Connection','Pw',ePw.Text);
  end;
  Except on e:exception do
  begin
    ShowMessage('Connection Error '+#13+e.Message);
    Exit;
  end;
  End;

end;

procedure TfConnections.cxButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TfConnections.FormShow(Sender: TObject);
begin
    eServer.Text:=Fn_IniGet('Connection','Server','');
    eUser.Text:=Fn_IniGet('Connection','User','');
    ePw.Text:=Fn_IniGet('Connection','Pw','');
end;

end.
