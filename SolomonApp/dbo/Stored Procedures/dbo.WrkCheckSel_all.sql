 CREATE PROCEDURE WrkCheckSel_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 15 ),
	@parm3 varchar( 2 ),
	@parm4 varchar( 10 )
AS
	set nocount on
	SELECT *
	FROM WrkCheckSel
	WHERE AccessNbr BETWEEN @parm1min AND @parm1max
	   AND VendId LIKE @parm2
	   AND DocType LIKE @parm3
	   AND RefNbr LIKE @parm4
	ORDER BY AccessNbr,
	   VendId,
	   DocType,
	   RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkCheckSel_all] TO [MSDSL]
    AS [dbo];

