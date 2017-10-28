 CREATE PROCEDURE DMG_GL_Installed_Return
AS
	if (
	select	count(*)
	from	GLSetup (NOLOCK)
	) = 0
		return 0
	else
		return 1


