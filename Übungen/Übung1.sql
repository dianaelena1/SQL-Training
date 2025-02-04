

/*(2.)

Erstellt einen Deklarationsteil.
Nutzt dabei die Tabellendefinitionen zum deklarieren! /Use the table definitions to declare! */ 

DECLARE
   v_num1 temp_table.num_col%type;
   v_num2 temp_table.char_col%type;
   v_string1 temp_table.char_col%type;
   v_string2 temp_table.char_col%type;
   v_outputstr temp_table.char_col%type;
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

   SELECT char_col
     INTO v_outputstr
     FROM TEMP_TABLE
    WHERE num_col = v_num2;

   ROLLBACK; --It lets a user undo those transactions that aren't saved yet in the database
END;






