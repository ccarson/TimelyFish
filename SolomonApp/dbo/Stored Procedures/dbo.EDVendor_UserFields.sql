 CREATE Proc EDVendor_UserFields @VendId varchar(15) As
Select VendId, User1, User2, User3, User4, User5, User6, User7, User8 From Vendor
Where VendId = @VendId


