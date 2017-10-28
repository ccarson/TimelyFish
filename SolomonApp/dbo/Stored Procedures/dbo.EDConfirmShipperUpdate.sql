 CREATE Proc EDConfirmShipperUpdate @CpnyId varchar(10), @ShipperId varchar(10) As
-- Updates the bill of lading when a shipper is confirmed.  Also loads the manifest if container
-- records exist.  Returns 0 if the manifest was not updated otherwise returns 1.

Declare @CalcWeight smallint
Declare @Weight float
Declare @Volume float
Declare @ManifestUpdated smallint
Declare @MinWUom varchar(6)
Declare @MaxWUom varchar(6)
Declare @MinVUom varchar(6)
Declare @MaxVUom varchar(6)
Declare @AHCharge float
Declare @CODCharge float
Declare @HazCharge float
Declare @InsurCharge float
Declare @MiscCharge float
Declare @OverSizeCharge float
Declare @PickUpCharge float
Declare @ShpCharge float
Declare @SurCharge float
Declare @TotBillCharge float
Declare @TotShipCharge float
Declare @BolNbr varchar(20)
Declare @NbrShippers int
Declare @SCAC varchar(5)
Declare @ShipViaId varchar(15)
Declare @ShipDateAct smalldatetime
DECLARE @ContTrackLevel as varchar(10)		-- QN 05/07/2002, DE 228692 - Container Track Level

-- QN 05/07/2002, DE 228692 - initialize as Updated for non-EDI Customer or NOT Track Container
Set @ManifestUpdated = 1

Select @CalcWeight = CalcWeight From ANSetup
If @CalcWeight Is Null -- would be true if ASN is not installed.
  Goto ExitProc

	-- QN 05/07/2002, DE 228692 - ASN is installed,
	-- If NOT Track Container, RETURN @ManifestUpdated = 1
	SELECT @ContTrackLevel = ISNULL(CustomerEDI.ContTrackLevel,'')
	FROM SOShipHeader INNER JOIN CustomerEDI ON SOShipHeader.CustID = CustomerEDI.CustID
	WHERE 	CpnyID = @CpnyId AND ShipperID = @ShipperId

Select @BolNbr = BOLNbr From EDShipTicket Where CpnyId = @CpnyId And ShipperId = @ShipperId

Select @NbrShippers = Count(*) From EDShipTicket Where BolNbr = @BolNbr

Select @ShipDateAct = IsNull(NullIf(ShipDateAct,''),GetDate()) From SOShipHeader Where CpnyId = @CpnyId And ShipperId = @ShipperId

If @NbrShippers = 1 Update EDShipment Set ShpDate = @ShipDateAct Where BOLNbr = @BOLNbr

	IF @ContTrackLevel = 'NCR' OR LTRIM(RTRIM(@ContTrackLevel)) = ''
	BEGIN
		If (Select Count(*) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId) = 0
			GOTO ExitProc
	END

-- initialize
Set @ManifestUpdated = 0

Select @AHCharge = IsNull(Sum(AHCharge),0), @CODCharge = IsNull(Sum(CODCharge),0), @HazCharge = IsNull(Sum(HazCharge),0),
  @InsurCharge = Isnull(Sum(InsurCharge),0), @MiscCharge = IsNull(Sum(MiscCharge),0), @OverSizeCharge = IsNull(Sum(OverSizeCharge),0),
  @PickUpCharge = IsNull(Sum(PickUpCharge),0), @ShpCharge = IsNull(Sum(ShpCharge),0), @SurCharge = IsNull(Sum(SurCharge),0),
  @TotBillCharge = IsNull(Sum(TotBillCharge),0), @TotShipCharge = IsNull(Sum(TotShipCharge),0)
  From EDContainer Where BOLNbr = @BOLNbr

If @NbrShippers > 1 Begin
  Update EDShipment Set AHCharge = @AHCharge, CODCharge = @CODCharge, HazCharge = @HazCharge,
    InsurCharge = @InsurCharge, MiscCharge = @MiscCharge, OverSizeCharge = @OverSizeCharge,
    PickUpCharge = @PickUpCharge, ShpCharge = @ShpCharge, SurCharge = @SurCharge,
    TotBillCharge = @TotBillCharge, TotShipCharge = @TotShipCharge
    Where BOLNbr = @BOLNbr
End Else Begin
  Select @ShipViaId = A.ShipViaId, @SCAC = B.SCAC, @ShipDateAct = Case
    When DatePart(yyyy,A.ShipDateAct) = 1900 And DatePart(mm,A.ShipDateAct) = 1 And DatePart(dd,A.ShipDateAct) = 1 Then GetDate()
    Else
      A.ShipDateAct
    End
    From SOShipHeader A Inner Join ShipVia B On A.CpnyId = B.CpnyId And A.ShipViaId = B.ShipViaId
    Where A.CpnyId = @CpnyId And A.ShipperId = @ShipperId
  Update EDShipment Set AHCharge = @AHCharge, CODCharge = @CODCharge, HazCharge = @HazCharge,
    InsurCharge = @InsurCharge, MiscCharge = @MiscCharge, OverSizeCharge = @OverSizeCharge,
    PickUpCharge = @PickUpCharge, ShpCharge = @ShpCharge, SurCharge = @SurCharge,
    TotBillCharge = @TotBillCharge, TotShipCharge = @TotShipCharge, ShpDate = @ShipDateAct,
    ViaCode = @ShipViaId, SCAC = @SCAC
    Where BOLNbr = @BOLNbr
End

If @CalcWeight = 1 Begin
  Select @Weight = IsNull(Sum(Weight),0), @Volume = IsNull(Sum(Volume),0), @MinWUom = IsNull(Min(WeightUom), ' '),
    @MaxWUom = IsNull(Max(WeightUom),' '), @MinVUom = IsNull(Min(VolumeUOM),' '), @MaxVUom = IsNull(Max(VolumeUom), ' ')
    From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId

  If @MinWUom <> @MaxWUom Begin
    Set @MaxWUom = ' '
    Set @Weight = 0
  End

  If @MinVUom <> @MaxVUom Begin
    Set @MaxVUom = ' '
    Set @Volume = 0
  End
   Update EDSOShipHeader Set Weight = @Weight, Volume = @Volume, WeightUom = @MaxWUom, VolumeUOM = @MaxVUom Where CpnyId = @CpnyId And ShipperId = @ShipperId

End

EXEC EDContainer_UpdateManifest @CpnyId, @ShipperId, @ManifestUpdated output

ExitProc:
-- return flag
Select @ManifestUpdated



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConfirmShipperUpdate] TO [MSDSL]
    AS [dbo];

