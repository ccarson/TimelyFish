--*************************************************************
--	Purpose:List of entered Pig Transports
--	Author: Charity Anderson
--	Date: 8/5/2004
--	Usage: PigTransportRecord app PigTransport Details
--	Parms:
--*************************************************************

CREATE  VIEW dbo.vXP135PigTransportDocs
AS
Select
	BatchNbr, RefNbr, pm.Crtd_User,PMID, MovementDate,SourceContactID, convert(varchar(20),s.ContactName) as SourceFarm, 
	convert(varchar(7),SourceBarnNbr) as SourceBarnNbr,
	DestContactID,  convert(varchar(20),d.ContactName) as DestFarm, 
	convert(varchar(7),DestBarnNbr) as DestBarnNbr
From cftPMTranspRecord pm
LEFT JOIN dbo.cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN dbo.cftContact d on pm.DestContactID=d.ContactID


 