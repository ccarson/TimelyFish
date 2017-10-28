 Create Procedure SCM_Delete_WrkRelease
	@BatNbr			Varchar(10),
	@UserAddress		Varchar(21)
As
	Set NoCount On

	Delete	From WrkRelease
		Where	BatNbr = @BatNbr
			Or UserAddress = @UserAddress


