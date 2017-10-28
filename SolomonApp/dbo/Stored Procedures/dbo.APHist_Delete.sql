 /****** Object:  Stored Procedure dbo.APHist_Delete    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APHist_Delete @parm1 varchar ( 255) as
Delete from APHist where APHist.Vendid = @parm1


