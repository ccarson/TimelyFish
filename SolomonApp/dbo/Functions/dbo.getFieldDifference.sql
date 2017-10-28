
-- =============================================
-- Author:	Matt Dawson
-- Create date:	1/9/2008
-- Description:	If a difference in fields, send the change back, or send blank string
-- Parameters: 	@Parm1, @Parm2
-- Note: sends @Parm2 back if a change, this is being used for the Transportation Schedule Change Report
-- =============================================
Create Function [dbo].[getFieldDifference]
	(@Parm1 varchar(500), @Parm2 varchar(500))
RETURNS varchar(500)

AS
BEGIN
DECLARE @Diff varchar(500)

IF RTRIM(COALESCE(@Parm1,'')) <> RTRIM(COALESCE(@Parm2,''))
	SET @Diff = RTRIM(COALESCE(@Parm2,''))
ELSE
	SET @Diff = ''

RETURN @Diff
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getFieldDifference] TO [MSDSL]
    AS [dbo];

