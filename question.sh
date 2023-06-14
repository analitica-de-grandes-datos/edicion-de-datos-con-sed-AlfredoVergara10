#
#  LAB: Transformación de archivos con `sed`
#  ================================================
#
#  Una tarea común en Analytics es el procesamiento de archivos en bruto para que puedan 
#  ser usados en otros procesos, donde gran parte de dicho procesamiento corresponde a la 
#  transforamción del formato. Estos archivos suelen tener millones de registros por lo que 
#  la aplicación de procedimientos manuales no es práctica.
#  
#  El archivo `data.csv` contiene una muestra de los archivos generados automáticamente 
#  por un software. El archivo contiene cuatro (4) columnas, donde los valores válidos
#  para los campos son los siguientes:
#  
#  * Columna 1: `DD/MM/AA`.
#  * Columna 2: `A`, `B`, `C`. `\N` indica NULL.
#  * Columna 3: Número entero. `\N` indica NULL.
#  * Columna 4: Número decimal. `\N` indica NULL.
#  
#  
#  Usted debe escribir un script en bash que use sed para que realice 
#  las siguientes acciones:
#    
#  * Convierta el formato de las fechas de DD/MM/YY a YYYY-MM-DD.
#  
#  * Transforme el archivo para que todos los campos nulos aparezcan como `\N`.
#  
#  * Reemplace los `;` por `,`.
#  
#  * Use el `.` para indicar decimales.
#
#  El resultado del script se escribe en pantalla.
#
#  El programa se llamara por el evaluador tal como se indica a continuación:
#
#  $ bash question.sh data.csv > output.csv
#  
#  Rta/
#  2013-03-12,A,1,100.0
#  ...
#  2014-09-01,A,3,100.4
#
#  >>> Escriba su codigo a partir de este punto <<<
#

# Convertir el año de "YY" a "YYYY".
sed 's/\/\([0-9][0-9]\);/\/20\1;/g' data.csv > data-0.csv
# Convertir el mes de "M" a "MM".
sed 's/\/\([0-9]\)\//\/0\1\//g' data-0.csv > data-1.csv
# Convertir el día de "D" a "DD".
sed ':a;N;$!ba;s/\n\([0-9]\)\//\n0\1\//g' data-1.csv > data-2.csv
# Convertir las fechas de "DD/MM/YY" a "YYYY-MM-DD".
sed 's/\([0-9][0-9]\)\/\([0-9][0-9]\)\/\(20[0-9][0-9]\)/\3\-\2\-\1/g' data-2.csv > data-3.csv
# Transformar todas las coincidiencias nulas entre ";" y ";" a ";\N;".
sed 's/\(;N;\)\|\(;;\)\|\(;\\n;\)/;\\N;/g' data-3.csv > data-4.csv
# Transformar todas las coincidencias nulas entre ";" y "\r" a "\N\r".
sed 's/\(;\)\r\|\(;n\)\r/;\\N/g' data-4.csv > data-5.csv
# Reemplazar coma decimal (",") por punto decimal (".").
sed 's/\(,\)/./g' data-5.csv > data-6.csv
# Reemplazar punto y comas (";") por comas (",").
sed 's/\(;\)/,/g' data-6.csv > data-7.csv
# Transformar todos los valores de la columna 2 a letras en mayúscula.
sed 's/\([a-z]\)/\U&/g' data-7.csv > output.csv
