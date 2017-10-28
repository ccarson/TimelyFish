 CREATE Proc EDContainer_UpdateManifest @CpnyId varchar(10), @ShipperId varchar(15), @ManifestUpdated smallint output As
Declare @BoxRef varchar(5)
Declare @ContainerId varchar(10)
Declare @CODCharge float
Declare @ShpCharge float
Declare @InsurCharge float
Declare @OverSizeCharge float
Declare @TrackingNbr varchar(30)
Declare @Volume float
Declare @Weight float
Declare @BoxInt int
Declare @BoxTemp varchar(5)
Declare @OtherCost float
Declare @CuryOtherCost float
Declare @TruckId varchar(20)
Declare @UCC128 varchar(20)
Declare @CuryId varchar(4)
Declare @SOShipPackCount int
Declare @TareFlag smallint
Declare csr_EDContainer Cursor For Select ContainerID, CODCharge, ShpCharge, InsurCharge,
        OverSizeCharge, TrackingNbr, Volume, Weight,
        OtherCost = HazCharge + MiscCharge + PickUpCharge + SurCharge + TrackCharge + AHCharge,
        UCC128, CuryId, TareFlag
        From EDContainer
        Where CpnyId = @CpnyId And ShipperId = @ShipperId And (TareFlag = 1 Or (TareFlag = 0 And LTrim(RTrim(TareId)) = ''))

-- initialize
Set @ManifestUpdated = 0

-- Check for existing SOShipPack records - would have been created either manually or by Aristo.
Select @SOShipPackCount = Count(*) From SOShipPack Where CpnyId = @CpnyId And ShipperId = @ShipperId
If @SOShipPackCount > 0 Goto ExitProc  -- if there are already SOShipPack records then we will not do anything.

-- Delete existing SHShipPack, SHShipHeader Records.
Delete From SHShipPack Where CpnyId = @CpnyId And ShipperId = @ShipperId
Delete From SHShipHeader Where CpnyId = @CpnyId And ShipperId = @ShipperId
-- Get TruckId (called EquipNbr in EDShipment) - this field is not in SHShipPack table yet but we are ready when it is!
Select @TruckId = A.EquipNbr From EDShipMent A,  EDShipTicket B Where B.CpnyId = @CpnyId
       And B.ShipperId = @ShipperId And B.BOLNbr = A.BOLNBr
-- Initialize  loop
Set @BoxInt = 0
Open csr_EDContainer
Fetch Next From csr_EDContainer Into @ContainerId, @CODCharge, @ShpCharge, @InsurCharge,
         @OverSizeCharge, @TrackingNbr, @Volume, @Weight, @OtherCost, @UCC128, @CuryId, @TareFlag
While @@Fetch_Status <> -1
Begin
  Set @BoxInt = @BoxInt + 1
  Set @BoxTemp = Rtrim(LTrim(Str(@BoxInt)))
  Set @BoxRef = Replicate('0',5 - Len(@BoxTemp)) + @BoxTemp
  If @TareFlag = 0
--    Insert Into SHShipPack Values (@ShpCharge,@BoxRef,0,@CODCharge,@CpnyId,getdate(), '', '',@CuryId,0,
--    @InsurCharge,getdate(), '', '',@OtherCost,@OverSizeCharge,' ',' ',@UCC128,' ',0,0,0,0,
--    '01-01-1900','01-01-1900',0,0,@ContainerId, ' ',@ShipperId, Right(RTrim(@TrackingNbr),20),' ','01-01-1900',
--    ' ',' ',' ',0,0,' ',' ','01-01-1900',@Volume, @Weight,DEFAULT)

    Insert Into SHShipPack Values (@ShpCharge,@BoxRef,'',0,@CODCharge,'',@CpnyId,getdate(), '', '',@CuryId,0,
    @InsurCharge,getdate(), '', '',@OtherCost,@OverSizeCharge,' ',' ',@UCC128,' ',0,0,0,0,
    '01-01-1900','01-01-1900',0,0,@ContainerId, ' ',@ShipperId, Right(RTrim(@TrackingNbr),20),'',' ','01-01-1900',
    ' ',' ',' ',0,0,' ',' ','01-01-1900',@Volume, @Weight,DEFAULT)

  Else
    Insert Into SHShipPack Values (@ShpCharge,@BoxRef,'',0,@CODCharge,'',@CpnyId,getdate(), '', '',@CuryId,0,
    @InsurCharge,getdate(), '', '',@OtherCost,@OverSizeCharge,' ',' ',@UCC128,@UCC128,0,0,0,0,
    '01-01-1900','01-01-1900',0,0,@ContainerId, ' ',@ShipperId, Right(RTrim(@TrackingNbr),20),'',' ','01-01-1900',
    ' ',' ',' ',0,0,' ',' ','01-01-1900',@Volume, @Weight,DEFAULT)
  Fetch Next From csr_EDContainer Into @ContainerId, @CODCharge, @ShpCharge, @InsurCharge,
    @OverSizeCharge, @TrackingNbr, @Volume, @Weight, @OtherCost, @UCC128, @CuryId, @TareFlag
End
Close csr_EDContainer
If @BoxInt > 0 Begin
  Insert Into SHShipHeader Values(@CpnyId,GetDate(),' ',' ',GetDate(),' ',' ',' ',' ',0,
    0,0,0,'01-01-1900','01-01-1900',0,0,' ',' ','01-01-1900',@ShipperId,1,0,' ',0,' ',' ',' ',
    0,0,' ',' ','01-01-1900',' ',DEFAULT)
  Set @ManifestUpdated = 1
  EXEC ADG_ProcessMgr_QueueUpdASMMf @CpnyId, @ShipperId
End
ExitProc:
Deallocate csr_EDContainer


