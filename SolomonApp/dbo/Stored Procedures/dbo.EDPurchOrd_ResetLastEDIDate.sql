 Create Proc EDPurchOrd_ResetLastEDIDate @PONbr varchar(10) As
Update EDPurchOrd Set LastEDIDate = '01/01/1900' Where PONbr = @PONbr


