 CREATE PROC SCM_1004_SpecCostCheck
	@site_id 		char(10),
	@invt_id 		char(30),
	@spec_cost_id	char (25)
AS
	SELECT	TOP 1 Qty
	FROM	ItemCost (NOLOCK)
	WHERE	InvtId = @invt_id
	AND	SiteID = @site_id
	AND	LayerType = 'S'
	AND	SpecificCostID = @spec_cost_id
	ORDER BY InvtID, SiteID, LayerType, SpecificCostID, RcptNbr, RcptDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_1004_SpecCostCheck] TO [MSDSL]
    AS [dbo];

