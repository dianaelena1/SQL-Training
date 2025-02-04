/*Bilde einen anonymen Block und deklariere eine Variable vom Typ INTEGER.
Belege diese Zahl gleich mit 1 vor.
Erstelle eine CASE-Anweisung, die mögliche Belegungen von 1 bis 5 in Text umwandelt:
1 - Eins
2 - Zwei
3 - Drei
4 - Vier
5 - Fünf
*/
Declare
vr INTEGER := 6;
Begin
    Case 
        when vr = 1 then dbms_output.put_line('Eins');
        when vr = 2 then dbms_output.put_line('Zwei');
        when vr = 3 then dbms_output.put_line('Drei');
        when vr = 4 then dbms_output.put_line('Vier');
        when vr = 5 then dbms_output.put_line('Funf');
    End Case;
END;

/*
Durchlaufe alle Zahlen von 1 bis 20 und gebe jede Zahl aus.
Zusätzlich gib einen Kommentar (' - Ganzzahlig - ') aus, wenn die Zahl durch 2 teilbar ist.
(Test am Besten auf Modulo -> MOD(lauf_var,2) = 0)
Ist die Zahl durch 4 teilbar, so gebe bitte zusätzlich einen weiteren Kommentar aus.
*/
Declare
Begin
FOR lauf_var in 1..20
LOOP 
    dbms_output.put(lauf_var);
    if  MOD(lauf_var,2) = 0 then
        dbms_output.put(' Ist durch 2 teilbar');
        if MOD(lauf_var,4) = 0 then
                dbms_output.put(' UND ist auch durch vier teilbar');
        end if;
    end if;
    dbms_output.put_line('');
END LOOP;
End;
--case try
Declare
Begin
FOR lauf_var in 1..20
LOOP 
     dbms_output.put(lauf_var);
    Case 
        when (Mod(lauf_var,2)=0 and MOD(lauf_var,4)=0) then dbms_output.put(' teilbar 2 UND ist auch durch vier teilbar');
        when (Mod(lauf_var,2)=0 and MOD(lauf_var,4)!=0) then dbms_output.put(' teilbar 2 ');
        else null;
    END case;
        dbms_output.put_line(''); END LOOP; End;