 /****** Object:  Stored Procedure dbo.RQAlter_BC    Script Date: 1/2/01 9:39:32 AM ******/
CREATE PROCEDURE  RQAlter_BC @parm1 as varchar(10), @parm2 as varchar(1), @parm3 as varchar(8000) as
DECLARE @ptrval binary(16)
SELECT @ptrval = TEXTPTR(zzText)
FROM RQAlter where AlterNbr = @parm1 and AlterType = @parm2
 WRITETEXT RQAlter.zzText @ptrval  @parm3


