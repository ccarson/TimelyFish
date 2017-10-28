

Create Proc vs_Company_All @parm1 varchar (10) AS
Select Cpnyid, cpnyname, cpnyCOA from vs_Company where cpnyid = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_Company_All] TO [MSDSL]
    AS [dbo];

