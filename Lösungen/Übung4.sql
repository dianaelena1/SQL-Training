Übung 4 - SQL und Cursor

(1.)

Nutzung von SELECT ... INTO

Selektiert Euch bitte den Titel und die vier Autoren aus der Tabelle "books" in einen Record.
Gebt bitte die Daten für das Buch mit der Katalognummer 1002 aus.
Benutzt dazu SELECT ... INTO.

DECLARE
   TYPE buch_typ IS RECORD(
      titel BOOKS.title%TYPE
    , autor1 BOOKS.author1%TYPE
    , autor2 BOOKS.author2%TYPE
    , autor3 BOOKS.author3%TYPE
    , autor4 BOOKS.author4%TYPE
   );
   buch_titel buch_typ;
BEGIN
   SELECT title
        , author1
        , author2
        , author3
        , author4
     INTO buch_titel
     FROM BOOKS
    WHERE catalog_number = 1002;

   DBMS_OUTPUT.put_line('Buch: ' || buch_titel.titel || ' von ' || buch_titel.autor1 || ',' || buch_titel.autor2 || ',' || buch_titel.autor3 || ',' || buch_titel.autor4);
EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.put_line('SCHWERER FEHLER!');
  
END;

/
-- Variation 1
DECLARE
  books_row BOOKS%rowtype;
BEGIN
   SELECT *
     INTO books_row
     FROM BOOKS
    WHERE catalog_number = 1002;

   DBMS_OUTPUT.put_line('Buch: ' || books_row.title || ' von ' || books_row.author1 || ',' || books_row.author2 || ',' || books_row.author3 || ',' || books_row.author4);
END;
/


(2.)

OPEN ... FETCH ... CLOSE

Selektiert aus der Tabelle "rooms" die room_id und die description zeilenweise
und speichert diese in die Tabelle "temp_table". Zählt die Datensätze mit und
gebt je Zeile Datensatznummer von Gesamtanzahl aus.
Nutzt dazu explizite Cursor mit OPEN, FETCH und Close.
Das Commit soll am Schluß erfolgen.

DECLARE
   CURSOR c_cursorvar IS
      SELECT room_id
           , description
        FROM ROOMS;
        
   r_Row c_cursorvar%rowtype;

   v_count PLS_INTEGER := 0;
   v_max PLS_INTEGER := 0;
   v_roomid ROOMS.room_id%TYPE;
   v_description ROOMS.description%TYPE;
BEGIN
/*    DELETE FROM TEMP_TABLE;
    SELECT COUNT(*) 
     INTO v_max 
	 FROM temp_table ;
   DBMS_OUTPUT.put_line('Datensaetze in temp_table vor Verarbeitung '||v_max);
*/
   SELECT COUNT(*) 
     INTO v_max 
	 FROM ROOMS ;
   
   OPEN c_cursorvar;

   /* Fetch loop.  Note the EXIT WHEN clause after the FETCH. */
   LOOP
      FETCH c_cursorvar INTO   v_roomid
                             , v_description;
      EXIT WHEN c_cursorvar%NOTFOUND;

      INSERT INTO TEMP_TABLE
                  (num_col
                 , char_col)
           VALUES (v_roomid
                 , SUBSTR(v_description, 1, 60));
      v_count := c_cursorvar%ROWCOUNT;

      DBMS_OUTPUT.put(v_count);
      DBMS_OUTPUT.put(' von ');
      DBMS_OUTPUT.put(v_max);
      DBMS_OUTPUT.new_line;
   END LOOP;
   /* Close the cursor. */
   CLOSE c_cursorvar;

/*   SELECT COUNT(*) 
     INTO v_max 
	 FROM temp_table ;
   DBMS_OUTPUT.put_line('Datensaetze in temp_table '||v_max);
*/
   COMMIT;
END;
-- Variation 1
DECLARE
   TYPE ROW_ROOMS IS RECORD(
      room_id ROOMS.room_id%TYPE
    , description ROOMS.description%TYPE
   );
   r_rooms ROW_ROOMS;

   TYPE TABLE_ROOMS IS TABLE OF 
      ROW_ROOMS   
      INDEX BY PLS_INTEGER;
   T_Rooms TABLE_ROOMS;

   v_count PLS_INTEGER := 0;
   v_max PLS_INTEGER := 0;
BEGIN
    SELECT COUNT(*) 
     INTO v_max 
	 FROM temp_table ;
   DBMS_OUTPUT.put_line('Datensaetze in temp_table vor Verarbeitung'||v_max);

   SELECT room_id
        , description
     BULK COLLECT
     INTO T_Rooms
     FROM ROOMS;

   v_max := T_Rooms.count;

   FOR i IN T_Rooms.FIRST .. T_Rooms.LAST LOOP
      R_Rooms := T_Rooms(i);
      INSERT INTO TEMP_TABLE
                  (num_col
                 , char_col)
           VALUES (T_Rooms(i).room_id
                 , SUBSTR(T_Rooms(i).description, 1, 60));
      v_count := i;

      DBMS_OUTPUT.put(v_count);
      DBMS_OUTPUT.put(' von ');
      DBMS_OUTPUT.put(v_max);
      DBMS_OUTPUT.new_line;
   END LOOP;
   
    SELECT COUNT(*) 
     INTO v_max 
	 FROM temp_table ;
   DBMS_OUTPUT.put_line('Datensaetze in temp_table '||v_max);

  COMMIT;
END;
/
(3.)

CURSOR und FOR ... LOOP

Definiert eine Cursor, der alle Kurse und die maximalen Studenten aus der Tabelle classes selektiert.
Als Paramter soll der Cursor das Department erhalten können.

Nutzt nun den Cursor in einer For Loop fir die Abteilung 'MUS'

DECLARE
  CURSOR cur_kurs (abt CLASSES.department%TYPE) IS 
    SELECT description
	     , max_students 
	  FROM CLASSES 
	 WHERE department = abt;
BEGIN
  FOR rec_kurs IN cur_kurs('MUS')
  LOOP
    dbms_output.put(rec_kurs.description);
    dbms_output.put(' -> Maximale Anzahl an Studenten:');
    dbms_output.put(rec_kurs.max_students);
	  dbms_output.new_line;
  END LOOP;
END;
/

select decode (INSTR(b.title, ' '),1,substr(b.title,INSTR(b.title, ' ')+1,3)||b.CATALOG_NUMBER
                                  ,2,substr(b.title,INSTR(b.title, ' ')+1,3)||b.CATALOG_NUMBER
                                  ,3,substr(b.title,INSTR(b.title, ' ')+1,3)
                                  ,substr(b.title,1,3)||b.CATALOG_NUMBER) as KURZBEZ
      ,SUBSTR(b.AUTHOR1,1,INSTR(b.AUTHOR1, ' ')) as AUTHOR1
      ,SUBSTR(b.AUTHOR2,1,INSTR(b.AUTHOR2, ' ')) as AUTHOR2
      ,SUBSTR(b.AUTHOR3,1,INSTR(b.AUTHOR3, ' ')) as AUTHOR3
      ,SUBSTR(b.AUTHOR4,1,INSTR(b.AUTHOR4, ' ')) as AUTHOR4
  from Books b;

