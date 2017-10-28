 CREATE Proc EDSOHeader_Create @CpnyId varchar(10), @OrdNbr varchar(15), @CustId varchar(15), @Prog varchar(8), @User varchar(10) As
Declare @EDSOHeaderCount int
Declare @SingleContainer smallint
Declare @SetupCount smallint
Select @SetupCount = Count(*) From EDSetup Full Outer Join ANSetup On EDSetup.SetupId = ANSetup.SetupId
If @SetupCount > 0 Begin
  Select @EDSOHeaderCount = Count(*) From EDSOHeader Where CpnyId = @CpnyId And OrdNbr = @OrdNbr
  If @EDSOHeaderCount = 0 Begin
    Select @SingleContainer = SingleContainer From CustomerEDI Where CustId = @CustId
    If @@RowCount = 0 -- this line must directly follow the select statement above it!
      Set @SingleContainer = 0
    Insert Into EDSOHeader Values(' ',' ','1/1/1900',' ',' ',0,'1/1/1900',@CpnyId,' ',GetDate(),@Prog,@User,'1/1/1900','1/1/1900',' ',' ',0,0,' ',GetDate(),@Prog,@User,0,@OrdNbr,' ',' ',0,0,' ',' ','1/1/1900',' ',' ',0,0,0,0,'1/1/1900','1/1/1900',0,0,' ',' ',' ','1/1/1900',' ','1/1/1900','1/1/1900','1/1/1900',@SingleContainer,' ',' ',' ',' ','1/1/1900',' ',' ',' ',0,0,' ',' ','1/1/1900',0,0,0,DEFAULT)
  End
End



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOHeader_Create] TO [MSDSL]
    AS [dbo];

