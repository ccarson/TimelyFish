 CREATE Proc EDSNote_Update @Text As text, @RevisedDate smalldatetime, @nID as float  As
update Snote set snotetext =  @Text ,  dtRevisedDate = @RevisedDate where nID = @nID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSNote_Update] TO [MSDSL]
    AS [dbo];

