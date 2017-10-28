 Create Proc ED850LSSS_LineItem @CpnyId varchar(10), @EDIPOID varchar(10), @LineId int As
Select * From ED850LSSS Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = @LineId
Order By CpnyId, EDIPOID, LineId, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850LSSS_LineItem] TO [MSDSL]
    AS [dbo];

