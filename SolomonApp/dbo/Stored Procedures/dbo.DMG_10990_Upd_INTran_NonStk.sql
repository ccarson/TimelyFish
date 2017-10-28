 CREATE PROCEDURE DMG_10990_Upd_INTran_NonStk
	@InvtIDParm VARCHAR (30)
AS
/*
	This procedure will update all INTran.S4Future09 = 1 on all transactions
	for non-stock items that are not retired (S4Future05 = 0) and are not
	flagged as non-stock (S4Future09 = 0).
*/

Update	INTran Set INTran.S4Future09 = 1
	From	INTran Inner Join Inventory (NoLock)
		On INTran.InvtID = Inventory.InvtID
	Where   Inventory.StkItem  = 0    	/* Non-Stock */
		And INTran.S4Future05 = 0	/* Not Retired */
		And INTran.S4Future09 = 0
		AND INTran.InvtID LIKE @InvtIDParm


