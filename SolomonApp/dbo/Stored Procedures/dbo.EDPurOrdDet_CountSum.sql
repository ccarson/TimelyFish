 Create Proc EDPurOrdDet_CountSum @PONbr varchar(10) As
Select Count(*), Sum(QtyOrd) From PurOrdDet Where PONbr = @PONbr


