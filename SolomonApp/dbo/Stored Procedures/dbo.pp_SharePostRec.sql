 CREATE PROCEDURE pp_SharePostRec
	@BatNbr char(10),
	@Module char(2),
	@UserAddress char(21),
	@Direction int AS

IF @Direction = 0
	DELETE WrkPost
		WHERE Module = @Module AND BatNbr = @BatNbr AND UserAddress = @UserAddress
ELSE
	INSERT WrkPost
	 select @BatNbr, @Module, @UserAddress, NULL
       WHERE (SELECT COUNT(batNbr)
                FROM WrkPost w
               WHERE w.Module = @Module AND w.BatNbr = @BatNbr) = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_SharePostRec] TO [MSDSL]
    AS [dbo];

