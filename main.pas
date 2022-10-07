unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  StdCtrls, ZConnection, ZDataset;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnWegschrijven: TButton;
    conn: TZConnection;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    dsTracks: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsDiscs: TDataSource;
    tblDiscs: TZTable;
    tblTracks: TZTable;
    procedure btnWegschrijvenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnWegschrijvenClick(Sender: TObject);
begin
  tblDiscs.ApplyUpdates;
  tblTracks.ApplyUpdates;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  tblTracks.Active := False;
  tblDiscs.Active := False;
  conn.Connected := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  conn.Connected := True;
  tblDiscs.Active := True;
  tblTracks.Active := True;
end;

end.

