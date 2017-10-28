
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
    ccarson         2016-11-16          Added new sites
    ccarson         2016-12-06          Added new sites
	rgrisim			2017-07-14			Added new site
	rgrisim			2017-07-19			Added new site
	rgrisim			2017-07-21			Added new site


    Notes:
	
	Help Desk Reference # G9JG642292

************************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

BEGIN TRAN
INSERT INTO CentralData.dbo.cftSBFSiteLookup
(ContactID,SiteID,SBFSiteID,EffectiveDate,Crtd_dateTime,Crtd_User)
--VALUES (11707,6262,846,'5/1/2016',getdate(),'CCarson')    --Added 2016-09-19
--VALUES (11710,6263,848,'5/1/2016',getdate(),'CCarson')    --Added 2016-09-19
--     , (11817,6267,911,'5/1/2016',getdate(),'CCarson')    --Added 2016-09-19
--VALUES (11764,6265,881,'5/1/2016',getdate(),'CCarson')    --Added 2016-10-31
--     , (11747,6264,851,'5/1/2016',getdate(),'CCarson')    --Added 2016-10-31
--VALUES (11836,6271,912,'5/1/2016',getdate(),'CCarson')    --Added 2016-11-01
--VALUES (11696,6261,833,'5/1/2016',getdate(),'CCarson')    --Added 2016-11-16
--     , (11747,6272,913,'5/1/2016',getdate(),'CCarson')    --Added 2016-11-16
--     , (11834,6268,887,'5/1/2016',getdate(),'CCarson')    --Added 2016-11-16
--     , (11844,6274,921,'5/1/2016',getdate(),'CCarson')    --Added 2016-11-16

/* VALUES (11854,6275,922,'5/1/2016',getdate(),'CCarson')    --Added 2016-12-06
     , (11875,6276,902,'5/1/2016',getdate(),'CCarson')    --Added 2016-12-06
     , (11936,6277,917,'5/1/2016',getdate(),'CCarson')    --Added 2016-12-06
     , (11949,6278,927,'5/1/2016',getdate(),'CCarson')    --Added 2016-12-06
     , (11950,6279,926,'5/1/2016',getdate(),'CCarson')    --Added 2016-12-06
     , (11835,6269,909,'5/1/2016',getdate(),'CCarson')    --Added 2016-12-06
	 */
VALUES (12195,6284,919,'5/1/2016',getdate(),'RGrisim') 

--ROLLBACK TRANSACTION ;
COMMIT TRANSACTION ; 

RETURN 0 ;





