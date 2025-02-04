/*
Durchlaufe alle Zahlen von 1 bis 20 und gebe jede Zahl aus. /Go through all the numbers from 1 to 20 and output each number
Zusätzlich gib einen Kommentar (' - Ganzzahlig - ') aus, wenn die Zahl durch 2 teilbar ist.
(Test am Besten auf Modulo -> MOD(lauf_var,2) = 0) /test best on modulo
Ist die Zahl durch 4 teilbar, so gebe bitte zusätzlich einen weiteren Kommentar aus. /Is the number divisible by 4, so please add another comment
*/
Declare
Begin
FOR index in 1..20
LOOP 
    dbms_output.put(index);
    if  MOD(index,2) = 0 then
        dbms_output.put(' Ist durch 2 teilbar');
        if MOD(index,4) = 0 then
                dbms_output.put(' UND ist auch durch vier teilbar');
        end if;
    end if;
    dbms_output.put_line('');
END LOOP;
End;

--case try
Declare
Begin
FOR index in 1..20
LOOP 
     dbms_output.put(index);
    Case 
        when (Mod(index,2)=0 and MOD(index,4)=0) then dbms_output.put(' teilbar 2 UND ist auch durch vier teilbar');
        when (Mod(index,2)=0 and MOD(index,4)!=0) then dbms_output.put(' teilbar 2 ');
        else null;
    END case;
        dbms_output.put_line(''); 
END LOOP; 
End;

----FIRST MODE