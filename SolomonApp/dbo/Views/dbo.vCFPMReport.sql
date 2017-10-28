
--*************************************************************
--	Purpose:Data source for FlowBoard report
--		
--	Author: Charity Anderson
--	Date: 5/16/2005
--	Usage: Flow Board Report 
--	Parms: 
--*************************************************************

CREATE VIEW dbo.vCFPMReport

AS

SELECT     pm.ActualQty, pm.ActualWgt, pm.ArrivalDate, pm.ArrivalTime, pm.BoardBackColor, pm.Comment, pm.CpnyID, pm.Crtd_DateTime, pm.Crtd_Prog, 
              pm.Crtd_User, pm.DeleteFlag, pm.DestBarnNbr, pm.DestContactID, pm.DestPigGroupID, pm.DestProject, pm.DestRoomNbr, pm.DestTask, 
              pm.DestTestStatus, pm.DisinfectFlg, pm.EstimatedQty, pm.EstimatedWgt, pm.GiltAge, pm.Highlight, pm.ID, pm.LineNbr, pm.LoadingTime, 
              pm.Lupd_DateTime, pm.Lupd_Prog, pm.Lupd_User, pm.MarketSaleTypeID, pm.MovementDate, pm.NonUSOrigin, pm.OrdNbr, pm.OrigMovementDate, 
              pm.PFEUEligible, pm.PigFlowID, pm.PigGenderTypeID, pm.PigTrailerID, pm.PigTypeID, pm.PkrContactID, pm.PMID, pm.PMLoadID, pm.PMSystemID, 
              pm.PMTypeID, pm.PONbr, pm.SourceBarnNbr, pm.SourceContactID, pm.SourcePigGroupID, pm.SourceProject, pm.SourceRoomNbr, pm.SourceTask, 
              pm.SourceTestStatus, pm.SuppressFlg, pm.Tailbite, pm.TattooFlag, 
              pm.TrailerWashFlag, pm.TrailerWashStatus, 
              pm.TranSubTypeID, pm.TruckerContactID, pm.WalkThrough, pm.tstamp, 
              RTRIM(s.ShortName) AS SourceFarm, RTRIM(d.ShortName) AS Destination, CASE WHEN rtrim(SourceRoomNbr) > '' THEN rtrim(SourceRoomNbr) 
              ELSE rtrim(SourceBarnNbr) END AS SourceBarn, CASE WHEN rtrim(DestRoomNbr) > '' THEN rtrim(DestRoomNbr) ELSE rtrim(DestBarnNBr) 
              END AS DestBarn, CONVERT(varchar, pm.MovementDate, 101) + ' ' + DATENAME(dw, pm.MovementDate) AS DateString
FROM         dbo.cftPM AS pm 
			 LEFT OUTER JOIN dbo.cftContact AS s ON pm.SourceContactID = s.ContactID 
			 LEFT OUTER JOIN dbo.cftContact AS d ON pm.DestContactID = d.ContactID
WHERE     (pm.PMTypeID = '01') AND (pm.Highlight <> 255)

