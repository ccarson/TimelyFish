 /****** Object:  Stored Procedure dbo.POUserSubacct_Sub_Active    Script Date: 12/17/97 10:49:12 AM ******/
Create Procedure POUserSubacct_Sub_Active @parm1 Varchar(47), @parm2 Varchar(24) as
Select * from POUserSubacct  where
UserId = @parm1 and
Sub LIKE @parm2
order by UserId,Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POUserSubacct_Sub_Active] TO [MSDSL]
    AS [dbo];

