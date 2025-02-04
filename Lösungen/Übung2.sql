Übung 2 - Datentypen, Variablen, Konstanten

(1.)

Kommentiert den Code sinnvoll und korrekt

DECLARE
  /* Dieser Block ...
     erstellt von :
     erstellt am:
     letzte Änderung am:
     Beschreibung: Dieses Beispiel speichert den Standardsat 'Hello World' IN die TEMP_TABLE.
*/
   v_num1 TEMP_TABLE.num_col%TYPE;
   v_num2 TEMP_TABLE.num_col%TYPE;
   v_string1 TEMP_TABLE.char_col%TYPE;
   v_string2 TEMP_TABLE.char_col%TYPE;
   v_outputstr VARCHAR2(50);
BEGIN
   v_num1 := 1;
   v_num2 := 2;
   v_string1 := 'Hello World!';
   v_string2 := '-- This message brought to you by PL/SQL!';

  --erstes Einfügen
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

(2.)

Weise zwei Variablen den Wert 3 bzw. 6 zu.
Subtrahiere vom Quadraht der zweiten Zahl die doppelte Summe der beiden Variablen und weise das Ergebnis einer neuen Variablen zu.
Gebe das Ergebnis aus.
Teile das Ergebnis durch zwei.
Gebe das Ergebnis aus.

DECLARE
   a NUMBER := 3;
   b NUMBER := 6;
   ergebnis NUMBER := 0;
BEGIN
   ergebnis := b * b - 2 * (a + b);
   DBMS_OUTPUT.put_line('Ergebnis :' || ergebnis);
   ergebnis := ergebnis / 2;
   DBMS_OUTPUT.put_line('Ergebnis :' || ergebnis);
END;
/

(3.)

Wie muss der Ausdruck geklammert werden, dass die Ziel- Werte stimmen?
Überprüft Eure Lösung mit Ausgaben.

SET serveroutput ON

DECLARE
   l_a NUMBER;
   l_b NUMBER;
   l_c NUMBER;
   l_d BOOLEAN;
BEGIN
   l_a := 2;
   l_b := 4;
   --Ausgangssituation
   l_c := -l_a + +l_b / l_a + 2 * l_b;
   DBMS_OUTPUT.put_line('1. :' || l_c);
   -- Ziel 1: 8
   -- Ziel 2: -6

   l_c := -l_a + (+l_b / l_a) + (2 * l_b); -- -> 8
   DBMS_OUTPUT.put_line('1. :' || l_c);
   l_c := -(l_a + +l_b) / (l_a + 2) * l_b; -- -> -6
   DBMS_OUTPUT.put_line('2. :' || l_c);
   --Ausgangssituation
   l_d :=    l_c BETWEEN -10 * l_a AND 10 * l_b
          OR l_c IN(2, 4, 6, 8)
          OR     2 * l_a = l_b
             AND 2 * l_b = l_c;
   -- Ziel: FALSCH
   l_d :=     (   l_c BETWEEN -10 * l_a AND 10 * l_b
               OR l_c IN(2, 4, 6, 8)
               OR 2 * l_a = l_b)
          AND 2 * l_b = l_c;

   IF l_d
   THEN
      DBMS_OUTPUT.put_line('WAHR');
   ELSE
      DBMS_OUTPUT.put_line('FALSCH');
   END IF;
   dbms_output.put_line(case when l_d = true then 'true' else 'false' end );
END;
/
