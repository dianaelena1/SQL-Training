/*Übung 4 - SQL und Cursor

(1.)

Nutzung von SELECT ... INTO /use select ... into

Selektiert Euch bitte den Titel und die vier Autoren aus der Tabelle "books" in einen Record-Typ. /Please select the title and the four authors from the "books" table to a record type
Gebt bitte die Daten für das Buch mit der Katalognummer 1002 aus. / Please provide the data for the book with catalog number 1002.
Benutzt dazu SELECT ... INTO. */

DECLARE 
TYPE booksType IS RECORD (
    my_titleBook VARCHAR(10),
    my_author1 VARCHAR(20),
    my_author2 VARCHAR(20),
    my_author3 VARCHAR(20),
    my_author4 VARCHAR(20));
    my_CATALOG_NUMBER NUMBER(10);
    
books booksType;
  
BEGIN  
    titleBook := 'Monte Cristo';
    author1 := 'Dumas';
    author2 := 'Dumas1';
    author3 := 'Dumas2';
    author4 := 'Dumas3';
    
    SELECT CATALOG_NUMBER, titleBook, author1, author2, author3, author4 
    INTO normal_books (my_CATALOG_NUMBER, my_titleBook, my_author1, my_author2, my_author3, my_author4);
    FROM books
    WHERE CATALOG_NUMBER = 1002;
    
End;


/*
Erweiterung von (1.) -> Workshop SUBSTR und INSTR

Als Kurzbezweichnung werden die ersten 3 Bytes des ersten Titelwortes (sofern da keine Leerzeichen sind) verknüpt mit ID ausgegeben. 
The first 3 bytes of the first title word (provided there are no spaces) combined with ID are output as a short description. */

DECLARE 
TYPE booksType IS RECORD (
    my_titleBook VARCHAR(10),
    my_author1 VARCHAR(20),
    my_author2 VARCHAR(20),
    my_author3 VARCHAR(20),
    my_author4 VARCHAR(20));
    my_CATALOG_NUMBER NUMBER(10);
    
bookss booksType;
  
BEGIN  
    titleBook := 'Monte Cristo';
    author1 := 'Dumas';
    author2 := 'Dumas1';
    author3 := 'Dumas2';
    author4 := 'Dumas3';
   
    SELECT CATALOG_NUMBER, titleBook, author1, author2, author3, author4 
    INTO normal_books (SUBSTRING(bookss.my_titleBook, 1, 3 ) , my_titleBook, my_author1, my_author2, my_author3, my_author4);
    FROM books
    WHERE CATALOG_NUMBER = 1002; 
End;


/*Alle Bücher ausgeben mit nur den Nachnamen (1. Name) der Autoren 
Output all books with only the last names (1st name) of the authors*/

DECLARE 
TYPE booksType IS RECORD (
    my_titleBook VARCHAR(10),
    my_author1 VARCHAR(20),
    my_author2 VARCHAR(20),
    my_author3 VARCHAR(20),
    my_author4 VARCHAR(20));
    my_CATALOG_NUMBER NUMBER(10);
    
bookss booksType;
  
BEGIN  
    titleBook := 'Monte Cristo';
    author1 := 'Dumas';
    author2 := 'Dumas1';
    author3 := 'Dumas2';
    author4 := 'Dumas3';
    
   SELECT column_name
   INTO normal_books (INSTR(author1, ','))
   FROM books
   WHERE CATALOG_NUMBER = 1002;
End;

 