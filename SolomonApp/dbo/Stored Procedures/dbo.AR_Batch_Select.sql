 /****** Object:  Stored Procedure dbo.AR_Batch_Select    Script Date: 4/7/98 12:49:19 PM ******/
create Proc AR_Batch_Select @parm1 smalldatetime, @parm2 smalldatetime as
  Select * from batch
  Where module = 'AR'
   and ((cleared <>  1     and DateEnt <= @parm2)
   or (cleared =  1     and (DateEnt <= @parm2 and DateClr > @parm2)
   or (dateent <= @parm1 and dateent > @parm2)))
  Order by Batnbr


