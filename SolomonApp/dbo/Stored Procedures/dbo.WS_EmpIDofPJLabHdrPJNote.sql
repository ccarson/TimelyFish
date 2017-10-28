
CREATE proc WS_EmpIDofPJLabHdrPJNote 
@parm1 varchar(10) --Employee
,@parm2 smalldatetime --Week end date
as  
Begin
select pjLabhdr.employee from PJLabHDR where pjlabhdr.employee = @parm1 and pjlabhdr.pe_date = @parm2
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJLabHdrPJNote] TO [MSDSL]
    AS [dbo];

