

-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/13/2008
-- Description:	Show quantities in a date range
-- Parameters: 	@ContactID, @StartDate, @EndDate
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_TRUCKING] 
@ContactID INT,
@StartDate DATETIME,
@EndDate DATETIME
AS

IF @ContactID = 0
BEGIN
	SELECT
		vxt605markettrucking.TruckerContactID
	,	TruckerContact.ShortName
	,	SUM(vxt605markettrucking.Livewgt) Livewgt
	,	SUM(vxt605markettrucking.StdQty) StdQty
	,	SUM(vxt605markettrucking.SubQty) SubQty
	,	SUM(vxt605markettrucking.DeadQty) DeadQty
	FROM	[$(SolomonApp)].dbo.vxt605markettrucking vxt605markettrucking (NOLOCK)
	LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
		ON TruckerContact.ContactID = vxt605markettrucking.TruckerContactID
	WHERE	vxt605markettrucking.SaleDate BETWEEN @StartDate AND @EndDate
	GROUP BY
		vxt605markettrucking.TruckerContactID
	,	TruckerContact.ShortName
	ORDER BY
		TruckerContact.ShortName
END
ELSE
BEGIN
	SELECT
		vxt605markettrucking.TruckerContactID
	,	TruckerContact.ShortName
	,	SUM(vxt605markettrucking.Livewgt) Livewgt
	,	SUM(vxt605markettrucking.StdQty) StdQty
	,	SUM(vxt605markettrucking.SubQty) SubQty
	,	SUM(vxt605markettrucking.DeadQty) DeadQty
	FROM	[$(SolomonApp)].dbo.vxt605markettrucking vxt605markettrucking (NOLOCK)
	LEFT OUTER JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK)
		ON TruckerContact.ContactID = vxt605markettrucking.TruckerContactID
	WHERE	vxt605markettrucking.SaleDate BETWEEN @StartDate AND @EndDate
	AND	TruckerContact.ContactID = @ContactID
	GROUP BY
		vxt605markettrucking.TruckerContactID
	,	TruckerContact.ShortName
	ORDER BY
		TruckerContact.ShortName
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_TRUCKING] TO [db_sp_exec]
    AS [dbo];

