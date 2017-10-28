 CREATE Proc ADG_LoadAlloc_WOLotsert
	@WONnbr		Varchar(16),
	@LineRef	Varchar(5),
        @pTask          Varchar(32)

As

SELECT	TranLineRef, InvtID, SiteID, WhseLoc, LotSerNbr,
	-InvtMult*Qty, convert(float, 1), 'M'
	FROM	WOLotsert  (NOLOCK)
	WHERE	WONbr = @WONnbr
		AND TaskID = @pTask AND TranSDType = 'D' AND TranLineRef = @LineRef AND TranType = 'MR' AND status <> 'R'


