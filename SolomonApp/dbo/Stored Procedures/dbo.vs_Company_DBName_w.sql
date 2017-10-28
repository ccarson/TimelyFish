
Create Procedure vs_Company_DBName_w @parm1 varchar(50), @parm2 varchar(10) as
Select Cpnyid, cpnyname, cpnyCOA from vs_Company where DatabaseName = @parm1 and CpnyID = @parm2 and Active = 1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_Company_DBName_w] TO [MSDSL]
    AS [dbo];

