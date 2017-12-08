program convert;
uses sysutils, types;
function Explode(delimiter:string; str:string): TStringDynArray;
var
  p, n, dsize:integer;
begin
  n := 0;
  dsize := length(delimiter);
  while true do begin
    p := pos(delimiter,str);
    if p > 0 then begin
      inc(n);
      SetLength(Result,n);
      Result[n-1] := copy(str,1,p-1);
      delete(str,1,p+dsize-1);
    end else break;
  end;
  inc(n);
  SetLength(Result,n);
  Result[n-1] := str;

end;
var
  linea: string;
  arcEnt, arcSal1, arcSal2: text;
  nomSal1, nomSal2: string;
  ruta, nombre, arcDat, arcDat2: string;
  a: TStringDynArray;
begin
  if ParamCount<>1 then begin
    writeln('=== Convert ===');
    writeln('Convierte los archivos de registro generados por el programa NILOTER-m,');
    writeln('en archivos de registro en el formato del programa Ciberplex. ');
    writeln('');
    writeln('EJEMPLO:');
    writeln('   convert CANADA.1_2017_08.log');
    writeln('');
    writeln('Divide este archivo *.log, en dos archivos:');
    writeln('    CANADA.2017_01.GENERAL.log');
    writeln('    CANADA.2017_01.Cabinas.log');
    writeln('Además busca el archivo *.dat: CANADA.1_2017_01.dat y lo renombra a:');
    writeln('    CANADA.2017_02.NILO-m.log');
    readln;
    exit;
  end;
  if not FileExists(ParamStr(1)) then begin
    writeln('   No se encuentra archivo.');
    readln;
    exit;
  end;
  ruta := ExtractFileDir(ExpandFileName(ParamStr(1)));
  nombre := ExtractFileName(ParamStr(1));

  a := explode('.', nombre);
  if high(a) <> 2 then begin
    writeln('   Error en nombre de archivo.');
    readln;
    exit;
  end;
  nomSal1 := ruta + '\' + a[0] + '.' + copy(a[1],3,7) + '.GENERAL.log';
  nomSal2 := ruta + '\' + a[0] + '.' + copy(a[1],3,7) + '.Cabinas.log';
  //Debe obtener como nombre CANADA.2017_08.GENERAL.log
  writeln(nomSal1);
  writeln(nomSal2);

  AssignFile(arcEnt, ParamStr(1));
  AssignFile(arcSal1, nomSal1);
  AssignFile(arcSal2, nomSal2);
  Reset(arcEnt);
  Rewrite(arcSal1);
  Rewrite(arcSal2);
  while not eof(arcEnt) do begin
    Readln(arcEnt, linea);
    if (copy(linea, 1, 2) = 'p:') or (copy(linea, 1, 2) = 'q:') then begin
      //Archivo de internet
      Writeln(arcSal2, linea);
    end else begin
      Writeln(arcSal1, linea);
    end;
  end;
  CloseFile(arcEnt);
  CloseFile(arcSal1);
  CloseFile(arcSal2);
  //Elimina archivo anterior
  erase(arcEnt);

  //Renombra también el archivo de *.dat del locutorio
  arcDat := ruta + '\' + a[0] + '.1_' + copy(a[1],3,7) + '.dat';
  arcDat2:= ruta + '\' + a[0] + '.' + copy(a[1],3,7) + '.NILO-m.log';
  writeln(arcDat2);  //muestra archivo
  if FileExists(arcDat) then begin
    //Renombra también el archivo de *.dat del locutorio
    RenameFile(arcDat, arcDat2);
  end else begin
    writeln('   No se encuentra archivo *.dat: ' + arcDat);
    readln;
    exit;
  end;
  writeln('<< Pulse "enter" para continuar>>');
  Readln;
end.

