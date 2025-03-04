/*�bung 8 - Packages

(1.)

Erstellt f�r den folgenden Package Rumpf die entsprechende Kopfdefinition. /Creates the corresponding head definition for the following package body.
Es sollen die Prozeduren ClassList, AddStudent, RemoveStudent von aussen
sichtbar sein. /The procedures ClassList, AddStudent, RemoveStudent should be used from the outside
being visible. */

CREATE PACKAGE ClassPackage AS
    PROCEDURE AddStudent (p_StudentID IN NUMBER,
                          p_Department IN VARCHAR2,
                          p_Course IN VARCHAR2);
END ClassPackage;

CREATE OR REPLACE PACKAGE BODY ClassPackage AS
  -- Add a new student for the specified class.
  PROCEDURE AddStudent(p_StudentID  IN students.id%TYPE,
                       p_Department IN classes.department%TYPE,
                       p_Course     IN classes.course%TYPE) IS
  BEGIN
    INSERT INTO registered_students (student_id, department, course)
      VALUES (p_StudentID, p_Department, p_Course);
  END AddStudent;

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
  END RemoveStudent;

  -- Returns a PL/SQL table containing the students currently
  -- in the specified class.
  PROCEDURE ClassList(p_Department  IN  classes.department%TYPE,
                      p_Course      IN  classes.course%TYPE,
                      p_IDs         OUT t_StudentIDTable,
                      p_NumStudents IN OUT BINARY_INTEGER) IS

    v_StudentID  registered_students.student_id%TYPE;

    -- Local cursor to fetch the registered students.
    CURSOR c_RegisteredStudents IS
      SELECT student_id
        FROM registered_students
        WHERE department = p_Department
        AND course = p_Course;
  BEGIN
    /* p_NumStudents will be the table index. It will start at
     * 0, and be incremented each time through the fetch loop.
     * At the end of the loop, it will have the number of rows
     * fetched, and therefore the number of rows returned in
     * p_IDs.
     */
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
