/*(3.)

Schreibt ein Update, welches in der Tabelle students alle Fächer mit 
dem Titel History in Geschichte umschreibt und gebt die geänderten IDs aus. 
/Writes an update that includes all subjects in the students table
with the title History in history and outputs the changed IDs.*/

DECLARE
TYPE student_typ is Table of students%ROWTYPE
    index by binary_integer;

temp_table student_typ ;
BEGIN
    SELECT *
    INTO temp_table
    FROM students
    WHERE MAJOR = 'History'; 
    
    FOR i IN temp_table.FIRST.. temp_table.LAST 
    LOOP
    UPDATE students  
    SET MAJOR = 'Geschichte'
    WHERE MAJOR = 'Hystory' ;
    RETURNING id BULK COLLECT INTO temp_table
    END LOOP;
END;

