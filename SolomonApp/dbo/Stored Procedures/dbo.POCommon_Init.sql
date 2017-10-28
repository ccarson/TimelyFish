
CREATE PROCEDURE POCommon_Init as
SELECT
         APInstalled=(SELECT count(*) FROM APSetup WITH(NOLOCK)),
         POInstalled=(SELECT count(*) FROM POSetup WITH(NOLOCK)),
         CMInstalled=(SELECT count(*) FROM CMSetup WITH(NOLOCK)),
         GLInstalled=(SELECT count(*) FROM GLSetup WITH(NOLOCK)),	 
         INInstalled=(SELECT count(*) FROM INSetup WITH(NOLOCK) WHERE Init = 1),
         OMInstalled=(SELECT count(*) FROM SOSetup WITH(NOLOCK)),
	 PCInstalled=(SELECT count(*) FROM PCSetup WITH(NOLOCK) WHERE S4Future3 = 'S')
