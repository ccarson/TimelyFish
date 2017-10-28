 /****** Object:  Stored Procedure dbo.TrnsfrDoc_BatNbr    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.TrnsfrDoc_BatNbr    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc TrnsfrDoc_BatNbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
    Select * from TrnsfrDoc
           where BatNbr = @parm1


