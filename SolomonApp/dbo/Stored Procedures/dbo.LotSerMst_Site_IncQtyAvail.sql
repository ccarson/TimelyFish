 Create	Procedure LotSerMst_Site_IncQtyAvail
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@WhseLoc	VARCHAR (10)
As
	SELECT W.INCLQTYAVAIL
		FROM LOTSERMST L
			JOIN LOCTABLE W
				ON L.SITEID = W.SITEID
				AND L.WHSELOC = W.WHSELOC
		WHERE L.SITEID = @SiteID
			AND L.WHSELOC = @WhseLoc
			AND L.INVTID = @InvtID


