 CREATE PROC ED850LineItem_LineID_4440700 @CpnyId varchar(10), @EDIPOID varchar(10), @LineID integer
As
	SELECT * FROM ED850LineItem
	WHERE CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineID = @LineID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LineItem_LineID_4440700] TO [MSDSL]
    AS [dbo];

