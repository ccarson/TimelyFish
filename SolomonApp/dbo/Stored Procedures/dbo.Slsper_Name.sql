 Create Proc Slsper_Name @parm1 Varchar(30) as
       Select Name from Salesperson where Slsperid = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Slsper_Name] TO [MSDSL]
    AS [dbo];

