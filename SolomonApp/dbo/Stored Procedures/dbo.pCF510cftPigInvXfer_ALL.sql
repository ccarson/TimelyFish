CREATE Proc pCF510cftPigInvXfer_ALL
	       @parm1 varchar(10)
as
	Select * From cftPGInvXfer
	WHERE BatNbr LIKE @parm1
	Order by BatNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF510cftPigInvXfer_ALL] TO [MSDSL]
    AS [dbo];

