 /**** Created by Ashraf Mohammad on 12/9/98 at 1:40pm ****/

CREATE PROCEDURE pp_WrkRelease_PORec
	@BatNbr char(10),
	@Module char(2),
	@UserAddress char(21) AS

INSERT WrkRelease_PO VALUES (@BatNbr, @Module, @UserAddress, Space(1), 0, Space(1), Null)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_WrkRelease_PORec] TO [MSDSL]
    AS [dbo];

