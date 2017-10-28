 Create	Proc DMG_10990_CleanUpINTran_LayerType
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will clean up INTran records with a blank LayerType
*/
	Set	NoCount On

	Update	INTran
		Set	LayerType = 'S'
		Where	RTrim(LayerType) = ''
			AND InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_CleanUpINTran_LayerType] TO [MSDSL]
    AS [dbo];

