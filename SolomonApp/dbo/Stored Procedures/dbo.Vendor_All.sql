 /****** Object:  Stored Procedure dbo.Vendor_All    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Vendor_All @parm1 varchar ( 15) as
Select * from Vendor where VendId like @parm1 order by VendId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Vendor_All] TO [MSDSL]
    AS [dbo];

