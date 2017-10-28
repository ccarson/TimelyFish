 Create	Procedure SCM_10990_Delete_Retired_LotSerT
As
	Set	NoCount On
	Declare	@ErrorNo	Integer
	Set	@ErrorNo = 0
	Begin	Transaction

	Delete	From	LotSerT
		Where	S4Future05 = 1

	Set	@ErrorNo = @@Error
	If	(@ErrorNo = 0)
		Commit Transaction
	Else
		Rollback Transaction


