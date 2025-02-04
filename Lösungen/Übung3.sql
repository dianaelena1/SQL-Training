Übung 3 - Ablaufsteuerung

(1.)

IF ... THEN ... ELSE

Unterscheide die Räume in der Tabelle rooms nach Besprechungsraum (<100 Sitze) und Konferenzsaal.
Ermittle das Ergebnis in einem anonymen Block für den Raum 20001 und gebe es aus.
  SELECT number_seats INTO anzahl 
    FROM rooms
   WHERE room_id = 20001;

set serveroutput on;


DECLARE
  Anzahl PLS_INTEGER;
BEGIN
  SELECT number_seats INTO anzahl 
    FROM rooms
   WHERE room_id = 20001;
  IF anzahl < 100 THEN
    DBMS_OUTPUT.PUT_LINE(anzahl||' Besprechungsraum');
  ELSE
    DBMS_OUTPUT.PUT_LINE(anzahl||' Konferenzsaal');  
  END IF;
END;
/

(2.)

CASE

Bilde einen anonymen Block und deklariere eine Variable vom Typ INTEGER.
Belege diese Zahl mit 1 vor.
Erstelle eine CASE-Anweisung, die mögliche Belegungen von 1 bis 5 in Text umwandelt:
1 - Eins
2 - Zwei
3 - Drei
4 - Vier
5 - Fünf


DECLARE
  v_TestVar INTEGER := 3;
BEGIN
  <<Zahl_nach_Text>>
  CASE v_TestVar
    WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('Eins');
    WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('Zwei');
    WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('Drei');
    WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('Vier');
    WHEN 5 THEN DBMS_OUTPUT.PUT_LINE('Fünf');
    ELSE DBMS_OUTPUT.PUT_LINE('Zahl ausserhalb vom Bereich!');
  END CASE Zahl_nach_Text;
END;
/

(3.)

Durchlaufe alle Zahlen von 1 bis 20 und gebe jede Zahl aus.
Zusätzlich gib einen Kommentar ('Ganzzahlig') aus, wenn die Zahl durch 2 Teilbar ist.
(Test am Besten auf Modulo -> MOD(lauf_var,2) = 0)
Ist die zahl durch 4 teilbar, so gebe bitte zusätzlich einen weiteren Kommentar aus.

BEGIN
  FOR lauf_var IN 1 .. 20
  LOOP
    DBMS_OUTPUT.PUT(lauf_var);
    IF MOD(lauf_var,2) = 0 THEN
      DBMS_OUTPUT.PUT(' - Ganzzahlig - ');  
      IF MOD(lauf_var,4) = 0 THEN
        DBMS_OUTPUT.PUT('durch vier teilbar - ');  
      END IF;
    END IF;
    DBMS_OUTPUT.NEW_LINE;
  END LOOP;
END;
/

--Variation 1
BEGIN
  FOR lauf_var IN 1 .. 20
  LOOP
    DBMS_OUTPUT.PUT(lauf_var);
    CASE
      WHEN (MOD(lauf_var,2)=0 AND MOD(lauf_var,4)=0)
        THEN dbms_output.put(' - Ganzzahlig - durch vier teilbar - ');
      WHEN (MOD(lauf_var,2)=0 AND MOD(lauf_var,4)!=0)
        THEN dbms_output.put(' - Ganzzahlig - ');
      ELSE null;
    END CASE;
  DBMS_OUTPUT.NEW_LINE;
  END LOOP;
END;
/
