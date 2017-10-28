 Create Proc EDVendor_Count @VendId varchar(15) As
Select Count(*) From Vendor Where VendId = @VendId


