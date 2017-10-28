 CREATE proc ADG_LoadAlloc_WOMatlReq
	@WONnbr		Varchar(16),
        @pTask          Varchar(32)
As

SELECT	LineRef, InvtID, SiteID,WhseLoc, SPACE(25),
	QtyToIssue, QtyRemaining, CnvFact, 'M'
	FROM	WOMatlReq (NOLOCK)
	WHERE	WONbr = @WONnbr AND Task = @pTask



