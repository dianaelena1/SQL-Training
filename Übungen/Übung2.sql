/*Übung 2 - Datentypen, Variablen, Konstanten

(1.)

Kommentiert den Code sinnvoll und korrekt */

DECLARE
  /* Dieser Block dient der Kommentierung
     erstellt von : 
     erstellt am:
     letzte Änderung am:
     Beschreibung: Dieses Beispiel speichert den Standardsat Hello World IN die TEMP_TABLE. */

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

  /*erstes Einfügen */
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

   SELECT char_col
     INTO v_outputstr
     FROM TEMP_TABLE
    WHERE num_col = v_num2;

   ROLLBACK;
END;

/*
(2.)

Erstelle einen anonymen Block.
Weise zwei Variablen den Wert 3 bzw. 6 zu.
Subtrahiere vom Quadraht der zweiten Zahl die doppelte Summe der beiden Variablen und weise das Ergebnis einer neuen Variablen zu.
Gebe das Ergebnis aus.
Teile das Ergebnis durch zwei.
Gebe das Ergebnis aus. */

/*
(3.)

Wie muss der Ausdruck geklammert werden, dass die Ziel- Werte stimmen?
Überprüft Eure Lösung mit Ausgaben. */

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
   -- Ziel 1: 8
   -- Ziel 2: -6

   --Ausgangssituation
   l_d :=    l_c BETWEEN -10 * l_a AND 10 * l_b OR l_c IN(2, 4, 6, 8) OR 2 * l_a = l_b AND 2 * l_b = l_c;
   -- Ziel: FALSCH
END;

