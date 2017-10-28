 /****** Object:  Stored Procedure dbo.PRDoc_Outstanding    Script Date: 4/7/98 12:49:20 PM ******/
create Proc PRDoc_Outstanding @parm1 varchar(10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime as
  Select * from prdoc
  Where cpnyID like @parm1 and acct like @parm2 and sub like @parm3
   and (status = 'O'  and
  chkDate <= @parm4) or
  (chkdate <= @parm4  and cleardate > @parm4)
  Order by CpnyID, Acct, sub, chknbr, doctype




GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Outstanding] TO [MSDSL]
    AS [dbo];

