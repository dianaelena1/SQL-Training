/*Übung 6 - PL/SQL Tables

(1.)

Baut eine PL/SQL Tabelle auf, die der Struktur der Tabelle 'students' entspricht. /Builds a PL/SQL table that has the structure of the 'students' table
Nutzt dazu den Rowtype. /Use the rowtype for this.
Lest den Datensatz 10001 der Tabelle 'students' in die PL/SQL Tabelle ein. /Reads record 10001 of the 'students' table into the PL/SQL table.
Und gebt nun der Vornamen und Nachnamen des Studenten aus. /And now output the student's first name and last name. */

declare
type student_typ is Table of students%ROWTYPE
    index by binary_integer;
table_typ student_typ ;
begin
Select * into table_typ(10001)
from students
where id = 10001;
dbms_output.put_line(table_typ(10001).first_name || ' ' || table_typ(10001).last_name);
end;
      
