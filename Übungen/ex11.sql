/*(3.)

CURSOR und FOR ... LOOP

Definiert einen Cursor, der alle Kurse und die maximalen Studenten aus der Tabelle classes selektiert.  /define a cursor which selects all courses and the maximum students from the classes table
Als Paramter soll der Cursor das Department erhalten können. /The cursor should be able to receive the department as a parameter.

Nutzt nun den Cursor in einer For Loop für die Abteilung 'MUS' /Now use the cursor in a for loop for the department 'MUS'
*/


DECLARE
   CURSOR cursor_name (department_name VARCHAR(20))
   IS 
   SELECT course, max_students 
   FROM classes;
   WHERE department = department_name;

BEGIN
   department_name := 'MUS';
   OPEN cursor_name(department_name);
   FOR i IN cursor_name('MUS')..department
   LOOP
      dbms_output.put_line(counter);
      COMMIT;
   END LOOP;
   CLOSE cursor_name;
END;
