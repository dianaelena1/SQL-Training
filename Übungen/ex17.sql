/*Übung 7 - Funktionen und Prozeduren
(1.)
Erstellt eine Funktion, die berechnet, ob ein Kurs belegt ist./Creates a function that calculates whether a course is full.
Die Daten befinden sich in der Tabelle 'classes'. /The data is in the 'classes' table.
Als Paramter soll die Abteilung (department) und die Kursnummer (course) übergeben werden können. /The department (department) and the course number (course) should be able to be passed as parameters.
Ab einer Belegung über 80 Prozent gilt der Kurs als Belegt und die Funktion soll TRUE zurückgeben, 
im anderen Fall FALSE. (current_students, max_students zur Berechnung verwenden). /
For an occupancy rate of more than 80 percent, the course is considered occupied and the function should return TRUE,
otherwise FALSE. (use current_students, max_students for calculation).*/

CREATE OR REPLACE FUNCTION courseCapacity(
departmentt VARCHAR2, 
coursee NUMBER)
RETURN BOOLEAN
AS 
    occupancy NUMBER := 0;
    ret BOOLEAN := FALSE;
BEGIN
SELECT (current_students* 100)/max_students
INTO occupancy
FROM classes
WHERE departmentt = department AND coursee = course;
IF occupancy >= 80 THEN
    ret := TRUE;
    END IF;
    RETURN ret;
END;

--BEGIN
--IF courseCapacity(departmentt, coursee) THEN
--    DMBS_OUTPUT.PUT_LINE('Kurs bereits belegt');
--ELSE
--    DMBS_OUT.PUT_LINE('Kurs noch frei');
--END IF;
--
--END;
