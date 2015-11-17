unit SaveToXlsUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  Data.DB, cxDBData, Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZAbstractConnection,
  ZConnection, cxGridExportLink, cxCurrencyEdit;

type
  TForm1 = class(TForm)
    ZConnection1: TZConnection;
    qryUnit: TZQuery;
    DataSource1: TDataSource;
    qryPrice: TZQuery;
    Timer1: TTimer;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    clGoodsCode: TcxGridDBColumn;
    clGoodsName: TcxGridDBColumn;
    clPrice: TcxGridDBColumn;
    clDateChange: TcxGridDBColumn;
    clMCSValue: TcxGridDBColumn;
    clMCSDateChange: TcxGridDBColumn;
    clisErased: TcxGridDBColumn;
    clMCSIsClose: TcxGridDBColumn;
    clMCSNotRecalc: TcxGridDBColumn;
    colRemains: TcxGridDBColumn;
    colFix: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Add_Log(AMessage:String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  strUtils, IniFiles;

procedure TForm1.Add_Log(AMessage: String);
var
  F: TextFile;

begin
  try
    AssignFile(F,ChangeFileExt(Application.ExeName,'.log'));
    if not fileExists(ChangeFileExt(Application.ExeName,'.log')) then
      Rewrite(F)
    else
      Append(F);
  try
    Writeln(F,FormatDateTime('YYYY.MM.DD hh:mm:ss',now)+' - '+AMessage);
  finally
    CloseFile(F);
  end;
  except
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  timer1.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  SavePath: String;
  FileName: String;
  ini: TIniFile;
  function GetCorrectNameFile(AName: String): String;
  var
    j: Integer;
  Begin
    for j := 1 to length(AName) do
      if CharInSet(AName[j],[' ','\','/',':','*','?','''','"','<','>','|']) then
        AName[j] := '_';
    Result := AName;
  End;
begin
  ini := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    SavePath := ini.readString('Options','Path','D:\������\');
    ini.WriteString('Options','Path',SavePath);

    ZConnection1.Database := ini.ReadString('Connect','DataBase','farmacy');
    ini.WriteString('Connect','DataBase',ZConnection1.Database);

    ZConnection1.HostName := ini.ReadString('Connect','HostName','91.210.37.210');
    ini.WriteString('Connect','HostName',ZConnection1.HostName);

    ZConnection1.User := ini.ReadString('Connect','User','postgres');
    ini.WriteString('Connect','User',ZConnection1.User);

    ZConnection1.Password := ini.ReadString('Connect','Password','postgres');
    ini.WriteString('Connect','Password',ZConnection1.Password);
  finally
    ini.free;
  end;
  Timer1.Enabled := False;
  ZConnection1.LibraryLocation := ExtractFilePath(Application.ExeName)+'libpq.dll';
  try
    Add_Log('������ ��������');
    if not ForceDirectories(SavePath) then
    Begin
      Add_Log('�� ���� ������� ���������� ��������');
      exit;
    end;

    try
      ZConnection1.Connect;
    Except ON E:Exception do
    Begin
      Add_Log(E.Message);
      Exit;
    End;
    end;
    try
      qryUnit.Open;
    except ON E:Exception DO
    Begin
      Add_Log(E.Message);
      Exit;
    End;
    end;
    qryUnit.First;
    while not qryUnit.Eof do
    Begin
      qryPrice.Close;
      qryPrice.SQL.Text := 'Select * from gpSelect_Object_Price('+qryUnit.FieldByName('Id').AsString+',False,False,''3'');';
      try
        qryPrice.Open;
      except on E: Exception do
        Begin
          Add_Log(E.Message);
        End;
      end;
      if not qryPrice.IsEmpty then
      Begin
        FileName := SavePath + GetCorrectNameFile(qryUnit.fieldByName('ValueData').AsString)+'.xls';
        try
          ExportGridToExcel(FileName, cxGrid, True, True, True, 'xls');
        except on E:Exception DO
          Begin
            Add_Log(E.Message);
          end;
        end;
      End;
      qryUnit.Next;
    End;
  finally
    Close;
  end;
end;

end.