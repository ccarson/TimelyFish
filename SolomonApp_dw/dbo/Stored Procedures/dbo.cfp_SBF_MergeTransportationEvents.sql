
CREATE PROCEDURE [dbo].[cfp_SBF_MergeTransportationEvents] ( @RecordsMerged AS INT OUTPUT )
AS
/*
************************************************************************************************************************************

  Procedure:    dbo.cfp_SBF_MergeTransportationEvents
     Author:    Chris Carson
    Purpose:    Compare current state transportation events to events already reported to Seaboard Farms


    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-02-15          created

    Logic Summary:
    1)  MERGE extract of transportation events data into dbo.cft_SBF_TransportEvent_REF
    2)  SELECT record count from MERGE into output variable

    Notes:

************************************************************************************************************************************
*/

    SET NOCOUNT, XACT_ABORT ON ;

BEGIN TRY

    DECLARE @StartDate  AS SMALLDATETIME = '2015-12-31'
          , @EndDate    AS SMALLDATETIME ;

    SELECT  @EndDate = DATEADD( day, 7, GETDATE() )

    MERGE    dbo.cft_SBF_TransportEvent_REF as tgt
    USING(
            SELECT  PigTruckLoadID      = pm.PMLoadID
                  , SourcePigGroupID	= ISNULL( NULLIF( 'PG' + pm.SourcePigGroupID, 'PG' ), '' ) 
                  , DestPigGroupID		= ISNULL( NULLIF( 'PG' + pm.DestPigGroupID, 'PG' ), '' ) 
                  , PigMovementID       = pm.PMID
                  , LoadPickupDateTime  = CONVERT( VARCHAR(10), pm.MovementDate, 111 ) + ' ' +  CONVERT( VARCHAR(5), pm.loadingtime, 114)
                  , SBF_SourceContactID = ISNULL( ( SELECT SBFSiteID FROM dbo.cft_SBF_ContactID_REF WHERE CFContactID = pm.SourceContactID ), '   ' )
                  , pm.SourceBarnNbr
                  , pm.SourceRoomNbr
                  , SBF_DestContactID   = ISNULL( ( SELECT SBFSiteID FROM dbo.cft_SBF_ContactID_REF WHERE CFContactID = pm.DestContactID ), '   ' )
                  , pm.DestBarnNbr
                  , pm.DestRoomNbr
                  , pm.EstimatedQty
                  , Split               = ' ' -- Best I can gather from Craig Bradley and Nancy Rusch we don't do split room destination loads
                  , Weans               = CASE WHEN CAST(pm.PMTypeID AS INT) = 1 THEN 'W' ELSE ' ' END
            FROM    [$(SolomonApp)].dbo.cftPM AS pm
            WHERE   pm.MovementDate > @StartDate AND pm.MovementDate < @EndDate
                    AND( pm.SourceContactID IN ( SELECT CFSiteContactID FROM dbo.cft_SBF_ContactID_REF )
                            OR
                         pm.DestContactID IN ( SELECT CFSiteContactID FROM dbo.cft_SBF_ContactID_REF ) )
            ) AS src
    ON      src.PigTruckLoadID=tgt.PigTruckLoadID and src.PigMovementID=tgt.PigMovementID

    WHEN MATCHED AND(   tgt.LoadPickupDateTime      != src.LoadPickupDateTime
                        OR tgt.SourcePigGroupID     != src.SourcePigGroupID
                        OR tgt.DestPigGroupID       != src.DestPigGroupID
                        OR tgt.SBF_SourceContactID  != src.SBF_SourceContactID
                        OR tgt.SourceBarnNbr        != src.SourceBarnNbr
                        OR tgt.SourceRoomNbr        != src.SourceRoomNbr
                        OR tgt.SBF_DestContactID    != src.SBF_DestContactID
                        OR tgt.DestBarnNbr          != src.DestBarnNbr
                        OR tgt.DestRoomNbr          != src.DestRoomNbr
                        OR tgt.EstimatedQty         != src.EstimatedQty
                        OR tgt.Split                != src.Split
                        OR tgt.Weans                != src.Weans
                        )
    THEN UPDATE SET     tgt.LoadPickupDateTime  = src.LoadPickupDateTime
                      , tgt.SourcePigGroupID    = src.SourcePigGroupID
                      , tgt.DestPigGroupID      = src.DestPigGroupID
                      , tgt.SBF_SourceContactID = src.SBF_SourceContactID
                      , tgt.SourceBarnNbr       = src.SourceBarnNbr
                      , tgt.SourceRoomNbr       = src.SourceRoomNbr
                      , tgt.SBF_DestContactID   = src.SBF_DestContactID
                      , tgt.DestBarnNbr         = src.DestBarnNbr
                      , tgt.DestRoomNbr         = src.DestRoomNbr
                      , tgt.EstimatedQty        = src.EstimatedQty
                      , tgt.Split               = src.Split
                      , tgt.Weans               = src.Weans
                      , tgt.MailAction          = NULL
                      , tgt.MailedDate          = NULL

    WHEN NOT MATCHED BY TARGET
    THEN INSERT(    PigTruckLoadID, SourcePigGroupID, DestPigGroupID, PigMovementID, LoadPickupDateTime
                        , SBF_SourceContactID, SourceBarnNbr, SourceRoomNbr, SBF_DestContactID, DestBarnNbr
                        , DestRoomNbr, EstimatedQty, Split, Weans )
         VALUES(    src.PigTruckLoadID, src.SourcePigGroupID, src.DestPigGroupID, src.PigMovementID, src.LoadPickupDateTime
                        , src.SBF_SourceContactID, src.SourceBarnNbr, src.SourceRoomNbr, src.SBF_DestContactID, src.DestBarnNbr
                        , src.DestRoomNbr, src.EstimatedQty, src.Split, src.Weans ) ;

    SELECT  @RecordsMerged = @@ROWCOUNT ;

END TRY 

BEGIN CATCH
	IF	@@TRANCOUNT > 0 ROLLBACK TRANSACTION ;
	DECLARE	@ErrorMessage AS NVARCHAR(2048) = ERROR_MESSAGE() ;
	RAISERROR( @ErrorMessage, 16, 1 ) ; 
	RETURN 55555 ;
END CATCH