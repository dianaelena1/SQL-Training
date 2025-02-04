/*(2.)

User Defined Exceptions

Definiert eine Exception, die anspringt, wenn es mehr Anmeldungen für den History Kurs 101 gibt als Plätze. /Defines an exception that is thrown if there are more registrations for the history course 101 than places.
Fangt nun diese Exception beim Select ab. /Now catch this exception on the select.
Speichert in diesem Fall eine Fehlermeldung in das Infofeld der Tabelle 'log_table'. /In this case, saves an error message in the info field of the table 'log_table'. */

DECLARE
  exception_name EXCEPTION; 
   -- Current number of students registered for HIS-101
   v_currentstudents NUMBER(3);
   -- Maximum number of students allowed in HIS-101
   v_maxstudents NUMBER(3);
BEGIN
   -- set new count of current students
   UPDATE CLASSES
      SET current_students = 35
    WHERE department = 'HIS'
      AND course = 101;
      
 -- Find the current number of registered students, and the maximum number of students allowed. 
   SELECT current_students
        , max_students
     INTO v_currentstudents
        , v_maxstudents
     FROM CLASSES
    WHERE department = 'HIS'
      AND course = 101;
    if v_currentstudents > v_maxstudents then
        raise exception_name;
    end if;
EXCEPTION 
    WHEN exception_name THEN
    dbms_output.put_line('too many students');
END;


