 CREATE Procedure EDSC_GenerateContainerSingle @CpnyId VarChar(10), @ShipperId VarChar(15), @TrackDetail smallint As

Declare @Invtid varchar(30), @LotSerNbr varchar(25), @WhseLoc varchar(10), @Qtyship float,@LineRef varchar(5), @UnitDesc varchar(6),@UnitMultDiv varchar(1), @CnvFact float,@LotSerRef varchar(5)
Declare @LineCount smallint
Declare @UCC128 varchar(20)
Declare @ContainerId varchar(10)
Declare @SumWeight float
Declare @NbrWeightUOMs int
Declare @ContainerWeightUOM varchar(6)
Declare @Weight float
Declare @WeightUOM varchar(6)
Declare @LineUnitDesc varchar(6)
Declare @Crtd_Date smalldatetime
Declare @Crtd_Prog varchar(8)
Declare @Crtd_User varchar(10)
Declare @Lupd_Date smalldatetime
Declare @Lupd_User varchar(10)
Declare @Lupd_Prog varchar(8)
Declare @CuryEffDate smalldatetime
Declare @CuryId varchar(4)
Declare @CuryMultDiv varchar(1)
Declare @CuryRate float
Declare @CuryRateType varchar(6)

Select @Crtd_Date = Crtd_DateTime, @Crtd_User = Crtd_User, @Crtd_Prog = Crtd_Prog,
@Lupd_Date = Lupd_DateTime, @Lupd_User = Lupd_User, @Lupd_Prog = Lupd_Prog,
@CuryEffDate = CuryEffDate, @CuryId = CuryId, @CuryMultDiv = CuryMultDiv, @CuryRate = CuryRate,
@CuryRateType = CuryRateType
From SOShipHeader Where CpnyId = @CpnyId And ShipperId = @ShipperId

-- Build the container header
Exec EDGetNextContainerId @ContainerId OUTPUT
Exec EDCalcMod10ChkDigit @ContainerId, @UCC128 OUTPUT
--Create a single header record [the Pack Method for a single container is always PP]
Begin transaction
Insert into EDContainer values(0,' ',0,' ',0,@ContainerId,@CpnyId,@Crtd_Date,@Crtd_Prog,@Crtd_User,0,0,0,@CuryEffDate,0,0,@CuryId,0,0,@CuryMultDiv,0,0,@CuryRate,@CuryRateType,0,0,0,0,0,0,0,0,' ',0,'01/01/1900',0,0,' ',@Lupd_Date,@Lupd_Prog,@Lupd_User,0,0,0,'PP',0,' ',' ',0,0,0,0,'01/01/1900','01/01/1900',0,0,' ',' ',@ShipperId,' ',0,'01/01/1900',' ',0,0,0,' ',0,0,0,' ',@UCC128,' ','01/01/1900',' ',' ',' ',0,0,' ',' ','01/01/1900',0,' ',0,' ',0,' ',DEFAULT)
IF @@ROWCOUNT = 0 Begin
  Rollback Tran
  Goto ExitProc
End

If @TrackDetail = 1 Begin

  DECLARE recstopack_csr CURSOR FOR
  SELECT A.Invtid, A.LotSernbr, A.WhseLoc,A.LineRef,A.LotSerRef,B.UnitMultDiv,CnvFact = Case When B.CnvFact = 0 then 1 else B.CnvFact End,A.QtyShip, C.StkUnit, D.Weight, D.WeightUOM, B.UnitDesc
    FROM SOShipLot A, SOShipLine B, Inventory C, InventoryADG D
   WHERE A.CpnyId = @CpnyId AND A.ShipperId = @ShipperId AND A.CpnyId = B.CpnyId
     AND A.ShipperId = B.ShipperId AND A.LineRef = B.LineRef AND A.Invtid = C.Invtid AND A.InvtId = D.InvtId AND C.StkItem <> 0
   ORDER BY A.Invtid, A.LotSerNbr

  Open recstopack_csr

  Fetch Next from recstopack_csr into @Invtid, @LotSerNbr, @WhseLoc, @LineRef, @LotSerRef,@UnitMultDiv,@CnvFact,@Qtyship,@UnitDesc, @Weight, @WeightUOM, @LineUnitDesc
  -- Initialize ContainerWeightUOM and NbrWeightUOMs.  If all of the items going into this container
  -- have the same weightUOM then we will fill in the weight & weightuom fields on the container
  -- header.
  Set @ContainerWeightUOM = @WeightUOM
  Set @NbrWeightUOMs = 1
  Set @SumWeight = 0
  If LTrim(RTrim(@WeightUOM)) = '' -- if the first item has no weightuom then make sure we don't fill in weight on the header
    Set @NbrWeightUOMs = 2
  Set @LineCount = 0
  While (@@FETCH_STATUS=0) Begin
    If @UnitMultDiv = 'M'
      Set @QtyShip =  @QtyShip * @CnvFact
    Else
      Set @QtyShip = @QtyShip/ @CnvFact
    Set @LineCount = @LineCount + 1
    --create a single detail line for each line in cursor
    Insert Into EDContainerDet values(@ContainerId,@CpnyId,@Crtd_Date,@Crtd_Prog,@Crtd_User,@Invtid,(-32768 + @LineCount),@LineRef,@LotSerNbr,@Lupd_Date,@Lupd_Prog,@Lupd_User,0,@QtyShip,@QtyShip,' ',' ',0,0,0,0,'01/01/1900','01/01/1900',0,0,' ',' ',@ShipperId,@UnitDesc,' ','01/01/1900',' ',' ',' ',0,0,' ',' ','01/01/1900',@WhseLoc,DEFAULT)
    IF @@ROWCOUNT = 0 Begin
      CLOSE recstopack_csr
      DEALLOCATE recstopack_csr
      Rollback Tran
      Goto ExitProc
    end
    Set @SumWeight = @SumWeight + (@Weight * @QtyShip)
    If @ContainerWeightUOM <> @WeightUOM
      Set @NbrWeightUOMs = @NbrWeightUOMs + 1
    Fetch Next from recstopack_csr into @Invtid, @LotSerNbr, @WhseLoc, @LineRef, @LotSerRef,@UnitMultDiv,@CnvFact,@Qtyship,@UnitDesc,@Weight,@WeightUOM,@LineUnitDesc
  End

  CLOSE recstopack_csr
  DEALLOCATE recstopack_csr
End
If @NbrWeightUOMS = 1 And @TrackDetail = 1
  Update EDContainer Set Weight = @SumWeight, WeightUOM = @ContainerWeightUOM Where CpnyId = @CpnyId And ShipperId = @ShipperId And ContainerId = @ContainerId
Update SOShipHeader Set TotBoxes = 1 Where CpnyId = @CpnyId And ShipperId = @ShipperId
commit tran

ExitProc:


