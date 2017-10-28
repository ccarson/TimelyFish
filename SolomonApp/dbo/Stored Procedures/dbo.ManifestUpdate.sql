
CREATE Proc ManifestUpdate @CpnyId varchar(10), @ShipperId varchar(10) As

Declare @CalcWeight smallint 
Declare @ManifestUpdated smallint
DECLARE @ContTrackLevel as varchar(10)

Set @ManifestUpdated = 0  

Select @CalcWeight = CalcWeight From ANSetup
If @CalcWeight Is Null -- would be true if ASN is not installed.
Begin
   Set @ManifestUpdated = 1
   Goto ExitProc
End

SELECT @ContTrackLevel = ISNULL(CustomerEDI.ContTrackLevel,'')
	FROM SOShipHeader INNER JOIN CustomerEDI ON SOShipHeader.CustID = CustomerEDI.CustID
	WHERE 	CpnyID = @CpnyId AND ShipperID = @ShipperId

IF @ContTrackLevel = 'NCR' OR LTRIM(RTRIM(@ContTrackLevel)) = ''
BEGIN
    If (Select Count(*) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId) = 0
    Begin
       Set @ManifestUpdated = 1
       GOTO ExitProc
    End
END


If(Select Count(*) From SOShipPack Where CpnyId = @CpnyId And ShipperId = @ShipperId) > 0
  Goto ExitProc  -- if there are already SOShipPack records then we will not do anything.
  


If (Select Count(*) from EDContainer 
        Where CpnyId = @CpnyId And ShipperId = @ShipperId And (TareFlag = 1 Or (TareFlag = 0 And LTrim(RTrim(TareId)) = ''))) > 0 
Begin
     Set @ManifestUpdated = 1
     GOTO ExitProc
End

ExitProc:
-- return flag
Select @ManifestUpdated


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ManifestUpdate] TO [MSDSL]
    AS [dbo];

