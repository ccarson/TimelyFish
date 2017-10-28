


-- =============================================
-- Author:		Matt Dawson
-- Create date: 10/10/2008
-- Description:	
-- 2011/10/03 replaced selected column ft.net with a caluculation of wetpounds 
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_DELIVERIES_BY_FARM]
(	
	@CornProducerID varchar(15)
,	@StartDate datetime
,	@EndDate datetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT
	Vendor.Name 'ContactName'
,	v.CornProducerID
,	ft.SourceFarm
,	CONVERT(VARCHAR,ft.DeliveryDate,101) 'DeliveryDate'
,	ft.TicketNumber
,	sum(pt.WetBushels) 'WetBushels'
--,	cast(ft.Net / 56 as numeric(18,4)) 'WetBushels'
--,	ft.Net 'WetPounds'
,	round(cast(sum(pt.WetBushels) * 56 as numeric(18,0)),-1)  'WetPounds'
,	SUM(pt.DryBushels) 'DryBushels'
,	ft.Moisture
,	ft.TestWeight
,	ft.ForeignMaterial
,	ct.Name
, substring(ft.Comments,1,9) as comments
FROM	dbo.cft_Corn_Ticket ft (NOLOCK)
INNER JOIN dbo.cft_Partial_Ticket pt (NOLOCK)
	ON pt.FullTicketID = ft.TicketID
INNER JOIN dbo.cft_Corn_Producer v (NOLOCK)
	ON v.CornProducerID = ft.CornProducerID
LEFT OUTER JOIN dbo.cft_Vendor Vendor (NOLOCK)
	ON RTRIM(Vendor.VendID) = RTRIM(v.CornProducerID)
LEFT OUTER JOIN dbo.cft_Contract c (NOLOCK)
	ON c.ContractID = pt.ContractID
LEFT OUTER JOIN dbo.cft_Contract_Type ct (NOLOCK)
	ON ct.ContractTypeID = c.ContractTypeID
WHERE	RTRIM(v.CornProducerID) = @CornProducerID
AND	ft.DeliveryDate BETWEEN @StartDate AND @EndDate
GROUP BY
	Vendor.Name
,	v.CornProducerID
,	ft.SourceFarm
,	ft.DeliveryDate
,	ft.TicketNumber
,	ft.Net
,	ft.Moisture
,	ft.TestWeight
,	ft.ForeignMaterial
,	ct.Name
,   ft.comments
ORDER BY
	ft.SourceFarm
,	ft.DeliveryDate
,	ft.TicketNumber


END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_DELIVERIES_BY_FARM] TO [db_sp_exec]
    AS [dbo];

