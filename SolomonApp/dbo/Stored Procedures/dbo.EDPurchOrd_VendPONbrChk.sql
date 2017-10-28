 Create Proc EDPurchOrd_VendPONbrChk @PONbr varchar(10), @VendId varchar(15) As
Select Count(*) From PurchOrd Where PONbr = @PONbr And VendId = @VendId


