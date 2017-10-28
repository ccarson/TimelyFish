 /****** Object:  Stored Procedure dbo.Vendor_VendId    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Vendor_VendId @parm1 varchar ( 15) as
Select * from Vendor where VendId = @parm1


