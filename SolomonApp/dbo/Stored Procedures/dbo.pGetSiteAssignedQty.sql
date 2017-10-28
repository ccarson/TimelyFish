Create Proc pGetSiteAssignedQty 
	@DestSiteID varchar(4),
	@WeanDate smalldatetime
	As
	Select AssignedQty = 
	IsNull((select sum(IsNull(qty,0)) from dbo.weanentrywrk 
		where destinationsiteid = @DestSiteID AND WeanDate Between (@WeanDate - 14) And (@WeanDate +14)) ,0) -- +
	--IsNull((select sum(IsNull(estimatedqty,0)) from dbo.pigmovement 
	--	where destinationsiteid = @DestSiteID AND MovementDate Between (@WeanDate - 14) And (@WeanDate +14)) ,0) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pGetSiteAssignedQty] TO [MSDSL]
    AS [dbo];

