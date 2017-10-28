 /****** Object:  Stored Procedure dbo.Vendor_1099    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Vendor_1099 @parm1 varchar ( 15) As
Select * from Vendor where VendID like @parm1 and
Vend1099 = 1 order by VendID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Vendor_1099] TO [MSDSL]
    AS [dbo];

