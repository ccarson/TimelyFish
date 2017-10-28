CREATE      Proc dbo.pCF510cftPigInvXfer_Line
	       @parm1 varchar(10), @parm2 varchar(2)
as
	Select * From cftPGInvXfer
	WHERE BatNbr = @parm1
	AND LineNbr Like @parm2
	Order by BatNbr, LineNbr





GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF510cftPigInvXfer_Line] TO [MSDSL]
    AS [dbo];

