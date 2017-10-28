
CREATE proc WS_GetEmpofExpenseReport 
@parm1 varchar(10) --Doc Nbr
as  
Begin

select employee from PJEXPHDR where docnbr = @parm1

End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetEmpofExpenseReport] TO [MSDSL]
    AS [dbo];

