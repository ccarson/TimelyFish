 Create Procedure PJEXPHDR_sDocNbr @Parm1 varchar (10)  as
Select * from PJEXPHDR
Where DocNbr = @parm1
Order by DocNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPHDR_sDocNbr] TO [MSDSL]
    AS [dbo];

