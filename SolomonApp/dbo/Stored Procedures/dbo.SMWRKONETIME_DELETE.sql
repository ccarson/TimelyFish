 create procedure SMWRKONETIME_DELETE
	@RI_ID smallint,
	@Doc_Type varchar(2)

  as
	delete from SMWrkOneTimeRec where RI_ID = @RI_ID and DocType = @Doc_Type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SMWRKONETIME_DELETE] TO [MSDSL]
    AS [dbo];

