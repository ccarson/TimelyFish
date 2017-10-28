 /****** Object:  Stored Procedure dbo.Vend_OneTime_Delete    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Vend_OneTime_Delete @parm1 varchar(15) as
Delete from Vendor where
Vendor.Vendid = @parm1 and
Vendor.Status = 'O'


