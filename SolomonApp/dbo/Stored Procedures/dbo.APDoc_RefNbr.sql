 /****** Object:  Stored Procedure dbo.APDoc_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 2) As
Select * from APDoc Where RefNbr = @parm1 and DocType = @parm2


