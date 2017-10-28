/****** Object:  Stored Procedure dbo.GLSetup_Master_Update    Script Date: 4/7/98 12:38:58 PM ******/
CREATE Proc [dbo].[GLSetup_Master_Update] @parm1 smallint As

declare @zcount smallint

SELECT @zcount = zcount from glsetup
IF @zcount < @parm1
    UPDATE glsetup set zcount = @parm1
ELSE
	IF @zcount < 32767
		UPDATE glsetup set zcount = zcount + 1
	ELSE
		UPDATE glsetup set zcount = 21

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLSetup_Master_Update] TO [MSDSL]
    AS [dbo];

