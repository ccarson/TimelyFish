 CREATE Proc EDGetLotSerNbr @InvtId varchar(30) As
Begin Tran
Declare @LotSerNbr char(25)
Select @LotSerNbr = Case LotSerFxdTyp
  When 'C' Then
    LTrim(RTrim(LotSerFxdVal)) + LotSerNumVal
  When 'E' Then
    LTrim(RTrim(LotSerFxdVal)) + LotSerNumVal
  Else
    Substring(Convert(char(30),GetDate(),112 ),5,4) + Substring(Convert(char(30),GetDate(),112 ),1,4) + LotSerNumVal
  End
From Inventory (HoldLock)
Where InvtId = @InvtId
Update Inventory Set LotSerNumVal = Right(Replicate('0',LotSerNumLen) + LTrim(RTrim(Cast(Cast(LotSerNumVal As Int) + 1 As Char(25)))), LotSerNumLen)
Where InvtId = @InvtId
Commit Tran
Select @LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDGetLotSerNbr] TO [MSDSL]
    AS [dbo];

