 CREATE Proc EDNoteExport_Wrk_FillTable @ComputerNameIn char(21), @nIdIn int  AS
-- next key value
Declare @NextLineNbr int
-- Max size of a single piece (substring)
Declare @PieceLength int
-- current position in string
Declare @i as int
-- Length of string parsing
Declare @MaxLength int
declare @ThisLength int
Declare @NextCRLF int
Declare @Ascii10Pos int
Declare @Ascii13Pos int
Declare @CRLFIncrement int

set nocount on
-- Init Counter for NextNbr
Set @NextLineNbr = 0
Set @i = 1
-- Set up Length of each piece
select @PieceLength = (select col_length('EDNoteExport_Wrk','NoteText'))
Select @MaxLength = (select datalength(snotetext) from snote where nid = @nIDIn)
-- Clean up previous attempts
Delete from EDNoteExport_Wrk where  ComputerName = @ComputerNameIn and nid = @nIDIn
-- Main Loop
-- While current character working on is less than the max length,
while @i < @MaxLength
Begin
-- This logic is to break nicely when hitting a CRLF combo
-- Default to full max length,
  select @Thislength = (Select @PieceLength)
-- Locate next CRLF after the current position
  Select @Ascii10Pos = charindex(char(10),substring(Snotetext,@i,@MaxLength)) from snote where nid = @nIdIn
  Select @Ascii13Pos = charindex(char(13),substring(Snotetext,@i,@MaxLength)) from snote where nid = @nIdIn
  Select @NextCRLF = Case
    When @Ascii10Pos > 0 And @Ascii13Pos > 0 And @Ascii10Pos < @Ascii13Pos Then @Ascii10Pos
    When @Ascii10Pos > 0 And @Ascii13Pos > 0 And @Ascii10Pos > @Ascii13Pos Then @Ascii13Pos
    When @Ascii10Pos = 0 Then @Ascii13Pos
    When @Ascii13Pos = 0 Then @Ascii10Pos
    Else 0 End
  Select @CRLFIncrement = Case When @Ascii10Pos > 0 And @Ascii13Pos > 0 Then 2 When @Ascii10Pos > 0 Then 1 When @Ascii13Pos > 0 Then 1 Else 0 End
-- If a CRLF is found (Next > 0) and within range modify length to read to return the CRLF as the last character
   if  @NextCrLF > 0 And @NextCRLF < @ThisLength
     select @ThisLength = (Select @NextCRLF + @CRLFIncrement - 1)
--Add a new line
  Insert  EDNoteExport_Wrk select @ComputerNameIn,@NextLineNbr,@nIdIn,SUBSTRING(snotetext,@i,@ThisLength - @CRLFIncrement),null from snote where nid = @nIDIn
-- Increment key
  Select @NextLineNbr = (select @NextLineNbr + 1)
-- Increment Character looking at
  Select @i = (select (@i + @ThisLength))
End
set nocount off
-- Proc will return count of number of rows, to indicate wether need to retrieve results
select count(*) from EDNoteExport_Wrk where  ComputerName = @ComputerNameIn and nid = @nIDIn


