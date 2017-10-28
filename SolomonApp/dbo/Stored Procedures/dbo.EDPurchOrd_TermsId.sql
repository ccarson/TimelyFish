 Create Proc EDPurchOrd_TermsId @PONbr varchar(10) As
Select Terms From PurchOrd Where PONBr = @PONbr


