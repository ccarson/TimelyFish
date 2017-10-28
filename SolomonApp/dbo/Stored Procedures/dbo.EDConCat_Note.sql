 CREATE PROCEDURE EDConCat_Note @ComputerID varchar(21), @NoteID int, @TableName varchar(20), @LevelName varchar(20) AS
set NoCount on
Declare @NoteText as varchar(255)
Declare @ptrval varbinary(16)
Declare csr_EdNoteExport Cursor For Select NoteText from EDNoteExport_Wrk where ComputerName = @ComputerID and nid = @NoteID order by LineNbr
Declare @FirstTime as smallint
-- Initialize
Set @FirstTime = 1
Set Transaction Isolation Level Read Uncommitted
if @NoteId = 0
-- If noteid is zero we will create a new note.
 begin
  Insert into Snote (dtRevisedDate,slevelname,stablename,snotetext) values (GetDate(),@LevelName,@TableName,' ')
  -- get the noteid
  Select @noteId =  @@IDENTITY
end
select @ptrval = textptr(snotetext) from Snote where Snote.nId = @NoteID
--select against temptable for ComputerID and noteid
Open csr_EdNoteExport
Fetch csr_EdNoteExport into @NoteText
While (@@Fetch_Status = 0)
  begin
    If @FirstTime = 1
      Begin
        WriteText snote.snotetext @ptrval with log @notetext
        Set @FirstTime = 0
      End
    Else
      Begin
        UpdateText snote.snotetext @ptrval NULL 0 WITH LOG @notetext
    End
    Fetch csr_EdNoteExport into @NoteText
  end
DeAllocate csr_EdNoteExport
Delete From EDNoteExport_Wrk Where ComputerName = @ComputerID And nid = @Noteid
set nocount off
--return noteid
Set Transaction Isolation Level Read Committed
select @noteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConCat_Note] TO [MSDSL]
    AS [dbo];

