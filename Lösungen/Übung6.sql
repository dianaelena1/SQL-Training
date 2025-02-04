Übung 6 - PL/SQL Tables

(1.)

Baut eine PL/SQL Tabelle auf, die der Struktur der Tabelle 'students' entspricht.
Nutzt dazu den Rowtype.
Lest den Datensatz 10001 der Tabelle 'students' in die PL/SQL Tabelle ein.

DECLARE
  TYPE StudentTab IS TABLE OF students%ROWTYPE
    INDEX BY BINARY_INTEGER;
  /* Each element of v_Students is a record */
  v_Students StudentTab;
BEGIN
  /* Retrieve the record with id = 10001 and store it into
     v_Students(10001). */
  SELECT *
    INTO v_Students(10001)
    FROM students
    WHERE id = 10001;

  DBMS_OUTPUT.PUT_LINE('Vorname: '||v_Students(10001).first_name);
  DBMS_OUTPUT.PUT_LINE('Nachname: '||v_Students(10001).last_name);
  /* Directly assign to v_Students(1). */
  v_Students(10001).first_name := 'Larry';
  v_Students(10001).last_name := 'Lemon';
  DBMS_OUTPUT.PUT_LINE('Vorname: '||v_Students(10001).first_name);
  DBMS_OUTPUT.PUT_LINE('Nachname: '||v_Students(10001).last_name);
END;
/
DECLARE
  TYPE StudentTab IS TABLE OF students%ROWTYPE
    INDEX BY BINARY_INTEGER;
  /* Each element of v_Students is a record */
  v_Students StudentTab;
BEGIN
  /* Retrieve the record with id = 10001 and store it into
     v_Students(10001). */
  SELECT *
    BULK COLLECT
    INTO v_Students
    FROM students;

    DBMS_OUTPUT.PUT_LINE('LFNR: '||'111'||' ID: '||v_Students(1).ID||' Vorname: '||v_Students(2).first_name||' Nachname: '||v_Students(3).last_name);

  for i in v_Students.FIRST..v_Students.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('LFNR: '||i||' ID: '||v_Students(i).ID||' Vorname: '||v_Students(i).first_name||' Nachname: '||v_Students(i).last_name);
  end loop;
END;
/


(2.)

Baut eine PL/SQL Tabelle auf, in der Ihr Zahlen (Number) abspeichern könnt.
Füllt diese mit den Werten 10, 20, 30, ..., 100.
Löscht nun den Eintrag mit dem Index 5.
Durchlauft die Tabelle ein zweites mal und gebt die Werte aus.
(Achtet darauf, das ihr mögliche Fehler abfangt.)

DECLARE
  TYPE NumberTab IS TABLE OF NUMBER
    INDEX BY BINARY_INTEGER;
  v_Numbers NumberTab;
BEGIN
  -- Assign to several of the elements.
  FOR v_Count IN 1..10 LOOP
    v_Numbers(v_Count) := v_Count * 10;
  END LOOP;

  v_numbers.delete(5);
  
  -- And print them out
  DBMS_OUTPUT.PUT_LINE('Table elements: ');
  FOR v_Count IN 1..10 LOOP
    BEGIN
      DBMS_OUTPUT.PUT_LINE('  v_Numbers(' || v_Count || '): ' ||
                         v_Numbers(v_Count));
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    END;
  END LOOP;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE(
         'No data found reading v_Numbers(11)!');
END;
/ -- Variation 1
DECLARE
  TYPE tbl_number_type IS TABLE OF NUMBER(10);
  number_table tbl_number_type := tbl_number_type(null);
  ln_i PLS_INTEGER := 0;
BEGIN
  WHILE ln_i < 10 LOOP
    ln_i := ln_i + 1;
    number_table(ln_i) := (ln_i*10);
    if ln_i < 10 then
      number_table.EXTEND(1);
    end if;
  END LOOP;
  
  number_table.DELETE(5);
  
  FOR i IN number_table.FIRST .. number_table.LAST LOOP
    IF(number_table.EXISTS(i)) THEN
      DBMS_OUTPUT.PUT_LINE('Nummer: ('||i||')' || TO_CHAR(number_table(i)));
    END IF;
  END LOOP;
END;
/ -- Variation 2
DECLARE
  TYPE nums IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  nums_tab nums;  
  i BINARY_INTEGER;
BEGIN
  FOR ind IN 1..10 LOOP
    nums_tab(ind) := ind * 10;
  END LOOP;
  
  nums_tab.delete(5);
  
  i := nums_tab.FIRST;  -- get index of first element
  WHILE i IS NOT NULL LOOP
      dbms_output.put_line(nums_tab(i));
      i := nums_tab.NEXT(i);  
  END LOOP;
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('Kein Element wurde gefunden');
  WHEN OTHERS THEN
         dbms_output.put_line('Code: ' || SQLCODE || ' Msg: ' || SQLERRM);
END;

/ --Nicht GUT
DECLARE
  TYPE NumberTab IS VARRAY(10) OF NUMBER(3);
  arr_NumberTab  NumberTab := 
              NumberTab( 10, 20, 30, 40, 50, 60, 70, 80, 90, 100);

BEGIN

  arr_NumberTab(5) := null;
--  arr_NumberTab.delete(5);
  
  -- And print them out
  DBMS_OUTPUT.PUT_LINE('Table elements: ');
  FOR v_Count IN 1..10 LOOP
    BEGIN
      DBMS_OUTPUT.PUT_LINE('  arr_NumberTab(' || v_Count || '): ' ||
                         arr_NumberTab(v_Count));
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE(
           'No data found reading v_Numbers('||v_Count||')!');
           raise;
    END;
  END LOOP;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE(
         'No data found reading v_Numbers(11)!');
END;
/


(3.)

Schreibt ein Update, welches in der Tabelle students alle Fächer mit 
dem Titel History in Geschichte umschreibt und gebt die geänderten IDs aus.

DECLARE
  TYPE t_p_id_tbl IS TABLE OF students.id%TYPE INDEX BY PLS_INTEGER;
  tbl_p_id                       t_p_id_tbl;
BEGIN
  UPDATE students
     SET major = 'Geschichte'
   WHERE major = 'History'
   RETURNING id BULK COLLECT INTO tbl_p_id;
       
  DBMS_OUTPUT.PUT_LINE('Anzahl: '||to_char(tbl_p_id.COUNT));
  if  tbl_p_id.count() > 0 then
    FOR ln_i IN tbl_p_id.FIRST..tbl_p_id.LAST
    LOOP
      DBMS_OUTPUT.PUT_LINE( TO_CHAR( ln_i )|| ': ' || TO_CHAR( tbl_p_id( ln_i ) ) );
    END LOOP;
  else
    DBMS_OUTPUT.PUT_LINE('Keine Daten');
  end if;
  
  ROLLBACK;
--   COMMIT;
END;
/.