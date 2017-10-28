 Create Procedure PJEXPHDR_semp @Parm1 varchar (10) , @Parm2 varchar (10)  as
Select * from PJEXPHDR
Where
	pjexphdr.employee = @parm1 and
	pjexphdr.docnbr like @parm2
Order by
	pjexphdr.docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPHDR_semp] TO [MSDSL]
    AS [dbo];

