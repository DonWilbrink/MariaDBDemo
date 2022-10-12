unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  StdCtrls, LR_DBSet, LR_Class, LR_Desgn, PrintersDlgs, ZConnection, ZDataset,
  Printers;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    conn: TZConnection;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    dsTracks: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    dsDiscs: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    frDesigner1: TfrDesigner;
    frReport1: TfrReport;
    PrintDialog1: TPrintDialog;
    tblDiscs: TZTable;
    tblTracks: TZTable;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure tblDiscsAfterPost(DataSet: TDataSet);
    procedure tblTracksAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  tblTracks.Active := False;
  tblDiscs.Active := False;
  conn.Connected := False;
  CloseAction := caFree;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  frReport1.LoadFromFile('Platenoverzicht.lrf');
  frReport1.ShowReport;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  FromPage, ToPage, NumberCopies: Integer;
  ind: Integer;
  Collap: Boolean;
  AppDirectory: string;
begin
  // Load report definition from application directory
  AppDirectory:=ExtractFilePath(ParamStr(0));
  frReport1.LoadFromFile('Platenoverzicht.lrf');
  // Need to keep track of which printer was originally selected to check for user changes
  ind:= Printer.PrinterIndex;
  // Prepare the report and just stop if we hit an error as continuing makes no sense
  if not frReport1.PrepareReport then Exit;
  // Set up dialog with some sensible defaults which user can change
  with PrintDialog1 do
  begin
    Options:=[poPageNums ]; // allows selecting pages/page numbers
    Copies:=1;
    Collate:=true; // ordened copies
    FromPage:=1; // start page
    ToPage:=frReport1.EMFPages.Count; // last page
    MaxPage:=frReport1.EMFPages.Count; // maximum allowed number of pages
    if Execute then // show dialog; if succesful, process user feedback
    begin
      if (Printer.PrinterIndex <> ind ) // verify if selected printer has changed
        or frReport1.CanRebuild // ... only makes sense if we can reformat the report
        or frReport1.ChangePrinter(ind, Printer.PrinterIndex) //... then change printer
        then
        frReport1.PrepareReport //... and reformat for new printer
      else
        exit; // we couldn't honour the printer change

      if PrintDialog1.PrintRange = prPageNums then // user made page range selection
      begin
        FromPage:=PrintDialog1.FromPage; // first page
        ToPage:=PrintDialog1.ToPage;  // last page
      end;
      NumberCopies:=PrintDialog1.Copies; // number of copies
      // Print the report using the supplied pages & copies
      frReport1.PrintPreparedReport(inttostr(FromPage)+'-'+inttostr(ToPage), NumberCopies);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  frReport1.LoadFromFile('Platenoverzicht.lrf');
  frReport1.DesignReport;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  conn.Connected := True;
  tblDiscs.Active := True;
  tblTracks.Active := True;
end;

procedure TForm1.tblDiscsAfterPost(DataSet: TDataSet);
begin
  tblDiscs.ApplyUpdates;
end;

procedure TForm1.tblTracksAfterPost(DataSet: TDataSet);
begin
  tblTracks.ApplyUpdates;
end;

end.

