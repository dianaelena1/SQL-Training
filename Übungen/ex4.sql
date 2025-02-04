/*(2.)

Erstelle einen anonymen Block. /Create an anonymous block.
Weise zwei Variablen den Wert 3 bzw. 6 zu. /declare two variables, v1=3, v2=6
Subtrahiere vom Quadraht der zweiten Zahl die doppelte Summe der beiden Variablen und weise das Ergebnis einer neuen Variablen zu. /b*b-2*(6+3)
Gebe das Ergebnis aus. /output the result
Teile das Ergebnis durch zwei. /divide the result by two
Gebe das Ergebnis aus./output the result */

DECLARE
   v1 NUMBER;
   v2 NUMBER;
   output NUMBER;
   dividedOutput NUMBER;
BEGIN
   v1 := 3;
   v2 := 6;
   output := (b * b) - 2*(v1+v2);
   dbms_output.put_line(output);
   dividedOutput := output/2;
   dbms_output.put_line(dividedoutput); /*printarea outputului */
END;