 /****** Object:  Stored Procedure dbo.Vendor_ClassId    Script Date: 4/7/98 12:19:55 PM ******/
Create Proc Vendor_ClassId @parm1 varchar ( 10) as
    Select * from Vendor where ClassId = @parm1 order by Vendid


