 Create Proc EDPurchOrd_Open @Parm1 varchar(15) As
Select *
From PurchOrd A
	left outer join EDPurchOrd B
		on A.PONbr = B.PONbr
Where A.VendId = @Parm1
	And A.Status Not In ('X','M')


