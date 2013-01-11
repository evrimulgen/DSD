﻿unit DataBaseStructureTestUnit;

interface

uses TestFramework, ZConnection, ZDataset;

type
  TCheckDataBaseStructure = class (TTestCase)
  private
    ZConnection: TZConnection;
    ZQuery: TZQuery;
  protected
    // подготавливаем данные для тестирования
    procedure SetUp; override;
    // возвращаем данные для тестирования
    procedure TearDown; override;
  published
    procedure CreateType;
    procedure CreateObject;
  end;

implementation

{ TCheckDataBaseStructure }

const
  StructurePath = '..\DATABASE\STRUCTURE\';

procedure TCheckDataBaseStructure.CreateObject;
begin
  ZQuery.SQL.LoadFromFile(StructurePath + 'Object\ObjectDesc.sql');
  ZQuery.ExecSQL;
  ZQuery.SQL.LoadFromFile(StructurePath + 'Object\Objects.sql');
  ZQuery.ExecSQL;
end;

procedure TCheckDataBaseStructure.CreateType;
begin
  ZQuery.SQL.LoadFromFile(StructurePath + 'Type\CreateType.sql');
  ZQuery.ExecSQL;
end;

procedure TCheckDataBaseStructure.SetUp;
begin
  inherited;
  ZConnection := TZConnection.Create(nil);
  ZConnection.HostName := 'localhost';
  ZConnection.Port := 5432;
  ZConnection.Protocol := 'postgresql-9';
  ZConnection.User := 'postgres';
  ZConnection.Database := 'dsd';
  ZConnection.Connected := true;
  ZQuery := TZQuery.Create(nil);
  ZQuery.Connection := ZConnection;

end;

procedure TCheckDataBaseStructure.TearDown;
begin
  inherited;

end;

initialization
  TestFramework.RegisterTest('DataBaseStructure', TCheckDataBaseStructure.Suite);

end.
