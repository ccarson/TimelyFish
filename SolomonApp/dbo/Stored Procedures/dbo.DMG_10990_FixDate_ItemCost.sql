 Create	Proc DMG_10990_FixDate_ItemCost
	@InvtIDParm VARCHAR (30)
As
	Update	ItemCost
		Set	RcptDate = Cast(Cast(Month(RcptDate) As VarChar(4)) + '/'
					+ Cast(Day(RcptDate) As VarChar(4)) + '/'
					+ Cast(Year(RcptDate) As VarChar(4)) As SmallDateTime)
		Where	Cast(Cast(Month(RcptDate) As VarChar(4)) + '/'
				+ Cast(Day(RcptDate) As VarChar(4)) + '/'
				+ Cast(Year(RcptDate) As VarChar(4)) As SmallDateTime) <> RcptDate
			AND ItemCost.InvtID LIKE @InvtIDParm


