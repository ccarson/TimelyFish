 Create	Proc DMG_10990_CleanUpINTran_Periods
As
/*
	This procedure will clean up INTran records with a blank
	BMICuryID, FiscYr, PerEnt and PerPost
*/
	Set	NoCount On

	Declare	@BMICuryID	VarChar(4),
		@FiscYr		VarChar(4),
		@PerNbr		VarChar(6)

	Select 	@BMICuryID = BMICuryID,
		@FiscYr = Left(PerNbr, 4),
		@PerNbr = PerNbr
		From INSetup

	Update	INTran
		Set	BMICuryID = 	Case When RTrim(BMICuryID) = ''
						Then @BMICuryID
						Else BMICuryID
				    	End,
			FiscYr = 	Case When RTrim(FiscYr) = ''
						Then @FiscYr
						Else FiscYr
					End,
			PerEnt = 	Case When RTrim(PerEnt) = ''
						Then @PerNbr
						Else PerEnt
					End,
			PerPost = 	Case When RTrim(PerPost) = ''
						Then @PerNbr
						Else PerPost
					End
		Where	RTrim(FiscYr) = ''
			Or RTrim(PerPost) = ''
			Or RTrim(PerEnt) = ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_CleanUpINTran_Periods] TO [MSDSL]
    AS [dbo];

