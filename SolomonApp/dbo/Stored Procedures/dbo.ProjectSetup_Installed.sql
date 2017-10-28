
CREATE PROCEDURE ProjectSetup_Installed as

SELECT SetupID,S4Future3
  FROM PCSetup WITH(NOLOCK)
 WHERE S4Future3 = 'S'

