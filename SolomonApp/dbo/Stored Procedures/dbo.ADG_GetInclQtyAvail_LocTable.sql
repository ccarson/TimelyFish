 Create Proc ADG_GetInclQtyAvail_LocTable
	@SiteID		Varchar(10),
	@WhseLoc	Varchar(10)
As

SELECT	InclQtyAvail
	FROM	LocTable (NOLOCK)
	WHERE	SiteID = @SiteID AND WhseLoc = @WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_GetInclQtyAvail_LocTable] TO [MSDSL]
    AS [dbo];

