/*IF ... THEN ... ELSE Unterscheide die Räume in der Tabelle rooms nach Besprechungsraum (<100 Sitze) und Konferenzsaal.
Ermittle das Ergebnis in einem anonymen Block für den Raum 20001 und gebe es aus.
Nutze dazu folgendes Select:
  SELECT number_seats INTO anzahl 
  FROM rooms
  WHERE room_id = 20001;*/
DECLARE
TYPE roomss IS RECORD(
    seats NUMBER;
);
anzahl roomss;
BEGIN
   SELECT number_seats INTO anzahl 
   FROM rooms 
   WHERE room_id = 20001;
   if anzahl.seats < 100 then
         dbms_output.put_line('Besprechungsraum');
    else
         dbms_output.put_line('Konferenzsaal');
    end if;
END; 