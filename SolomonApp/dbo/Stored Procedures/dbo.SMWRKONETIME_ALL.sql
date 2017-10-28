 create procedure SMWRKONETIME_ALL
	@RI_ID smallint,
	@Doc_Type varchar(2)
  as
	select * from SMWrkOneTimeRec where RI_ID = @RI_ID and DocType = @Doc_Type



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SMWRKONETIME_ALL] TO [MSDSL]
    AS [dbo];

