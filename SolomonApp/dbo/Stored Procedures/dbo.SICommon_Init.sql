
CREATE PROCEDURE SICommon_Init as
SELECT
	 INInstalled=(SELECT count(*) FROM INSetup WITH(NOLOCK) WHERE Init = 1),
	 WOInstalled=(SELECT count(*) FROM WOSetup WITH(NOLOCK) WHERE Init = 'Y'),
	 APInstalled=(SELECT count(*) FROM APSetup WITH(NOLOCK)),
	 GLInstalled=(SELECT count(*) FROM GLSetup WITH(NOLOCK)),
	 POInstalled=(SELECT count(*) FROM POSetup WITH(NOLOCK)),
         PWOInstalled=(SELECT count(*) FROM WOSetup WITH(NOLOCK) WHERE Init = 'Y' AND substring(regoptions, 4, 1) = 'Y' )      
