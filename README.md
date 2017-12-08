# NILOTERaCiberplex
Programa de conversión de registros de NILOTER-m a registros de Ciberplex

Este aplicativo para Windows, convierte los archivos de registro de los programas NILOTER-m, al formato de los registros del programa CIBERPLEX de las versiones 1.7.X (tablas históricas).
CIBERPLEX usa un formato similar a NILOTER-m, pero los nombres de los archivos de registro son diferentes (todos son *.log) y además en  los registros de las cabinas, están separados en otro archivo.

EJEMPLO:
   convert CANADA.1_2017_08.log

Divide este archivo *.log, en dos archivos:
    CANADA.2017_01.GENERAL.log
    CANADA.2017_01.Cabinas.log
Además busca el archivo *.dat: CANADA.1_2017_01.dat y lo renombra a:
    CANADA.2017_02.NILO-m.log
    
Este programa es útil para cuando se quiere hacer una migración de NILOTER-m a CIBERPLEX
