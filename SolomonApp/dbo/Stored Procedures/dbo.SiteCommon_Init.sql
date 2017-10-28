
CREATE PROCEDURE SiteCommon_Init as
SELECT
         GLInstalled=(SELECT count(*) FROM GLSetup WITH(NOLOCK)),	 
         BMInstalled=(SELECT count(*) FROM BMSetup WITH(NOLOCK)), 
         WOInstalled=(SELECT count(*) FROM WOSetup WITH(NOLOCK) WHERE Init = 'Y'),	 
	 PWOInstalled=(SELECT count(*) FROM WOSetup WITH(NOLOCK) WHERE Init = 'Y' AND substring(regoptions, 4, 1) = 'Y' )      
