 Create Proc EDVendor_PONbr @PONbr varchar(10) As
Select * From EDVendor Where VendId = (Select VendId From PurchOrd Where PONbr = @PONbr)


