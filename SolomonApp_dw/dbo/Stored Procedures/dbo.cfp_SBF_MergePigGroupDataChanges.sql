
CREATE PROCEDURE [dbo].[cfp_SBF_MergePigGroupDataChanges] ( @RecordsMerged AS INT OUTPUT )
AS
/*
************************************************************************************************************************************

  Procedure:    dbo.cfp_SBF_MergePigGroupDataChanges
     Author:    Chris Carson
    Purpose:    Compare current state PigGroup data with current record of PigGroup data, record changes

    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-02-15          created
    ccarson         2016-02-24          revised MERGE to compare only fields that are reported on for changes
                                            the final report listed too many records that had changed when actually 
                                            most of the record changes were not material to the report.

    Logic Summary:
    1)  MERGE extract of transportation events data into dbo.cft_SBF_PigGroup_REF
    2)  SELECT record count from MERGE into output variable

    Notes:

************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

BEGIN TRY
    MERGE    dbo.cft_SBF_PigGroup_REF AS tgt
    USING(  SELECT  cpg.ActStartDate
                  , cpg.Crtd_dateTime
                  , cpg.ActCloseDate
                  , cpg.Lupd_DateTime
                  , cpg.BarnNbr
                  , FlowID              = cpg.CF08
                  , cpf.PigFlowDescription
                  , cpg.SiteContactID
                  , SiteName            = c.ContactName
                  , PG_Description      = cpg.Description
                  , cpg.EstCloseDate
                  , cpg.EstStartWeight
                  , cpg.FeedMillContactID
                  , FeedMillName        = fc.ContactName
                  , cpg.InitialPigValue
                  , cpg.PGStatusID
                  , cpg.PigGroupID
                  , cpg.PigProdPhaseID
                  , cpg.PriorFeedQty
                  , cpg.ProjectID
                  , cpg.TaskID
                  , cpg.PigGenderTypeID
                  , pgg.PigChampGeneticName
                  , dys.EstDaysofAge
                  , dys.EstPlacementAge
                  , dys.AvgStartWeight
                  , Plc.FirstPlacementDt
                  , cpg.EstInventory
                  , SiteOwnership       = CASE sot.SiteOwnershipDescription 
                                            WHEN 'Company' THEN 'OWN'
                                            WHEN 'Contract' THEN 'CON'
                                            ELSE 'CON'
                                          END
                  , StdCapacity         = b.StdCap
                  , StockingMultiplier  = ISNULL(den.Mult, 'S')
                  , OriginSiteContactID = sr.origSiteContactId
                  , AirSpaceOnMove      = CASE  WHEN ISNULL(sr.origSiteContactId,-1) = -1 THEN '' 
                                                WHEN cpg.sitecontactid <> sr.origSiteContactId THEN 'M' 
                                                ELSE 'S' 
                                          END 
                  , SBFNurSrceContactID = CASE cpg.PigProdPhaseID 
                                            WHEN 'FIN' THEN( ISNULL( ( SELECT SBFSiteID FROM dbo.cft_SBF_ContactID_REF
                                                                        WHERE CFContactID = sr.origSiteContactId ), '   ' ) )
                                            ELSE '   '
                                          END 
                  , SBF_SiteID          = ( SELECT ISNULL( SBFSiteID, '000' ) FROM dbo.cft_SBF_ContactID_REF
                                             WHERE CFSiteContactID = CPG.SiteContactID )
                  , SBFSrceSowFarm      = CASE  WHEN cpg.PigProdPhaseID IN ('WTF','NUR') 
                                                    THEN( ISNULL( ( SELECT SBFSiteID FROM dbo.cft_SBF_ContactID_REF
                                                                     WHERE CFContactID = sc.ContactID ), '   ' ) )
                                                ELSE '   ' 
                                          END 
                  , RoomNbr             = CASE  WHEN PATINDEX( '%R[^a-Z]%/%', cpg.description COLLATE SQL_Latin1_General_CP1_CS_AS ) > 0 
                                                    THEN SUBSTRING( cpg.Description, PATINDEX( '%R[^a-Z]%/%', cpg.description COLLATE SQL_Latin1_General_CP1_CS_AS ), LEN( RTRIM( cpg.description ) ) )
                                                ELSE ''
                                          END 
            FROM        [$(SolomonApp)].dbo.cftPigGroup AS cpg
            INNER JOIN  [$(CentralData)].dbo.Contact AS c ON c.ContactID=cpg.SiteContactID
            INNER JOIN  [$(CentralData)].dbo.Contact AS fc ON fc.ContactID=cpg.FeedMillContactID
            INNER JOIN  [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW AS cpf ON cpf.PigFlowID=cpg.CF08
            INNER JOIN  [$(CentralData)].dbo.site AS s ON s.contactid=c.ContactID
            LEFT JOIN   [$(CentralData)].dbo.SiteOwnershipType AS sot ON sot.SiteOwnershipTypeID=s.OwnershipID
            LEFT JOIN   [$(CentralData)].dbo.Barn AS b ON b.SiteID=s.SiteID AND b.BarnNbr=cpg.BarnNbr
            LEFT JOIN(  -- starting stocking density
                        SELECT  TaskID          = RTRIM( pg.Taskid )
                              , pg.barnnbr
                              , StPercentage    = ((CAST(CAST(estInventory AS NUMERIC)/CAST(ISNULL(maxcap,ISNULL(estInventory,1)) AS NUMERIC) AS NUMERIC(6,2)))) 
                              , Mult            = CASE  WHEN ((CAST(CAST(estInventory AS NUMERIC)/CAST(ISNULL(maxcap,ISNULL(estInventory,1)) AS NUMERIC) AS NUMERIC(6,2)))) > 1.3 
                                                            THEN 'D' 
                                                        ELSE 'S' 
                                                  END
                        FROM        [$(SolomonApp)].dbo.cftpiggroup AS pg
                        LEFT JOIN   [$(SolomonApp)].dbo.cftbarn AS b ON pg.sitecontactid=b.contactid AND pg.barnnbr=b.barnnbr
                        WHERE       ISNULL(maxcap,0) > 0  
                        ) AS den ON den.Taskid=cpg.taskid
                        
            LEFT JOIN(  -- Primary sire genetics for group
                        SELECT  taskid, MAX([% Genetics]) AS mx_gen
                        FROM    dbo.cft_Pig_Group_Genetics
                        GROUP BY taskid
                        ) AS pgg1 ON cpg.TaskID=pgg1.TaskID
                        
            LEFT JOIN   dbo.cft_Pig_Group_Genetics pgg ON pgg.TaskID=pgg1.TaskID 
                        AND pgg.[% Genetics]=pgg1.mx_gen
                        
            LEFT JOIN(  -- First pig placement date for group
                        SELECT  pg.piggroupid,
                                pg.TaskID,
                                MIN(t.trandate) AS FirstPlacementDt
                        FROM    [$(SolomonApp)].dbo.cftPigGroup AS pg
                        LEFT JOIN   [$(SolomonApp)].dbo.cftPGInvTran AS t 
                                    ON pg.PigGroupID = t.PigGroupID 
                                        AND t.acct IN( 'PIG TRANSFER IN', 'PIG PURCHASE', 'PIG MOVE IN' )
                                        AND t.Reversal <> 1
                        WHERE   t.TranDate !< '11/1/2014' 
                        GROUP BY pg.piggroupid, pg.TaskID 
                    ) AS Plc on plc.piggroupid = cpg.piggroupid
                    
            LEFT JOIN(  -- Get source pig group site contactId - used to determine if pigs moved sites (NUR->FIN)
                        SELECT  pg.piggroupid,
                                pg.TaskID,
                                max(pgs.SiteContactID) AS origSiteContactId,
                                MAX(t.sourceProject) AS SourceProject,
                                min(trandate) AS FirstPlacementDt
                        FROM [$(SolomonApp)].dbo.cftPigGroup AS pg
                      LEFT JOIN [$(SolomonApp)].dbo.cftPGInvTran AS t ON pg.PigGroupID = t.PigGroupID 
                            AND (t.acct = 'PIG TRANSFER IN' OR t.acct = 'PIG PURCHASE' OR t.acct = 'PIG MOVE IN')
                            AND t.Reversal <> 1
                      Left JOIN [$(SolomonApp)].dbo.cftPigGroup pgs on pgs.piggroupid = t.sourcepiggroupid
                     WHERE (t.TranDate>='11/1/2014') 
                    GROUP BY pg.piggroupid, pg.TaskID
                    ) sr on sr.piggroupid = cpg.piggroupid and sr.FirstPlacementDt=plc.FirstPlacementDt
          left join [$(CentralData)].dbo.site ss on ss.siteid=right(rtrim(sr.SourceProject),4)
          left join [$(CentralData)].dbo.Contact sc on ss.ContactID=sc.ContactID
          left join ( -- Estimated Days of Age of Pigs in Group
                     select pg.PigGroupID, 
                            pg.TaskId, 
                            Round(PGDetail.AvgStWt, 2) AvgStartWeight, 
                            -- Days of Age Calculation from Adam Dietz
                            Round (Datediff(day, PGDetail.AvgPigTransferDate,GETDATE()) +
                                    (-0.000000000007183 * power(AvgStWt,6)
                                     +0.000000006941667 * power(AvgStWt,5)
                                     -0.000002651573233 * power(AvgStWt,4)
                                     +0.000509425663432 * power(AvgStWt,3) 
                                     -0.051939340963695 * power(AvgStWt,2)
                                     +3.172220285186420 * AvgStWt
                                     -35.530545258570700), 2) + 22
                            As EstDaysOfAge,
                            Round (
                                    (-0.000000000007183 * power(AvgStWt,6)
                                     +0.000000006941667 * power(AvgStWt,5)
                                     -0.000002651573233 * power(AvgStWt,4)
                                     +0.000509425663432 * power(AvgStWt,3) 
                                     -0.051939340963695 * power(AvgStWt,2)
                                     +3.172220285186420 * AvgStWt
                                     -35.530545258570700), 2) + 22
                            As EstPlacementAge
                      from [$(SolomonApp)].dbo.cftpiggroup pg
                    left join 
                    (SELECT cftPigGroup.PigGroupID, cftPigGroup.TaskID, 
                            CAST(CONVERT(varchar, CAST(SUM(TransferDates.Qty * TransferDates.DateConvert)/ SUM(TransferDates.Qty) AS datetime), 101) AS datetime) AS 'AvgPigTransferDate', 
                            TransferDates.TranDate StDate, cftpiggroup.pigprodphaseid, cftpiggroup.pigsystemid, 
                            SUM(TransferDates.TotalWgt)/SUM(TransferDates.Qty) AvgStWt
                        FROM   [$(SolomonApp)].dbo.cftPigGroup AS cftPigGroup 
                            LEFT OUTER JOIN
                            (SELECT cftPigGroup.PigGroupID, cftPGInvTran.Qty, cftPGInvTran.TotalWgt, vCFPigGroupStart.TranDate, 
                                    CAST(cftPGInvTran.TranDate AS float) AS 'DateConvert'
                                FROM [$(SolomonApp)].dbo.cftPigGroup AS cftPigGroup WITH (NOLOCK) 
                                LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPGInvTran AS cftPGInvTran WITH (NOLOCK) ON cftPGInvTran.PigGroupID = cftPigGroup.PigGroupID 
                                LEFT OUTER JOIN [$(SolomonApp)].dbo.vCFPigGroupStart AS vCFPigGroupStart ON vCFPigGroupStart.PigGroupID = cftPigGroup.PigGroupID
                                WHERE (cftPGInvTran.Reversal <> 1) AND (cftPGInvTran.acct = 'PIG TRANSFER IN' OR
                                       cftPGInvTran.acct = 'PIG PURCHASE') OR
                                      (cftPGInvTran.Reversal <> 1) AND (cftPGInvTran.acct = 'PIG MOVE IN') AND (cftPGInvTran.TranDate <= DATEADD(d, 21, 
                                      vCFPigGroupStart.TranDate))) 
                             AS TransferDates ON cftPigGroup.PigGroupID = TransferDates.PigGroupID
                         WHERE      cftPigGroup.PigProdPhaseID IN ('FIN','WTF','NUR','HIN','ISO') AND cftPigGroup.PGStatusId not in ('X')
                         GROUP BY cftPigGroup.PigGroupID, cftPigGroup.TaskID, cftPigGroup.UseActualsFlag, TransferDates.TranDate, 
                                    cftpiggroup.pigprodphaseid, cftpiggroup.singlestock, cftpiggroup.pigsystemid)
                    As PGDetail on pg.TaskID=PGDetail.TaskID
                    ) dys on dys.TaskID=cpg.TaskID
         where cpg.PGStatusID <> 'X' --cpg.ActCloseDate = '1900-01-01 00:00:00' and 
           and cpg.PigProdPodID = 53 -- Seaboard Pod
           and cpg.SiteContactID IN ( SELECT CFSiteContactID FROM dbo.cft_SBF_ContactID_REF )

) as src on src.PigGroupId=tgt.PigGroupID

    WHEN MATCHED AND    tgt.Lupd_DateTime != src.Lupd_DateTime
                        AND(    tgt.Crtd_dateTime           != src.Crtd_DateTime
                                OR  tgt.ActCloseDate        != src.ActCloseDate
                                OR  tgt.TaskID              != src.TaskID
                                OR  tgt.EstDaysOfAge        != src.estDaysofAge
                                OR  tgt.PigProdPhaseID      != src.PigProdPhaseID
                                OR  tgt.StockingMultiplier  != src.StockingMultiplier
                                OR  tgt.AirSpaceOnMove      != src.AirSpaceOnMove
                                OR  tgt.PigChampGeneticName != src.PigChampGeneticName
                                OR  tgt.PigGenderTypeID     != src.PigGenderTypeID
                                OR  tgt.SBF_SiteID          != src.SBF_SiteID
                                OR  tgt.SBFSrceSowFarm      != src.SBFSrceSowFarm
                                OR  tgt.SBFNurSrceContactID != src.SBFNurSrceContactID
                                OR  tgt.SiteOwnerShip       != src.SiteOwnership
                                OR  tgt.BarnNbr             != src.BarnNbr
                                OR  tgt.RoomNbr             != src.RoomNbr
                                OR  tgt.EstPlacementAge     != src.EstPlacementAge )
                            
    THEN UPDATE SET     tgt.ActStartDate        = src.ActStartDate        
                      , tgt.Crtd_dateTime       = src.Crtd_dateTime       
                      , tgt.ActCloseDate        = src.ActCloseDate        
                      , tgt.Lupd_DateTime       = src.Lupd_DateTime       
                      , tgt.BarnNbr             = src.BarnNbr             
                      , tgt.FlowID              = src.FlowID              
                      , tgt.PigFlowDescription  = src.PigFlowDescription  
                      , tgt.SiteContactID       = src.SiteContactID       
                      , tgt.SiteName            = src.SiteName            
                      , tgt.PG_Description      = src.PG_Description      
                      , tgt.EstCloseDate        = src.EstCloseDate        
                      , tgt.EstStartWeight      = src.EstStartWeight      
                      , tgt.FeedMillContactID   = src.FeedMillContactID   
                      , tgt.FeedMillName        = src.FeedMillName        
                      , tgt.InitialPigValue     = src.InitialPigValue     
                      , tgt.PGStatusID          = src.PGStatusID          
                      , tgt.PigProdPhaseID      = src.PigProdPhaseID      
                      , tgt.PriorFeedQty        = src.PriorFeedQty        
                      , tgt.ProjectID           = src.ProjectID           
                      , tgt.TaskID              = src.TaskID              
                      , tgt.PigGenderTypeID     = src.PigGenderTypeID     
                      , tgt.PigChampGeneticName = src.PigChampGeneticName 
                      , tgt.EstDaysOfAge        = src.EstDaysOfAge        
                      , tgt.EstPlacementAge     = src.EstPlacementAge     
                      , tgt.AvgStartWeight      = src.AvgStartWeight      
                      , tgt.FirstPlacementDt    = src.FirstPlacementDt    
                      , tgt.EstInventory        = src.EstInventory        
                      , tgt.SiteOwnerShip       = src.SiteOwnerShip       
                      , tgt.StdCapacity         = src.StdCapacity         
                      , tgt.StockingMultiplier  = src.StockingMultiplier  
                      , tgt.OriginSiteContactID = src.OriginSiteContactID 
                      , tgt.AirSpaceOnMove      = src.AirSpaceOnMove      
                      , tgt.SBFNurSrceContactID = src.SBFNurSrceContactID 
                      , tgt.SBF_SiteID          = src.SBF_SiteID          
                      , tgt.SBFSrceSowFarm      = src.SBFSrceSowFarm      
                      , tgt.RoomNbr             = src.RoomNbr             
                      , tgt.MailAction          = NULL
                      , tgt.MailedDate          = NULL
                
WHEN NOT MATCHED BY TARGET THEN 
   INSERT(  ActStartDate, Crtd_dateTime, ActCloseDate, Lupd_DateTime, BarnNbr, FlowID, PigFlowDescription, SiteContactID
                , SiteName, PG_Description, EstCloseDate, EstStartWeight, FeedMillContactID, FeedMillName, InitialPigValue
                , PGStatusID, PigGroupId, PigProdPhaseID, PriorFeedQty, ProjectID, TaskID, PigGenderTypeID, PigChampGeneticName
                , EstDaysOfAge, EstPlacementAge, AvgStartWeight, FirstPlacementDt, EstInventory, SiteOwnerShip, StdCapacity
                , StockingMultiplier, OriginSiteContactID, AirSpaceOnMove, SBFNurSrceContactID, SBF_SiteID, SBFSrceSowFarm, RoomNbr ) 
   VALUES(  src.ActStartDate, src.Crtd_dateTime, src.ActCloseDate, src.Lupd_DateTime, src.BarnNbr, src.FlowID, src.PigFlowDescription, src.SiteContactID
                , src.SiteName, src.PG_Description, src.EstCloseDate, src.EstStartWeight, src.FeedMillContactID, src.FeedMillName, src.InitialPigValue
                , src.PGStatusID, src.PigGroupId, src.PigProdPhaseID, src.PriorFeedQty, src.ProjectID, src.TaskID, src.PigGenderTypeID, src.PigChampGeneticName
                , src.EstDaysOfAge, src.EstPlacementAge, src.AvgStartWeight, src.FirstPlacementDt, src.EstInventory, src.SiteOwnerShip,src.StdCapacity
                , src.StockingMultiplier, src.OriginSiteContactID, src.AirSpaceOnMove, src.SBFNurSrceContactID, src.SBF_SiteID, src.SBFSrceSowFarm, src.RoomNbr ) ;

    SELECT  @RecordsMerged = @@ROWCOUNT ;
END TRY

BEGIN CATCH
	IF	@@TRANCOUNT > 0 ROLLBACK TRANSACTION ;
	DECLARE	@ErrorMessage AS NVARCHAR(2048) = ERROR_MESSAGE() ;
	RAISERROR( @ErrorMessage, 16, 1 ) ; 
	RETURN 55555 ;
END CATCH
