 CREATE PROCEDURE EDCalcMod10ChkDigit @ContainerId varchar(10) , @UCC128 varchar(20) output AS
Declare @StrLength smallint, @i int, @OddSum int, @EvenSum int, @WorkChar varchar(1),  @ResultSum int
Declare @ManuId varchar(19)
Declare @Len smallint

Select @ManuId = MfgId From ANSetup
If @ManuId Is Null Or Len(RTrim(LTrim(@ManuId))) < 6
  Begin
    Set @Ucc128 = ' '
    Goto ExitProc
  End

Set @ManuId = '0000' + RTrim(@ManuId) + Right(@ContainerId,9)
Select @StrLength = Len(RTrim(LTrim(@ManuId)))
If @StrLength <> 19
  Begin
    Set @UCC128 = ' '
    Goto ExitProc
  End

Select @i = 1
Select @OddSum = 0
Select @EvenSum = 0
While @i <= @StrLength Begin
  Select @WorkChar = SubString(@ManuId,@i,1)
  If @i % 2 = 1
    Set @OddSum = @OddSum + convert(int,@WorkChar)
  Else
    Select @EvenSum = @EvenSum +  convert(int,@WorkChar)
  Select @i = @i + 1
End
Select @OddSum = @OddSum * 3
Select @ResultSum = @OddSum + @EvenSum
Select @WorkChar = Right(str(@ResultSum),1)
If @WorkChar <> '0'
  Select @WorkChar = ltrim(rtrim(str(10 - convert(smallint,@WorkChar))))
Set @UCC128 = @ManuId + @WorkChar
ExitProc:


