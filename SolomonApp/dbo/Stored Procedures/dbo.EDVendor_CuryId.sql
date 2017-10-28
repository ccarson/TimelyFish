 Create Proc EDVendor_CuryId @VendId varchar(15) As
Select CuryId From Vendor Where VendId = @VendId


