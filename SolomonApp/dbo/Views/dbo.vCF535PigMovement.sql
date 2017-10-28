--*************************************************************
--	Purpose:PigMovement view		
--	Author: Charity Anderson
--	Date: 1/25/2005
--	Usage: PGExceptions 
--	Parms: 
--*************************************************************

CREATE VIEW dbo.vCF535PigMovement

AS
Select PMID, MovementDate,SourceContactID,
	 convert(varchar(20),s.ContactName) as SourceFarm, 
	convert(varchar(7),SourceBarnNbr) as SourceBarnNbr,
	EstimatedQty,
	DestContactID,convert(varchar(20),d.ContactName) as DestFarm, 
	convert(varchar(7),DestBarnNbr) as DestBarnNbr,
	DestPigGroupID, SourcePigGroupID
FROM cftPM pm
JOIN SolomonApp.dbo.cftContact s on pm.SourceContactID=s.ContactID
JOIN SolomonApp.dbo.cftContact d on pm.DestContactID=d.ContactID



