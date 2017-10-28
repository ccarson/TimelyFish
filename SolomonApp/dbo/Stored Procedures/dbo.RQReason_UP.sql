 /****** Object:  Stored Procedure dbo.RQReason_UP    Script Date: 9/4/2003 6:21:39 PM ******/

/****** Object:  Stored Procedure dbo.RQReason_UP    Script Date: 7/5/2002 2:44:43 PM ******/

/****** Object:  Stored Procedure dbo.RQReason_UP    Script Date: 1/7/2002 12:23:14 PM ******/

/****** Object:  Stored Procedure dbo.RQReason_UP    Script Date: 1/2/01 9:39:39 AM ******/
CREATE PROCEDURE  RQReason_UP @parm1 as varchar(10), @parm2 as integer, @parm3 as varchar(1), @parm4 as integer, @parm5 as varchar(8000) as
DECLARE @ptrval binary(16)
SELECT @ptrval = TEXTPTR(zzReason)
FROM RQReason where ItemNbr = @parm1 and ItemLineNbr = @parm2 and ItemType = @parm3
UPDATETEXT RQReason.zzReason @ptrval @parm4 NULL  @parm5


GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQReason_UP] TO [MSDSL]
    AS [dbo];

