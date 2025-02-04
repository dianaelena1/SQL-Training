/*(2.)

Baut eine PL/SQL Tabelle auf, in der Ihr Zahlen (Number) abspeichern könnt./Build a PL/SQL table in which you can store numbers (Number).
Füllt diese mit den Werten 10, 20, 30, ..., 100. /Fill it with the values ??10, 20, 30, ..., 100.
Löscht nun den Eintrag mit dem Index 5. /Now delete the entry with index 5.
Durchlauft die Tabelle ein zweites mal und gebt die Werte aus. /Run through the table a second time and output the values.
(Achtet darauf, das ihr mögliche Fehler abfangt.) /
(Make sure you catch any mistakes.) */

DECLARE
    type student_typ is Table of NUMBER;
    exception_name EXCEPTION; 
    temp_table student_typ;

BEGIN
    FOR l_counter IN 1..10 LOOP
      dbms_output.put_line(l_counter);
      temp_table(l_counter) := l_counter * 10;
    END LOOP;
    
    temp_table(5).delete;
    FOR element IN temp_table.FIRST.. temp_table.LAST
    LOOP
    dbms_output.put_line(element);
    
    IF temp_table.FIRST > temp_table.LAST THEN
        RAISE exception_name;
    END IF;
    END LOOP;
EXCEPTION 
    WHEN exception_name THEN
    dbms_output.put_line('too many values');
END;

