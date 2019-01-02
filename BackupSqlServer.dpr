program BackupSqlServer;

uses
  Vcl.Forms,
  MainBackup in 'MainBackup.pas' {fMainBackup},
  Connections in 'Connections.pas' {fConnections},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Metropolis UI Blue');
  Application.CreateForm(TfMainBackup, fMainBackup);
  Application.Run;
end.
