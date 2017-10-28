 Create Proc EDPurchOrd_CpnyId @PONbr varchar(10) As
Select CpnyId From PurchOrd Where PONbr = @PONbr


