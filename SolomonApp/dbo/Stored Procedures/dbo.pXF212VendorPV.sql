CREATE   Procedure pXF212VendorPV
	 @parm1 As varchar(15)
AS
Select *
From Vendor
Where Vendid LIKE @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF212VendorPV] TO [MSDSL]
    AS [dbo];

