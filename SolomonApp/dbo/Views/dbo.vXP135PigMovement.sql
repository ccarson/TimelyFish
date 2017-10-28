--*************************************************************
--	Purpose:Pig Movements with Source and Destination names
--	Author: Charity Anderson
--	Date: 8/2/2004
--	Usage: PigTransportRecord app PigMovement PV
--	Parms:
--*************************************************************

CREATE VIEW dbo.vXP135PigMovement
AS
Select PMID, convert(varchar(10),MovementDate,101) as MovementDate,SourceContactID, convert(varchar(20),s.ContactName) as SourceFarm, 
	convert(varchar(7),SourceBarnNbr) as SourceBarnNbr,
	EstimatedQty,DestContactID,  convert(varchar(20),d.ContactName) as DestFarm, 
	convert(varchar(7),DestBarnNbr) as DestBarnNbr
FROM cftPM pm
JOIN dbo.cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
JOIN dbo.cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID

