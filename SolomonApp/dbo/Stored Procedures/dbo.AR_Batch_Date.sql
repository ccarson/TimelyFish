 /****** Object:  Stored Procedure dbo.AR_Batch_Date    Script Date: 4/7/98 12:49:19 PM ******/
create Proc AR_Batch_Date @parm1 smalldatetime as
  Select * from batch
  Where module = 'AR' and battype <> 'C' and dateent = @parm1
  Order by Batnbr


