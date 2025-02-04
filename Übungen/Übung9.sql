/*Übung 9 - Abschluß

Legt bitte zwei Packages an.

Package 1: Verwaltung der Studenten /administration of the students
    Exception-Handling durch Aufruf der Prozedur in Package 2. /Exception handling by calling the procedure in Package 2.
    Funktion 1: Anlegen eines Studenten mit Name, Vorname und Hauptfach /Create a student with last name, first name and major
                Rückgabe der neuen ID; /return the new ID;
    Prozedur 2: Registrieren des Studenten in allen Kursen, die seinem /Enroll the student in all courses related to his
                Hauptfach entsprechen /correspond to the main subject
                
Package 2: Fehlerhandling /error handling
    Prozedur 1: Speichern einer Fehlermeldung in die Log-Tabelle /Saving an error message in the log table
    Funktion 2: Ermittle alle Kurse, die eine Belegung über einen Wert (Paramter!) haben, Rückgabe True, wenn welche gefunden, sonst False 
    /Identify all courses that have a booking over a have a value (parameter!), returns true if any are found, otherwise False
    
    package1 -students
    package2 -classes
*/

DECLARE
id_Student classpackage.t_studentidtable;
v_anzahl binary_integer;
v_first_name students.first_name%TYPE;
v_last_name students.last_name%TYPE;
v_major students.major%TYPE;

BEGIN
  classpackage.addstudent(p_first_name => 'Diana',   p_last_name => 'Elena',   p_major => 'Computer Science');
  classpackage.classlist('Diana',   'Elena',   id_Student,   v_anzahl);
  DBMS_OUTPUT.PUT_LINE('Der Kurs ist Belegung über' || to_char(v_anzahl) || ' Teilnehmern belegt.');
  FOR i IN id_Student.FIRST .. id_Student.LAST
  LOOP
    SELECT first_name, last_name, major
    INTO   v_first_name, v_last_name, v_major
    FROM   students
    WHERE id = id_Student(i);
    DBMS_OUTPUT.PUT_LINE(v_klasse(i) || ' ' || v_first_name || ' ' || v_last_name);
  END LOOP;
END;                

CREATE OR REPLACE PACKAGE ClassPackage1 AS
  -- Add a new student into the specified class.
  CREATE OR REPLACE FUNCTION AddStudent(
                            p_first_name  IN students.first_name%TYPE, 
                            p_last_name   IN students.last_name%TYPE,
                            p_major       IN students.major%TYPE);
  RETURN NUMBER
  AS 
     id_Student NUMBER := 0;
  RETURN id_Student;
  END AddStudent;

  -- Returns a PL/SQL table containing the students currently
  -- in the specified class.
  PROCEDURE EnrollStudent(p_Student     IN t_StudentIDTable,
                          p_first_name  IN students.first_name%TYPE) IS
  END EnrollStudent;
  
CREATE OR REPLACE PACKAGE BODY ClassPackage1 AS
  PROCEDURE EnrollStudent(p_Student     IN t_StudentIDTable,
                          p_first_name  IN students.first_name%TYPE) IS
  BEGIN
    INSERT INTO registered_students (p_Student, first_name, last_name, major)
      VALUES (p_StudentID, p_first_name, p_last_name, p_major);
  END AddStudent;

  -- Add a new student for the specified class.
  PROCEDURE AddStudent(p_StudentID  IN students.id%TYPE,
                       p_Department IN classes.department%TYPE,
                       p_Course     IN classes.course%TYPE) IS
  BEGIN
    INSERT INTO registered_students (student_id, department, course)
      VALUES (p_StudentID, p_Department, p_Course);
  END AddStudent;
END ClassPackage1;
  
CREATE OR REPLACE PACKAGE ClassPackage2 AS
  -- Add a new student into the specified class.
  PROCEDURE AddStudent(p_StudentID  IN students.id%TYPE,
                       p_Department IN classes.department%TYPE,
                       p_Course     IN classes.course%TYPE);

  -- Removes the specified student from the specified class.
  PROCEDURE RemoveStudent(p_StudentID  IN students.id%TYPE,
                          p_Department IN classes.department%TYPE,
                          p_Course     IN classes.course%TYPE);

  -- Exception raised by RemoveStudent.
  e_StudentNotRegistered EXCEPTION;

  -- Table type used to hold student info.
  TYPE t_StudentIDTable IS TABLE OF registered_students.student_id%TYPE
    INDEX BY BINARY_INTEGER;

  -- Returns a PL/SQL table containing the students currently
  -- in the specified class.
  PROCEDURE ClassList(p_Department  IN  classes.department%TYPE,
                      p_Course      IN  classes.course%TYPE,
                      p_IDs         OUT t_StudentIDTable,
                      p_NumStudents IN OUT BINARY_INTEGER);
END ClassPackage;
/

CREATE OR REPLACE PACKAGE BODY ClassPackage2 AS
  -- Add a new student for the specified class.


  -- Removes the specified student from the specified class.
  PROCEDURE RemoveStudent(p_StudentID  IN students.id%TYPE,
                          p_Department IN classes.department%TYPE,
                          p_Course     IN classes.course%TYPE) IS
  BEGIN
    DELETE FROM registered_students
      WHERE student_id = p_StudentID
      AND department = p_Department
      AND course = p_Course;

    -- Check to see if the DELETE operation was successful. If
    -- it didn't match any rows, raise an error.
    IF SQL%NOTFOUND THEN
      RAISE e_StudentNotRegistered;
    END IF;
  EXCEPTION
    WHEN e_StudentNotRegistered THEN
      RAISE;
  END RemoveStudent;
END ClassPackage2;


