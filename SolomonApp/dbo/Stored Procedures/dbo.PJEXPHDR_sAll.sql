 Create Procedure PJEXPHDR_sAll @Parm1 varchar (10)  as
Select * from PJEXPHDR
Where DocNbr Like @parm1
Order by DocNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPHDR_sAll] TO [MSDSL]
    AS [dbo];

