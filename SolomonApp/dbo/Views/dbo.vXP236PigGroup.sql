--*************************************************************
--	Purpose:Pig Group list based on user parameters
--		
--	Author: Charity Anderson
--	Date: 8/25/2005
--	Usage: Pig Group Verification Screen Pig Group DBNav 
--	Parms:UnVerifiedFlag, VerifiedFlag,PigGroup
--*************************************************************

CREATE VIEW dbo.vXP236PigGroup
as 
Select  pg.PigGroupID, c.ContactName, pg.BarnNbr, 
				RoomNbr=isnull(pgr.RoomNbr,'')
				from cftPigGroup pg
				JOIN cftContact c on pg.SiteContactID=c.ContactID
				LEFT JOIN vCFPigGroupRoomFilter pgrf on pg.PigGroupID=pgrf.PigGroupID and pgrf.GroupCount=1
				LEFT JOIN cftPigGroupRoom pgr on pgrf.PigGroupID=pgr.PigGroupID


 