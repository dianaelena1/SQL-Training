Übung 1 - Datentypen, Variablen, Konstanten

(1.)

Füllt den Deklarationsblock korrekt

set serveroutput on;
DECLARE
   v1 NUMBER;
   v2 NUMBER;
   v3 VARCHAR2(100);
   v4 BOOLEAN;
   plz CHAR(5);
BEGIN
   v1 := 1;
   v1 := v1 + 1;
   v2 := v3 + 1;
   v3 := 'Hallo Welt';
   v4 := NULL;
   plz := '85797';
   v4 := FALSE ;
END;
/


(2.)

Nutzt Tabellendefinitionen zum deklarieren!

DECLARE
   v_num1 TEMP_TABLE.num_col%TYPE;
   v_num2 TEMP_TABLE.num_col%TYPE;
   v_string1 TEMP_TABLE.char_col%TYPE;
   v_string2 TEMP_TABLE.char_col%TYPE;
   v_outputstr TEMP_TABLE.char_col%TYPE;
  
BEGIN
   v_num1 := 1;
   v_num2 := 2;
   v_string1 := 'Hello World!';
   v_string2 := '-- This message brought to you by PL/SQL!';

   INSERT INTO TEMP_TABLE
               (num_col
              , char_col)
        VALUES (v_num1
              , v_string1);

   INSERT INTO TEMP_TABLE
               (num_col
              , char_col)
        VALUES (v_num2
              , v_string2);

   SELECT char_col
     INTO v_outputstr
     FROM TEMP_TABLE
    WHERE num_col = v_num1;

   DBMS_OUTPUT.put_line(v_outputstr);

   SELECT char_col
     INTO v_outputstr
     FROM TEMP_TABLE
    WHERE num_col = v_num2;

   DBMS_OUTPUT.put_line(v_outputstr);
   ROLLBACK;
END;
/

(3.)

Erstellt einen anonymen Block, definiert einen Record-Datentyp AnschriftTyp bestehnd aus 
PLZ, Ort und Strasse und verwendet ihn in einer Zuweisung

DECLARE
   TYPE anschrifttyp IS RECORD(
      plz CHAR(5)
    , ort VARCHAR2(100)
    , strasse VARCHAR2(100)
   );

   vt_anschrift anschrifttyp;
BEGIN
--   vt_anschrift.plz := '85737';
--   vt_anschrift.ort := 'Ismaning';
--   vt_anschrift.strasse := 'Robert-Bürkle-Str. 1';
   select '85737', 'Ismaning', 'Robert-Bürkle-Str. 1' into vt_anschrift from DUAL;
END;
/
