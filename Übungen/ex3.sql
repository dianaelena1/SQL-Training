/*(3.)

Erstellt einen anonymen Block, definiert einen Record-Datentyp AnschriftTyp bestehnd aus 
PLZ, Ort und Strasse und verwendet ihn in einer Zuweisung. */

DECLARE
   TYPE adressType IS RECORD (
                       v_platz NUMBER(20),
                       v_ort VARCHAR(30),
                       v_strasse VARCHAR(30) );
    student adressType;
BEGIN
   student.v_platz := 40052;
   student.v_ort := 'Ismaning';
   student.v_strasse := 'Marie Platz';

END;