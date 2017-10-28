 Create	Procedure SCM_Delete_ItemBMIHist
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LockYear	Char(4)
As
	If	RTrim(@LockYear) = ''
	Begin
		Set	@LockYear = '1900'
	End
	Delete	From	ItemBMIHist
		Where	FiscYr > @LockYear
			And InvtID =	Case 	When 	RTrim(@InvtID) <> ''
							Then	@InvtID
						Else	InvtID
					End
			And SiteID =	Case 	When 	RTrim(@SiteID) <> ''
							Then	@SiteID
						Else	SiteID
					End


