 Create Proc EDPurOrdDet_SiteId @PONbr varchar(10), @LineRef varchar(5) As
Select SiteId From PurOrdDet Where PONbr = @PONbr And LineRef = @LineRef


