/*(2.)

OPEN ... FETCH ... CLOSE

Selektiert aus der Tabelle "rooms" die room_id und die description zeilenweise und speichert diese in die Tabelle "temp_table". Z‰hlt die Datens‰tze mit und
gebt je Zeile die Datensatznummer und die Gesamtanzahl aus. /Select the room_id and the description line by line from the "rooms" table and saves them in the "temp_table" table. 
Counts the records with and outputs the record number and the total number per line
Nutzt dazu explizite Cursor mit OPEN, FETCH und Close.
Das Commit soll am Schluﬂ erfolgen. /The commit should happen at the end. */


DECLARE
    CURSOR c1 IS
        my_room_id VARCHAR2(10);
        my_description_data VARCHAR2(10);
        counter NUMBER := 0;

BEGIN
   OPEN c1;
   FOR index IN 1..5 LOOP
      FETCH c1 INTO my_room_id, my_description_data; 
      EXIT WHEN c1%NOTFOUND;
      INSERT INTO temp_table (my_room_id, my_description_data, counter);
      counter := counter + 1;
      dbms_output.put_line(counter);
      COMMIT;
   END LOOP;
   CLOSE c1;
END;


