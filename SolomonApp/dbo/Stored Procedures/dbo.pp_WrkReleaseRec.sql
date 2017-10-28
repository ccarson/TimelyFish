 CREATE PROCEDURE pp_WrkReleaseRec
	@BatNbr char(10),
	@Module char(2),
	@UserAddress char(21),
	@Direction int AS

SET NOCOUNT ON

IF @Direction = 0
	DELETE WrkRelease
		WHERE Module = @Module AND BatNbr = @BatNbr AND UserAddress = @UserAddress
ELSE
      INSERT WrkRelease
       select @BatNbr,@Module,@UserAddress,  NULL
       WHERE (SELECT COUNT(BatNbr)
                FROM WrkRelease w2
               WHERE w2.Module = @Module AND w2.BatNbr = @BatNbr) = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_WrkReleaseRec] TO [MSDSL]
    AS [dbo];

