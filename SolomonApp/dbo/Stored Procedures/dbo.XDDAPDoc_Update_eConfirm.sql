
CREATE PROCEDURE XDDAPDoc_Update_eConfirm
   @VendAcct		varchar(10)

AS

	-- Establish eConfirm values where there was a eStatus value
	UPDATE APDoc
	SET eConfirm = @VendAcct
	WHERE 	eConfirm = ''
		and eStatus <> ''
		and Rlsed = 0
		and DocClass = 'N'
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDAPDoc_Update_eConfirm] TO [MSDSL]
    AS [dbo];

