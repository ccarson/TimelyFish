 CREATE PROC [dbo].[SD40100_pre]
	@ri_id		smallint
as
       -- update both system and app reportruntime
        Update rptruntime set NotesOn = 1 WHERE RI_ID = @RI_ID

	    Update vs_rptruntime set NotesOn = 1 where RI_ID = @RI_ID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[SD40100_pre] TO [MSDSL]
    AS [dbo];

