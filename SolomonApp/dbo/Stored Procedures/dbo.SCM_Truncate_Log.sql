 Create	Procedure SCM_Truncate_Log
As
	Set	NoCount On
	Declare	@DBName	VarChar(256)

	Select	@DBName = DB_Name()

	Exec ('Use ' + @DBName)

	Begin Transaction
		Update	Batch
			Set	Status = Status
	Rollback Transaction

	Checkpoint

	Exec ('Dump Transaction ' + @DBName + ' With Truncate_Only')
	Exec ('Dump Transaction ' + @DBName + ' With No_Log')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Truncate_Log] TO [MSDSL]
    AS [dbo];

