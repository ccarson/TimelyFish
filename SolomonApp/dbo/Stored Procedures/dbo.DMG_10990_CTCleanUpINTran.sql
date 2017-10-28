 Create	Proc DMG_10990_CTCleanUpINTran
	@InvtIDParm		VARCHAR (30)
As
/*
	This procedure will clean up erroneous CT records created during the batch release
	due to S4Future10 = 1 on Service Series and Baseline transactions that had COGS batch
	process against them.
*/
	Set	NoCount On

	Delete	From INTran
		Where	TranDesc Like '%Ovrsld%'
			And TranType = 'CT'
			AND InvtID LIKE @InvtIDParm


