
CREATE PROCEDURE OMCommon_Init  @Parm1 varchar(47) as
SELECT
	 OMInstalled=(SELECT count(*) FROM SOSetup WITH(NOLOCK)),
	 CMInstalled=(SELECT count(*) FROM CMSetup WITH(NOLOCK)),
	 ASNInstalled=(SELECT count(*) FROM ANSetup WITH(NOLOCK)),
	 EDIInstalled=(SELECT count(*) FROM EDSetup WITH(NOLOCK)),
	 INInstalled=(SELECT count(*) FROM INSetup WITH(NOLOCK) WHERE Init = 1),
	 PCInstalled=(SELECT count(*) FROM PCSetup WITH(NOLOCK) WHERE S4Future3 = 'S'),
	 WOInstalled=(SELECT count(*) FROM WOSetup WITH(NOLOCK) WHERE Init = 'Y'),
	 ARCurrPerNbr=(SELECT CurrPerNbr FROM ARSetup WITH(NOLOCK)),
	 ARArAcct=(SELECT ArAcct FROM ARSetup WITH(NOLOCK)),
	 SIUserSiteID=(SELECT SiteID FROM SIUserAppAuth WITH(NOLOCK) WHERE UserID like @Parm1)
             
