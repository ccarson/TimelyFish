 CREATE PROCEDURE DMG_ItemXRef_InvtID_Delete
	@InvtID varchar(30)
AS

	DELETE FROM ItemXRef WHERE InvtID = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ItemXRef_InvtID_Delete] TO [MSDSL]
    AS [dbo];

