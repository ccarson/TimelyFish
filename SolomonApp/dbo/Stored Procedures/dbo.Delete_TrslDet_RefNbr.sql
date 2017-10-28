 /****** Object:  Stored Procedure dbo.Delete_TrslDet_RefNbr    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc Delete_TrslDet_RefNbr @parm1 varchar ( 10) AS
     Delete fstrsldet from FSTrslDet
          Where RefNbr = @parm1


