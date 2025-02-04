/*(2.)

Schreibt nun einen anonymen Block, der den Studenten Barbara Blues in die Klasse Nutrition 307 aufnimmt. /Now write an anonymous block that the student Barbara Blues in the Records class Nutrition 307.
Listen alle Teilnehmer des Kurses Nutrition 307 auf. Nutzt dazu das eben erzeugte Package. /List all participants in the Nutrition 307 course. Use the package you just created.*/

CREATE OR REPLACE PACKAGE ClassPackage AS
    PROCEDURE AddStudent(p_StudentID IN students.id%TYPE,
                          p_Department IN classes.department%TYPE,
                          p_Course IN VARCHAR2);
    type t_StudentIDTable is table of registered_students.student_id%TYPE;
    exception_name EXCEPTION;

END ClassPackage;

CREATE OR REPLACE PACKAGE BODY ClassPackage AS
  PROCEDURE AddStudent(p_StudentID  IN students.id%TYPE,
                       p_Department IN classes.department%TYPE,
                       p_Course     IN classes.course%TYPE) IS
        
  BEGIN
    INSERT INTO registered_students (student_id, department, course)
      VALUES (p_StudentID, p_Department, p_Course);
  END AddStudent;
  PROCEDURE RemoveStudent(p_StudentID  IN students.id%TYPE,
                          p_Department IN classes.department%TYPE,
                          p_Course     IN classes.course%TYPE) IS
  BEGIN
    DELETE FROM registered_students
      WHERE student_id = p_StudentID
      AND department = p_Department
      AND course = p_Course;

    IF SQL%NOTFOUND THEN
      RAISE e_StudentNotRegistered;
    END IF;
EXCEPTION 
    WHEN exception_name THEN
    dbms_output.put_line('no data found');
  END RemoveStudent;

  PROCEDURE ClassList(p_Department  IN  classes.department%TYPE,
                      p_Course      IN  classes.course%TYPE,
                      p_IDs         OUT t_StudentIDTable,
                      p_NumStudents IN OUT BINARY_INTEGER) IS
    v_StudentID registered_students.student_id%TYPE;

    CURSOR c_RegisteredStudents IS
      SELECT student_id
        FROM registered_students
        WHERE department = p_Department
        AND course = p_Course;
  BEGIN
    p_NumStudents := 0;
    OPEN c_RegisteredStudents;
    LOOP
      FETCH c_RegisteredStudents INTO v_StudentID;
      EXIT WHEN c_RegisteredStudents%NOTFOUND;

      p_NumStudents := p_NumStudents + 1;
      p_IDs(p_NumStudents) := v_StudentID;
    END LOOP;
  END ClassList;
END ClassPackage;

DECLARE
v_klasse classpackage.t_studentidtable;
v_anzahl binary_integer;
v_first_name students.first_name%type;
v_last_name students.last_name%type;
BEGIN
classpackage.addstudent(p_Department => 'NUT', P-course => 307,  p_studentid => 10006);
classpackage.classlist('NUT', 307, v_klasse, v_anzahl);
FOR i IN v_klasse.FIRST .. v_klasse.LAST
LOOP
    SELECT first_name, last_name
    INTO v_first_name, v_last_name
    FROM students
    WHERE id = v_klasse(i);
END LOOP;
END;
