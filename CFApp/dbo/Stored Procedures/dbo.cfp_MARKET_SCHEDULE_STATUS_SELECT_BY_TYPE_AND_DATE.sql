-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/18/2008
-- Description:	Selects records from the table cftPMStatus
-- =============================================
CREATE PROCEDURE [dbo].[cfp_MARKET_SCHEDULE_STATUS_SELECT_BY_TYPE_AND_DATE]
(
	@MarketTypeID			char(2),
	@MovementSundayDate		smalldatetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @CurrentStatus int
	DECLARE @NextStatus int
	DECLARE @PreviousStatus int

	--current status
	SET @CurrentStatus =    
		(SELECT top 1 cftPMStatus.PMStatusID
			FROM [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK)
			JOIN [$(SolomonApp)].dbo.cftPMStatus cftPMStatus (NOLOCK) on cftPMStatus.PMStatusID=cftPMWeekStatus.PMStatusID
					  and cftPMStatus.PMTypeID = cftPMWeekStatus.PMTypeID
		  WHERE WeekOfDate = @MovementSundayDate
		  AND cftPMStatus.PMTypeID = @MarketTypeID
		  ORDER BY cftPMWeekStatus.Lupd_DateTime DESC)

	--Next status
	SET @NextStatus = 
		(Select min(PMStatusID) 
			from [$(SolomonApp)].dbo.cftPMStatus cftPMStatus (NOLOCK)
			where PMTypeID = @MarketTypeID
			and PMStatusID > @CurrentStatus)

	--Previous Status
	SET @PreviousStatus = 
		(Select Max(PMStatusID) 
			from [$(SolomonApp)].dbo.cftPMStatus cftPMStatus (NOLOCK)
			where PMTypeID = @MarketTypeID
            and PMStatusID < @CurrentStatus)

	--return the results
	IF @CurrentStatus IS NOT NULL
		BEGIN
		SELECT max(cftPMWeekStatus.WeekOfDate) 'WeekOfDate',
				cftPMStatus.PMStatusID, 
				cftPMStatus.Description
		FROM [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK)
		JOIN [$(SolomonApp)].dbo.cftPMStatus cftPMStatus (NOLOCK) on cftPMStatus.PMStatusID=cftPMWeekStatus.PMStatusID
								  and cftPMStatus.PMTypeID = cftPMWeekStatus.PMTypeID
		WHERE cftPMStatus.PMTypeID = @MarketTypeID
		and CAST(cftPMStatus.PMStatusID AS INT) BETWEEN COALESCE(@PreviousStatus,@CurrentStatus,@NextStatus) AND COALESCE(@NextStatus,@CurrentStatus,@PreviousStatus)
		GROUP BY cftPMStatus.PMStatusID, 
				 cftPMStatus.Description
		Order By cftPMStatus.PMStatusID
	END
	ELSE
		-- If there is no current status, get the min status in the table
		SELECT cftPMStatus.PMStatusID, cftPMStatus.Description 
		FROM [$(SolomonApp)].dbo.cftPMStatus cftPMStatus(NOLOCK)
		inner join (select MIN(PMStatusID) 'PMStatusID' 
					FROM [$(SolomonApp)].dbo.cftPMStatus (NOLOCK)) MinStatus
				    ON MinStatus.PMStatusID = cftPMStatus.PMStatusID
		WHERE cftPMStatus.PMTypeID = @MarketTypeID
		Order By cftPMStatus.PMStatusID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MARKET_SCHEDULE_STATUS_SELECT_BY_TYPE_AND_DATE] TO [db_sp_exec]
    AS [dbo];

