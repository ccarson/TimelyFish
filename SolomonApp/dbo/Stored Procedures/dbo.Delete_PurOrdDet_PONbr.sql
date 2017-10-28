 /****** Object:  Stored Procedure dbo.Delete_PurOrdDet_PONbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure Delete_PurOrdDet_PONbr @parm1 varchar ( 10) As
Delete from PurOrdDet Where PONbr = @parm1


