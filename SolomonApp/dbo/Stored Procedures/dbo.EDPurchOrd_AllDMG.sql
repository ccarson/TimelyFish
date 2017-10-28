 Create Proc EDPurchOrd_AllDMG @PONbr varchar(10) As
Select * From EDPurchOrd Where PONbr = @PONbr


