 Create Proc EDConfirmShipper @CpnyId varchar(10), @ShipperId varchar(10), @CustId varchar(15) As

Declare @CalcWeight smallint
Declare @Result smallint
Declare @VolUom varchar(6)
Declare @WeightUom varchar(6)
Declare @NbrWeightUoms smallint
Declare @NbrVolUoms smallint
Declare @SumWeight float
Declare @SumVol float
Declare @ContTrackLevel varchar(10)
Declare @ContainerDetCount int
Declare @ManifestUpdated smallint
Declare @ShipViaCount int

Set @ManifestUpdated = 0
Set @Result = 0
Set @SumWeight = 0
Set @SumVol = 0

Select @CalcWeight = CalcWeight From ANSetup
If @CalcWeight Is Null -- would be true if ASN is not installed.
  Goto ExitProc

If @CalcWeight = 1
  Begin
  Begin Transaction
  Select @NbrWeightUoms = Count(Distinct WeightUom) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 0
  Select @NbrVolUoms = Count(Distinct VolumeUom) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 0
  If @NbrWeightUoms = 1 Or @NbrVolUoms = 1
    Begin
    Select @SumWeight = Sum(Weight), @SumVol = Sum(Volume) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 0
    Select @WeightUom = WeightUom, @VolUom = VolumeUom From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And TareFlag = 0
  End
  If @NbrWeightUoms <> 1
    Begin
    Select @WeightUom = ' '
  End
  If @NbrVolUoms <> 1
    Begin
    Select @VolUom = ' '
  End
  Update EDSOShipHeader Set Weight = @SumWeight, Volume = @SumVol, WeightUom = @WeightUom, VolumeUom = @VolUom Where CpnyId = @CpnyId And ShipperId = @ShipperId
  Commit Transaction
End

Select @ShipViaCount = Count(Distinct A.ShipViaId) From SOShipHeader A Inner Join EDShipTicket B
 On A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId Where B.BOLNbr = (Select BOLNbr From
 EDShipTicket Where CpnyId = @CpnyId And ShipperId = @ShipperId)
If @ShipViaCount > 1
  Set @Result = 2

If @Result = 0 Begin
  Select @ContTrackLevel = ContTrackLevel From CustomerEDI Where CustId = @CustId
  If @ContTrackLevel = 'NCR' Or LTrim(RTrim(@ContTrackLevel)) = ''
    EXEC EDContainer_UpdateManifest @CpnyId, @ShipperId, @ManifestUpdated output
  Else Begin
    If @ContTrackLevel = 'TCO' Begin -- track container headers only.
      If @NbrWeightUoms > 0 Or @NbrVolUoms > 0
        EXEC EDContainer_UpdateManifest @CpnyId, @ShipperId, @ManifestUpdated output
      Else
        Set @Result = 1
    End Else Begin
      Select @ContainerDetCount = Count(*) From EDContainerDet Where CpnyId = @CpnyId And ShipperId = @ShipperId
      If @ContainerDetCount > 0
        EXEC EDContainer_UpdateManifest @CpnyId, @ShipperId, @ManifestUpdated output
      Else
        Select @Result = 1
    End
  End
End

ExitProc:
Select @Result, @ManifestUpdated



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConfirmShipper] TO [MSDSL]
    AS [dbo];

