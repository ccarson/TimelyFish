 /****** Object:  Stored Procedure dbo.POAddress_Delete    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure POAddress_Delete @parm1 varchar ( 255) as
Delete from POAddress where POAddress.Vendid = @parm1


