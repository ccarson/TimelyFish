



CREATE PROCEDURE 
	[Utility].[cfp_CentralDataChange_Add_SBFSiteLookup]
AS
/*
************************************************************************************************************************************

  Procedure:    Utility.cfp_CentralDataChange_Add_SBFSiteLookup
     Author:    Chris Carson 
    Purpose:    Insert data onto dbo.cftSBFSiteLookup
	
                Inserts new record into CentralData.dbo.cftSBFSiteLookup					
				

    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-09-19			Executed in production
    ccarson         2016-10-26          Added two new sites
    ccarson         2016-10-31          Added two new sites
    ccarson         2016-11-01          Added new site




    Notes:
	
	Help Desk Reference # G9JG642292

************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

INSERT INTO CentralData.dbo.cftSBFSiteLookup
(ContactID,SiteID,SBFSiteID,EffectiveDate,Crtd_dateTime,Crtd_User)
--VALUES (11707,6262,846,'5/1/2016',getdate(),'CCarson')    --Added 2016-09-19
--VALUES (11710,6263,848,'5/1/2016',getdate(),'CCarson')    --Added 2016-09-19
--     , (11817,6267,911,'5/1/2016',getdate(),'CCarson')    --Added 2016-09-19
--VALUES (11764,6265,881,'5/1/2016',getdate(),'CCarson')    --Added 2016-10-31
--     , (11747,6264,851,'5/1/2016',getdate(),'CCarson')    --Added 2016-10-31
VALUES (11836,6271,912,'5/1/2016',getdate(),'CCarson')    --Added 2016-11-01


--ROLLBACK TRANSACTION ;
--COMMIT TRANSACTION ; 

RETURN 0 ;


