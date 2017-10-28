

--*************************************************************
--	Purpose:View for Load Nbr PV for Pig Sales Entry
--	Author: Charity Anderson
--	Date: 10/14/2004
--	Usage: Pig Sales Entry		 
--	Parms: 
--*************************************************************
--5/25/07 Dkillion Mantis ticket 310
--Added additional filter to prevent 'red' highlighted rows from appearing in this view
--*************************************************************
CREATE VIEW [dbo].[vCF518LoadNbrPV]
	
AS
--Select cftPM.*,cast(cftContact.ContactName as char(20)) as SourceFarm,cast(p.ContactName as char(20)) as Packer, cast(t.ContactName as char(20)) as Trucker,
--	convert(varchar(10),cftPM.MovementDate,101) as SaleDate
-- from cftPM JOIN cftContact on cftPM.SourceContactID=cftContact.ContactID 
--JOIN cftContact as P on cftPM.DestContactID=p.ContactID 
--JOIN cftContact as t on cftPM.TruckerContactID=t.ContactID
--where right(rtrim(TranSubTypeID),1) in ('O','M')
--and cftpm.highlight not in ('255')
SELECT     dbo.cftPM.ActualQty, dbo.cftPM.ActualWgt, dbo.cftPM.ArrivalDate, dbo.cftPM.ArrivalTime, dbo.cftPM.BoardBackColor, dbo.cftPM.Comment, 
                      dbo.cftPM.CpnyID, dbo.cftPM.Crtd_DateTime, dbo.cftPM.Crtd_Prog, dbo.cftPM.Crtd_User, dbo.cftPM.DeleteFlag, dbo.cftPM.DestBarnNbr, 
                      dbo.cftPM.DestContactID, dbo.cftPM.DestPigGroupID, dbo.cftPM.DestProject, dbo.cftPM.DestRoomNbr, dbo.cftPM.DestTask, dbo.cftPM.DestTestStatus, 
                      dbo.cftPM.DisinfectFlg, dbo.cftPM.EstimatedQty, dbo.cftPM.EstimatedWgt, dbo.cftPM.GiltAge, dbo.cftPM.Highlight, dbo.cftPM.ID, dbo.cftPM.LineNbr, 
                      dbo.cftPM.LoadingTime, dbo.cftPM.Lupd_DateTime, dbo.cftPM.Lupd_Prog, dbo.cftPM.Lupd_User, dbo.cftPM.MarketSaleTypeID, 
                      dbo.cftPM.MovementDate, dbo.cftPM.NonUSOrigin, dbo.cftPM.OrdNbr, dbo.cftPM.OrigMovementDate, dbo.cftPM.PFEUEligible, dbo.cftPM.PigFlowID, 
                      dbo.cftPM.PigGenderTypeID, dbo.cftPM.PigTrailerID, dbo.cftPM.PigTypeID, dbo.cftPM.PkrContactID, dbo.cftPM.PMID, dbo.cftPM.PMLoadID, 
                      dbo.cftPM.PMSystemID, dbo.cftPM.PMTypeID, dbo.cftPM.PONbr, dbo.cftPM.SourceBarnNbr, dbo.cftPM.SourceContactID, dbo.cftPM.SourcePigGroupID, 
                      dbo.cftPM.SourceProject, dbo.cftPM.SourceRoomNbr, dbo.cftPM.SourceTask, dbo.cftPM.SourceTestStatus, dbo.cftPM.SuppressFlg, dbo.cftPM.Tailbite, 
                      dbo.cftPM.TattooFlag, dbo.cftPM.TrailerWashFlag, 
                      dbo.cftPM.TrailerWashStatus, dbo.cftPM.TranSubTypeID, dbo.cftPM.TruckerContactID, dbo.cftPM.WalkThrough, dbo.cftPM.tstamp, 
                      CAST(dbo.cftContact.ContactName AS char(20)) AS SourceFarm, CAST(P.ContactName AS char(20)) AS Packer, CAST(t.ContactName AS char(20)) 
                      AS Trucker, CONVERT(varchar(10), dbo.cftPM.MovementDate, 101) AS SaleDate
FROM         dbo.cftPM INNER JOIN
                      dbo.cftContact ON dbo.cftPM.SourceContactID = dbo.cftContact.ContactID INNER JOIN
                      dbo.cftContact AS P ON dbo.cftPM.DestContactID = P.ContactID INNER JOIN
                      dbo.cftContact AS t ON dbo.cftPM.TruckerContactID = t.ContactID
WHERE     (RIGHT(RTRIM(dbo.cftPM.TranSubTypeID), 1) IN ('O', 'M')) AND (dbo.cftPM.Highlight NOT IN ('255'))




