
/**************************************************************
	Purpose:PigMovement view		
	Author: Charity Anderson
	Date: 1/25/2005
	Usage: PGExceptions 
	Parms: 
**************************************************************/
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-05-02  Doran Dahle Added tstamp for SL 2011 date control bug.
						

===============================================================================
*/
CREATE VIEW [dbo].[vXP210PigMovement]
AS
SELECT     pm.PMID, pm.MovementDate, pm.SourceContactID, CONVERT(varchar(20), s.ContactName) AS SourceFarm, CONVERT(varchar(7), pm.SourceBarnNbr) 
                      AS SourceBarnNbr, pm.EstimatedQty, pm.DestContactID, CONVERT(varchar(20), d.ContactName) AS DestFarm, CONVERT(varchar(7), pm.DestBarnNbr) 
                      AS DestBarnNbr, pm.DestPigGroupID, pm.SourcePigGroupID, pm.tstamp
FROM         dbo.cftPM AS pm INNER JOIN
                      dbo.cftContact AS s ON pm.SourceContactID = s.ContactID INNER JOIN
                      dbo.cftContact AS d ON pm.DestContactID = d.ContactID

