
-- ====================================================================================
-- Author:	Brian Cesafsky
-- Create date: 08/02/2009
-- Description:	selects records that are ready for the Interstate Pig Movement report
-- ====================================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_MOVEMENT_INTERSTATE_SELECT]
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;
      
      declare @CheckDate datetime
      declare @StartDate datetime
      declare @EndDate datetime

      --@CheckDate is set to the current date and the time is always 12:00PM
      set @CheckDate = dateadd(hour,12,convert(varchar,getdate(),101))
      --@StartDate is set to the current date and the time is always 12:00AM
      set @StartDate = convert(varchar,dateadd(d,1,getdate()),101)
      
      --For testing, you can set @CheckDate to what you need
      --set @CheckDate = 'Aug  5 2009 10:00AM'
      IF getdate() >= @CheckDate
      BEGIN
			IF (datename(weekday,getdate()) = 'Friday')
			BEGIN
				set @EndDate = dateadd(hour,71,@StartDate)
				set @EndDate = dateadd(minute,59,@EndDate)
			END
			ELSE
			BEGIN
				set @EndDate = dateadd(hour,23,@StartDate)
				set @EndDate = dateadd(minute,59,@EndDate)
			END
            SELECT Distinct 
			    cftPM.PMID
			  , cftPM.PMLoadID
              , cftPM.SourceContactID
              , cftPM.MovementDate
              , cftPM.DestContactID
              , cs.ContactName as SiteName
            FROM [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
              LEFT JOIN [$(SolomonApp)].dbo.cftSite s on cftPM.SourceContactID=s.ContactID
              LEFT JOIN [$(SolomonApp)].dbo.cftContact cs ON cftPM.SourceContactID=cs.ContactID
              LEFT JOIN [$(SolomonApp)].dbo.cftContact ds ON cftPM.DestContactID = ds.ContactID
              LEFT JOIN [$(SolomonApp)].dbo.cftContactAddress sca ON sca.ContactID = cs.ContactID and sca.AddressTypeID = 1
              LEFT JOIN [$(SolomonApp)].dbo.cftAddress sa ON sa.AddressID = sca.AddressID
              LEFT JOIN [$(SolomonApp)].dbo.cftContactAddress dca ON dca.ContactID = ds.ContactID and dca.AddressTypeID = 1
              LEFT JOIN [$(SolomonApp)].dbo.cftAddress da ON da.AddressID = dca.AddressID
              LEFT JOIN [$(SolomonApp)].dbo.cftPigOffload o on cftPM.PMID=o.SrcPMID
              LEFT JOIN [$(SolomonApp)].dbo.cftPM op on o.DestPMID=op.PMID 
			  JOIN [$(CentralData)].dbo.Site cdsite 
				on cdsite.ContactID = cast(s.ContactID as int) 
				and isnull(cdsite.AutomateInterstatePigMovementReport,0) <> 0    
            WHERE (cftPM.TattooFlag<>0 or op.TattooFlag<>0)
            AND cftPM.Highlight<>255
			AND cftPM.PigTypeID not in ('01', '04', '05', '07', '09', '10', '11')
            AND left(cftPM.TranSubTypeID,1)<>'O'
            AND cftPM.MovementDate between @StartDate and @EndDate
            AND NOT EXISTS 
                  (SELECT * FROM dbo.cft_PIG_MOVEMENT_INTERSTATE_TEMP tpm (NOLOCK) 
                  WHERE tpm.PMID = cftPM.PMID
                  AND   tpm.DestContactID = cftPM.DestContactID)
			AND sa.State <> da.State
      END
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_MOVEMENT_INTERSTATE_SELECT] TO [db_sp_exec]
    AS [dbo];

