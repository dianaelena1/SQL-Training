Übung 5 - Fehlerbehandlung

(1.)

Abfangen auf Grund von Standard Exceptions

Im Folgenden anonymen Block werden vier Inserts ausgeführt.
Für zwei Fehler existieren Standard Fehlermeldungen, für eine nicht.
Bitte fangt die Fehler ab und gebt einen eigenen Text und den Error-Code aus.

set serveroutput on
BEGIN
   INSERT INTO STUDENTS
               (id
              , first_name
              , last_name)
        VALUES (20000
              , 'John'
              , 'Smith');

/*    INSERT INTO STUDENTS
               (id
              , first_name
              , last_name)
        VALUES (20000
              , 'Susan'
              , 'Ryan');*/

/*   INSERT INTO STUDENTS
               (id
              , first_name
              , last_name)
        VALUES ('A1'
              , 'Susan'
              , 'Ryan');*/

   INSERT INTO STUDENTS
               (id
              , first_name
              , last_name)
        VALUES (2001
              , 'Susan Peggy Amanda Lisa'
              , 'Bryce');

   INSERT INTO STUDENTS
               (id
              , first_name
              , last_name)
      SELECT id
           , first_name
           , last_name
        FROM STUDENTS
       WHERE id = 1000000;
    ROLLBACK;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      DBMS_OUTPUT.put_line('Eintrag bereits vorhanden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
   WHEN INVALID_NUMBER
   then
      DBMS_OUTPUT.put_line('Ungültige Daten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.put_line('Keine Daten gefunden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line('Es ist ein Fehler aufgetreten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
END;
/
--Variation 1
BEGIN
    BEGIN
       INSERT INTO STUDENTS
                   (id
                  , first_name
                  , last_name)
            VALUES (20000
                  , 'John'
                  , 'Smith');
    EXCEPTION
       WHEN DUP_VAL_ON_INDEX
       THEN
          DBMS_OUTPUT.put_line('Eintrag bereits vorhanden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN INVALID_NUMBER
       then
          DBMS_OUTPUT.put_line('Ungültige Daten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN NO_DATA_FOUND
       THEN
          DBMS_OUTPUT.put_line('Keine Daten gefunden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN OTHERS
       THEN
          DBMS_OUTPUT.put_line('Es ist ein Fehler aufgetreten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
    END;
    BEGIN
        INSERT INTO STUDENTS
                   (id
                  , first_name
                  , last_name)
            VALUES (20000
                  , 'Susan'
                  , 'Ryan');
    EXCEPTION
       WHEN DUP_VAL_ON_INDEX
       THEN
          DBMS_OUTPUT.put_line('Eintrag bereits vorhanden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN INVALID_NUMBER
       then
          DBMS_OUTPUT.put_line('Ungültige Daten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN NO_DATA_FOUND
       THEN
          DBMS_OUTPUT.put_line('Keine Daten gefunden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN OTHERS
       THEN
          DBMS_OUTPUT.put_line('Es ist ein Fehler aufgetreten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
    END;
    BEGIN
       INSERT INTO STUDENTS
                   (id
                  , first_name
                  , last_name)
            VALUES ('A1'
                  , 'Susan'
                  , 'Ryan');
    
    EXCEPTION
       WHEN DUP_VAL_ON_INDEX
       THEN
          DBMS_OUTPUT.put_line('Eintrag bereits vorhanden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN INVALID_NUMBER
       then
          DBMS_OUTPUT.put_line('Ungültige Daten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN NO_DATA_FOUND
       THEN
          DBMS_OUTPUT.put_line('Keine Daten gefunden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN OTHERS
       THEN
          DBMS_OUTPUT.put_line('Es ist ein Fehler aufgetreten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
    END;
    BEGIN
   INSERT INTO STUDENTS
               (id
              , first_name
              , last_name)
        VALUES (2001
              , 'Susan Peggy Amanda Lisa'
              , 'Bryce');

    EXCEPTION
       WHEN DUP_VAL_ON_INDEX
       THEN
          DBMS_OUTPUT.put_line('Eintrag bereits vorhanden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN INVALID_NUMBER
       then
          DBMS_OUTPUT.put_line('Ungültige Daten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN NO_DATA_FOUND
       THEN
          DBMS_OUTPUT.put_line('Keine Daten gefunden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN OTHERS
       THEN
          DBMS_OUTPUT.put_line('Es ist ein Fehler aufgetreten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
    END;
    BEGIN
       INSERT INTO STUDENTS
                   (id
                  , first_name
                  , last_name)
          SELECT id
               , first_name
               , last_name
            FROM STUDENTS
           WHERE id = 1000000;
    EXCEPTION
       WHEN DUP_VAL_ON_INDEX
       THEN
          DBMS_OUTPUT.put_line('Eintrag bereits vorhanden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN INVALID_NUMBER
       then
          DBMS_OUTPUT.put_line('Ungültige Daten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN NO_DATA_FOUND
       THEN
          DBMS_OUTPUT.put_line('Keine Daten gefunden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
       WHEN OTHERS
       THEN
          DBMS_OUTPUT.put_line('Es ist ein Fehler aufgetreten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
    END;
    rollback;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN
      DBMS_OUTPUT.put_line('Eintrag bereits vorhanden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
   WHEN INVALID_NUMBER
   then
      DBMS_OUTPUT.put_line('Ungültige Daten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.put_line('Keine Daten gefunden: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line('Es ist ein Fehler aufgetreten: SQLCODE: ' || SQLCODE ||' SQLERRM: '|| SQLERRM);
      ROLLBACK;
END;
/

(2.)

User Defined Exceptions

Definiert eine Exception, die anspringt, wenn es mehr Anmeldungen für den History Kurs 101 gibt als Plätze.
Tragt in diesem Fall eine Fehlermeldung in das Infofeld der Tabelle 'log_table' ein.

DECLARE
   -- Current number of students registered for HIS-101
   v_errmsg LOG_TABLE.MESSAGE%TYPE;
   -- Exception to indicate an error condition
   e_toomanystudents EXCEPTION;
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

   /* Find the current number of registered students, and the maximum
    number of students allowed. */
   SELECT current_students
        , max_students
     INTO v_currentstudents
        , v_maxstudents
     FROM CLASSES
    WHERE department = 'HIS'
      AND course = 101;

   /* Check the number of students in this class. */
   DBMS_OUTPUT.put_line('v_currentstudents: '||v_currentstudents||' v_maxstudents: '||v_maxstudents);
   IF v_currentstudents > v_maxstudents
   THEN
      /* Too many students registered -- raise exception. */
      RAISE e_toomanystudents;
   END IF;
   DBMS_OUTPUT.put_line('Noch Plätze frei');
EXCEPTION
   WHEN e_toomanystudents
   THEN
      /* Handler which executes when there are too many students
       registered for HIS-101. We will insert a log message
       explaining what has happened. */
       v_errmsg := SQLERRM;
      INSERT INTO LOG_TABLE
                  (CODE,MESSAGE, info)
           VALUES (101,v_errmsg,TO_CHAR(SYSDATE,'DD.MM.YYYY HH24:MI:SS')||' History 101 has ' || v_currentstudents || ' students: max allowed is ' || v_maxstudents);
END;
/
select * from LOG_TABLE



