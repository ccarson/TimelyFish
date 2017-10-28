 /****** Object:  Stored Procedure dbo.PRDoc_Cleared    Script Date: 4/7/98 12:49:20 PM ******/
create Proc PRDoc_Cleared @parm1 varchar ( 6) as
  Select * from prdoc
  Where  perent > @parm1
   and  status = 'C'
   Order by CpnyId, acct, sub, chknbr, doctype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Cleared] TO [MSDSL]
    AS [dbo];

