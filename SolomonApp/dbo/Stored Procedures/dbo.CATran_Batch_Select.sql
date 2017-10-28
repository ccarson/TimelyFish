 /****** Object:  Stored Procedure dbo.CATran_Batch_Select    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CATran_Batch_Select @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 varchar ( 10) as
  Select * from catran
  Where module = 'CA' and batnbr = @parm4 and cpnyid = @parm1 and bankacct = @parm2 and banksub = @parm3


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Batch_Select] TO [MSDSL]
    AS [dbo];

