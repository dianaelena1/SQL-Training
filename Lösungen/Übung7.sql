Übung 7 - Funktionen und Prozeduren

(1.)

Erstellt eine Funktion, die berechnet, ob ein Kurs belegt ist.
Die Daten befinden sich in der Tabelle 'classes'.
Als Paramter soll die Abteilung (department) und die Kursnummer (course) übergeben werden können.
Ab einer Belegung über 80 Prozent gilt der Kurs als Belegt und die Funktion soll TRUE zurückgeben, 
im anderen Fall FALSE. (current_students, max_students zur Berechnung verwenden).

set serveroutput on
CREATE OR REPLACE FUNCTION KursBelegt (
  p_Department IN classes.department%TYPE,
  p_Course     IN classes.course%TYPE)
  RETURN BOOLEAN IS

  v_CurrentStudents NUMBER;
  v_MaxStudents     NUMBER;
  v_ReturnValue     BOOLEAN := FALSE;
  v_FullPercent     CONSTANT NUMBER := 80;
BEGIN
  -- Get the current and maximum students for the requested
  -- course.
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM classes
    WHERE department = p_Department
    AND course = p_Course;

  -- If the class is more full than the percentage given by
  -- v_FullPercent, return TRUE. Otherwise, return FALSE.
  IF (v_CurrentStudents / v_MaxStudents * 100) >= v_FullPercent THEN
    v_ReturnValue := TRUE;
  END IF;

  RETURN v_ReturnValue;
END KursBelegt;
/
-- Variation 1
CREATE OR REPLACE FUNCTION KursBelegt (
  p_Department IN classes.department%TYPE,
  p_Course     IN classes.course%TYPE)
  RETURN BOOLEAN IS
  v_percent     number;
BEGIN
  SELECT 100/c.MAX_STUDENTS*c.CURRENT_STUDENTS
    INTO v_percent
    FROM classes c
    WHERE c.department = p_Department
    AND c.course = p_Course;
  if v_percent>80 then
    return true;
  end if;
  RETURN false;
END KursBelegt;
/

CREATE OR REPLACE FUNCTION KursBelegtTxt (
  p_Department IN classes.department%TYPE,
  p_Course     IN classes.course%TYPE)
  RETURN VARCHAR2 IS

BEGIN
  if KursBelegt(p_Department,p_Course) then
     RETURN('Kurs bereits belegt');
  end if;
  RETURN('Kurs noch frei');
  
END KursBelegtTxt;
/
BEGIN
  if KursBelegt('HIS',301) then
     DBMS_OUTPUT.PUT_LINE('Kurs bereits belegt');
  else
     DBMS_OUTPUT.PUT_LINE('Kurs noch frei');
  end if;
END;

    SELECT DEPARTMENT,
           COURSE,
           KURSBELEGTTXT(DEPARTMENT,COURSE) AS BELEGUNG,
           DESCRIPTION,
           current_students, max_students
           
    FROM classes


(2.)

Erstellt eine Prozedur 'AddNewStudent', die einen neuen Studenten in die Tabelle 'students' einträgt.
Die Prozedur soll drei Parameter erhalten (Vorname, Nachname und Hauptfach), welche in die
Felder first_name, last_name und major eingetragen werden sollen.
Die neue ID berechnet soll über student_sequence.nextval berechnet werden. current_credits
sind mit 0 zu belegen.

CREATE OR REPLACE PROCEDURE AddNewStudent (
  p_FirstName  IN OUT students.first_name%TYPE,
  p_LastName   IN OUT students.last_name%TYPE,
  p_Major      IN OUT students.major%TYPE) AS
BEGIN
  -- Insert a new row in the students table. Use
  -- student_sequence to generate the new student ID, and
  -- 0 for current_credits.
  INSERT INTO students (ID, first_name, last_name,
                        major, current_credits)
    VALUES (student_sequence.nextval, p_FirstName, p_LastName,
            p_Major, 0);
    p_FirstName := 'STEPHAN';        
EXCEPTION
   WHEN others
   THEN
      INSERT INTO LOG_TABLE (message, info)
           VALUES ('TESTS', 'Prozedur AddNewStudent fehlerhaft beendet');
END AddNewStudent;
/

DECLARE
  l_FirstName  students.first_name%TYPE := 'Zelda';
  l_LastName   students.last_name%TYPE  := 'Zudnik';
  l_Major      students.major%TYPE      := 'Computer Science';

BEGIN
  AddNewStudent(l_FirstName, 'STEPHAN', l_Major);
  DBMS_OUTPUT.PUT_LINE(l_FirstName||' '||l_LastName||' '||l_Major);
END;
/

SELECT * FROM students;
ROLLBACK;

-- aus Übung 9
/*DECLARE
  L_KURS FEHLERHANDL.t_kursliste;
BEGIN
  FOR J IN 1..20 LOOP
    DBMS_OUTPUT.PUT_LINE('Prüfung für : '||j*5||'%');
    IF FEHLERHANDL.LISTKURSVOLL(j*5,L_KURS) THEN
      DBMS_OUTPUT.PUT_LINE('LISTENANZAHL: '||L_KURS.COUNT);
      FOR I IN L_KURS.FIRST..L_KURS.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(L_KURS(I));
      END LOOP;
    END IF;
  END LOOP;
END;

DECLARE
  L_KURS FEHLERHANDL.t_kursliste;
BEGIN
  studverw.regstudent(10020);
end;
*/