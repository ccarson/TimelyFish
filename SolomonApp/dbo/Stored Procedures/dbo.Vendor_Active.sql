 /****** Object:  Stored Procedure dbo.Vendor_Active    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Vendor_Active @parm1 varchar ( 15) As
Select * from Vendor Where Status <> 'H' and VendId Like @parm1
Order By VendId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Vendor_Active] TO [MSDSL]
    AS [dbo];

