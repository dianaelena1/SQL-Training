/*(2.)

Erstellt eine Prozedur 'AddNewStudent', die einen neuen Studenten in die Tabelle 'students' einträgt. /Creates an AddNewStudent procedure that adds a new student to the students table.
Die Prozedur soll drei Parameter erhalten (Vorname, Nachname und Hauptfach), welche in die
Felder first_name, last_name und major eingetragen werden sollen. 
Fields first_name, last_name and major should be entered.
The procedure should receive three parameters (first name, last name and major), which are entered into the
Fields first_name, last_name and major should be entered.
Die neue ID soll über student_sequence.nextval berechnet werden. current_credits sind mit 0 zu belegen. 
The new ID should be calculated via student_sequence.nextval. current_credits are to be assigned 0.*/

CREATE OR REPLACE PROCEDURE AddNewStudent(
    first_name IN VARCHAR2,
    last_name IN VARCHAR2,
    major IN VARCHAR2)
AS

BEGIN
INSERT INTO students 
VALUES(student_sequence.nextval, first_name, last_name, major, 0);
END;

BEGIN

AddNewStudent('D', 'E', 'IT');
END;
