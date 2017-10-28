 /****** Object:  Stored Procedure dbo.PRDoc_Date_Prd    Script Date: 4/7/98 12:49:20 PM ******/
create Proc PRDoc_Date_Prd @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (24), @parm4 smalldatetime, @parm5 varchar (6) as
Select * from PRdoc
Where cpnyid like @parm1
and acct like @parm2
and sub like @parm3
and (status = 'O' or status = 'C' or status = 'V' or DocType = 'VC')
and ChkDate = @parm4
and PerPost = @parm5
and rlsed = 1
Order by acct, sub, chknbr, doctype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Date_Prd] TO [MSDSL]
    AS [dbo];

