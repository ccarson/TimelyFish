 /****** Object:  Stored Procedure dbo.PRDoc_Select    Script Date: 4/7/98 12:49:20 PM ******/
create Proc PRDoc_Select @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime as
  Select * from PRdoc
  Where cpnyid = @parm1 and acct = @parm2 and sub = @parm3
   and ((status = 'O' and ChkDate <= @parm5)
   or (status = 'C' and (ChkDate <= @parm5 and ClearDate > @parm5)
   or (chkdate <= @parm4 and chkdate > @parm5)))
  Order by cpnyid, acct, sub, chknbr, doctype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Select] TO [MSDSL]
    AS [dbo];

