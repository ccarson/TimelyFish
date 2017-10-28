 /****** Object:  Stored Procedure dbo.APDoc_Cleared    Script Date: 4/7/98 12:49:19 PM ******/
create Proc APDoc_Cleared @parm1 varchar ( 6) as
  Select * from apdoc
  Where  perent > @parm1
   and  status = 'C'
   Order by cpnyid, acct, sub, doctype, refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Cleared] TO [MSDSL]
    AS [dbo];

