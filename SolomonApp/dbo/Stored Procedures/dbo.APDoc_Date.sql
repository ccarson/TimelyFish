 /****** Object:  Stored Procedure dbo.APDoc_Date    Script Date: 4/7/98 12:49:19 PM ******/
create Proc APDoc_Date @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime as
  Select * from apdoc
  Where cpnyID = @parm1 and acct = @parm2 and sub = @parm3
   and (status = 'O' or status = 'C')
   and DocDate = @parm4
  Order by cpnyid, acct, sub, doctype, refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Date] TO [MSDSL]
    AS [dbo];

