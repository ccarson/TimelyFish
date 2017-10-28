 CREATE Procedure EDSNote_InsertOnly @Level varchar(20), @Table varchar(20), @RevisedDate smalldatetime, @Text As text As
Insert Into Snote (dtRevisedDate, sLevelName, sTableName, sNoteText) Values (@RevisedDate, @Level, @Table, @Text)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSNote_InsertOnly] TO [MSDSL]
    AS [dbo];

