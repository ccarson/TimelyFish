
CREATE Procedure EDSC_GenerateContainerMulti
@CpnyId VarChar(10), 
@ShipperId VarChar(15), 
@TrackDetail smallint , 
@ChangeMade smallint Output As

Set NoCount On
Declare @DimPrecision Int
Declare @StkUnitQty float
Declare @PackUOM varchar(6)
Declare @PackSize smallint
Declare @Pack smallint
Declare @StockUnitMultDiv varchar(1)
Declare @StockCnvFact float
Declare @CartonQty float
Declare @InnerPack numeric(11,6)
Declare @NbrLeftOverInnerPacks int
Declare @NbrCartons Int
Declare @StkUnit varchar(6)
Declare @StdCartonBreak smallint
Declare @ClassId varchar(6)
Declare @TotalNbrContainers int
Declare @LastSerContainer varchar(10)
Declare @NextNum int
Declare @NextContainerId varchar(10)
Declare @UCC128 varchar(20)
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
Declare @FlexDecPl smallint
Declare @LastInvtId varchar(30)
Declare @LastUnitMultDiv varchar(1)
Declare @LastCnvFact float
Declare @UnitMultDiv varchar(1)
Declare @CnvFact float
Declare @FullCartonQty float
Declare @CartonWeight float
Declare @WeightDecPl smallint
Declare @InnerPackQty numeric(11,6)
Declare @RoundWeightPlaces smallint
Declare @Invtid varchar(30)
Declare @QtyPacked float
Declare @SCHeight float
Declare @SCHeightUOM varchar(6)
Declare @SCLen float
Declare @SCLenUOM varchar(6)
Declare @SCVolume float
Declare @SCVolumeUOM varchar(6)
Declare @SCWeight float
Declare @SCWeightUOM varchar(6)
Declare @SCWidth float
Declare @SCWidthUOM varchar(6)
Declare @WhseLoc varchar(10)
Declare @LotSerNbr varchar(25)
Declare @LineRef varchar(5)
Declare @QtyBreakPacks int
Declare @NbrPacks int
Declare @QtyShip float
Declare @ChangedLineCount int
Declare @UnitDesc varchar(6)
Declare @QtyLeftOver float
Declare @OrdNbr varchar(15)
Declare @NbrFreeFormContainers int
Declare @LineId int
Declare @NbrLineFreeFormContainers int
Declare @FreeFormShipperQty float
Declare @FreeFormWhseLoc varchar(10)
Declare @FreeFormLotSerNbr varchar(25)
Declare @FreeFormQtyPerContainer varchar(25)
Declare @LastFreeFormInvtId varchar(30)
Declare @FreeFormInvtId varchar(30)
Declare @FreeFormShipperLineRef varchar(5)
Declare @FreeFormShipperUnit varchar(6)
Declare @FreeFormLineNbr smallint
Declare @FreeFormQtyToAssign float
Declare @FreeFormQtyRemain float
Declare @NbrPreviousOrders int
Declare @EDIPOID varchar(10)
Declare @SubLineHandling float

Declare @WLTLineRef char(10)
Declare @WLTInvtID char(30)
Declare @WLTLotSerNbr char(25)
Declare @WLTWhseLoc char(10)
Declare @WLTQtyShip float
Declare @tempQty float
Declare @Cont_Status int
Declare @WLT_Status int
Declare @LineNum int
Declare @INSetupDecPl smallint

Create Table #ContainerBuild (InvtId char(30), LineRef char(5),
  StkUnitQty float, NbrCartons int, QtyBreakPacks int, 
  PackUOM char(6), PackSize smallint, Pack smallint, StkUnit char(6), StdCartonBreak smallint,
  ClassId varchar(6), SCHeight float, SCHeightUOM char(6), SCLen float, SCLenUOM char(6), 
  SCVolume float, SCVolumeUOM char(6), SCWeight float, SCWeightUOM char(6), 
  SCWidth float, SCWidthUOM char(6), QtyPacked float, WeightDecPl smallint NULL, 
  FullCartonQty float, InnerPackQty float, CnvFact float, UnitMultDiv char(1),
  QtyShip float, UnitDesc char(6))


Create Table #WhseLocTable(LineRef char(10), InvtID char(30), LotSerNbr char(25), WhseLoc char(10), QtyShip float)


Declare csr_ContainerBuild Cursor For Select InvtId, StkUnitQty, PackUOM, PackSize, Pack, StkUnit, StdCartonBreak, ClassId, UnitMultDiv, CnvFact, QtyShip, UnitDesc From #ContainerBuild For Update
Declare csr_ContainerBuild2 Cursor For Select InvtId, QtyPacked, SCHeight, SCHeightUOM, 
SCLen, SCLenUOM, SCVolume, SCVolumeUOM, SCWeight, SCWeightUOM, SCWidth, SCWidthUOM, NbrCartons, QtyBreakPacks, LineRef, UnitDesc, InnerPackQty, FullCartonQty, IsNull(WeightDecPl,0) From #ContainerBuild

Select  @DimPrecision = DecPlQty from InSetup
Set @LastInvtId = ''
Set @LastUnitMultDiv = ''
Set @LastCnvFact = 0 
Set @TotalNbrContainers = 0
Set @ChangeMade = 0

-- read values that will be used for each insertion
Select @Crtd_Date = A.Crtd_DateTime, @Crtd_User = A.Crtd_User, @Crtd_Prog = A.Crtd_Prog, 
@Lupd_Date = A.Lupd_DateTime, @Lupd_User = A.Lupd_User, @Lupd_Prog = A.Lupd_Prog, 
@CuryEffDate = A.CuryEffDate, @CuryId = A.CuryId, @CuryMultDiv = A.CuryMultDiv, @CuryRate = A.CuryRate,
@CuryRateType = A.CuryRateType, @OrdNbr = A.OrdNbr, @EDIPOID = B.EDIPOID, @SubLineHandling =
C.S4Future03 From SOShipHeader A Inner Join SOHeader B On A.CpnyId = B.CpnyId And 
A.OrdNbr = B.OrdNbr Inner Join CustomerEDI C On B.CustId = C.CustId Where A.CpnyId = @CpnyId
And A.ShipperId = @ShipperId

-- Convert the temp counter in the ED850SOLine table to the real order nbr
Select @NbrPreviousOrders = Count(*) From SOHeader Where EDIPOID = @EDIPOID And OrdNbr < 
  @OrdNbr And Cancelled = 0
Update ED850SOLine Set OrdNbr = @OrdNbr Where CpnyId = @CpnyId And OrdNbr = @EDIPOID + 
  Right('00000' + Cast(@NbrPreviousOrders + 1 As varchar(5)),5)
If @SubLineHandling = 4 
  -- Delete lines from ED850SOLine where no sub line item data exists
  Delete From ED850SOLine Where CpnyId = @CpnyId And OrdNbr = @OrdNbr And Not Exists (Select
    * From ED850SubLineItem Where CpnyId = @CpnyId And EDIPOID = @EDIPOID And LineId = 
    ED850SOLine.LineId)
Else
  Delete From ED850SOLine Where CpnyId = @CpnyId And OrdNbr = @OrdNbr
  
-- Get the DecPl from INSetup for use later
Select @INSetupDecPl = DecPlQty from INSetup

Insert Into #ContainerBuild
Select Max(A.InvtId), A.LineRef,  
  Case Max(B.UnitMultDiv)
    When 'M' Then Sum(A.QtyShip*B.CnvFact)
    When 'D' Then Sum(A.QtyShip/B.CnvFact)
  End 
  ,0, 0, Max(C.PackUOM), Max(C.PackSize), Max(C.Pack), Max(D.StkUnit), Max(C.StdCartonBreak),
  Max(D.ClassId), Max(C.SCHeight), Max(C.SCHeightUOM), Max(C.SCLen), Max(C.SCLenUOM), 
  Max(C.SCVolume), Max(C.SCVolumeUOM), Max(C.SCWeight), Max(C.SCWeightUOM), Max(C.SCWidth),
  Max(C.SCWidthUOM), 0, Max(IsNull(E.DecPl, @INSetupDecPl)), 0, 0, Max(B.CnvFact), Max(B.UnitMultDiv), 
  Sum(A.QtyShip), Max(B.UnitDesc)
From SOShipLot A Inner Join SOShipLine B On A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId And A.LineRef = B.LineRef
Inner Join InventoryADG C On B.InvtId = C.InvtId Inner Join Inventory D On B.InvtId = D.InvtId
Left Outer Join EDUOMFP E On Dimension = 'Wei' And UOM = C.SCWeightUOM Inner Join SOShipHeader F
On B.CpnyId = F.CpnyId And B.ShipperId = F.ShipperId Where A.CpnyId = @CpnyId And 
A.ShipperId = @ShipperId And C.PackMethod = 'SC' And A.QtyShip > 0 And Not Exists (Select
* From ED850SOLine G Where G.OrdNbr = F.OrdNbr and G.LineRef = B.OrdLineRef)
Group By A.LineRef


Insert Into #WhseLocTable
Select Cast(Cast(LineRef As int) as char(5)) + Cast(Cast(LotSerRef as int) as char(5)) Ref, InvtId, LotSerNbr, WhseLoc, QtyShip
from SOShipLot
Where ShipperId = @ShipperId
Order By Ref, LotSerNbr


Open csr_ContainerBuild
Fetch Next From csr_ContainerBuild Into @InvtId, @StkUnitQty, @PackUom, @PackSize, @Pack, @StkUnit, @StdCartonBreak, @ClassId, @UnitMultDiv, @CnvFact, @QtyShip, @UnitDesc
While (@@Fetch_Status = 0) Begin

  If @LastInvtId <> @InvtId Or @LastUnitMultDiv <> @UnitMultDiv Or @LastCnvFact <> @CnvFact Begin
    -- determine the inner pack in stocking units
    Select @StockUnitMultDiv = MultDiv, @StockCnvFact = CnvFact From InUnit Where FromUnit = @PackUom And ToUnit = @StkUnit And InvtId In (@InvtId,'*') And ClassId In (@ClassId,'*') Order By UnitType
    If @StockUnitMultDiv Is Null
      Goto BottomOfLoop  -- nothing to do for this part.

    IF @PackUom = @UnitDesc 
      BEGIN
         --If the InventoryADG UOM is the same as the SOShipLine UOM, then just use the Inventory PackSize and don't recalculate it.
         SET @CartonQty = round(@PackSize  * @Pack, @DimPrecision)
         SET @InnerPack = @PackSize
      END 
    ELSE
      BEGIN
         If @StockUnitMultDiv = 'M' Begin
            Set @InnerPack = @PackSize * @StockCnvFact
         End Else Begin
            Set @InnerPack = @PackSize / @StockCnvFact
         End 

    	-- Convert the inner pack to the shippers unit
    	If @UnitMultDiv = 'D'
           Set @InnerPack = @InnerPack * @CnvFact
    	Else
           Set @InnerPack = @InnerPack / @CnvFact
        -- Determine the carton qty in the shippers unit
    	Set @CartonQty  = Round(@InnerPack * @Pack, @DimPrecision)
      END      
  End

  If @StockUnitMultDiv Is Null
    Goto BottomOfLoop  -- nothing to do for this part.

  Set @NbrCartons = 0
  While @QtyShip >= @CartonQty And @CartonQty > 0 Begin
    Set @NbrCartons = @NbrCartons + 1
    Set @QtyShip = @QtyShip - @CartonQty
  End

  Set @NbrLeftOverInnerPacks = 0
  If @StdCartonBreak = 1 And @InnerPack > 0 Begin
    While @QtyShip >= @InnerPack Begin
      Set @NbrLeftOverInnerPacks = @NbrLeftOverInnerPacks + 1
      Set @QtyShip = @QtyShip - @InnerPack
    End
  End

  If @NbrLeftOverInnerPacks > 0 
    Set @TotalNbrContainers = @TotalNbrContainers + @NbrCartons + 1  
  Else
    Set @TotalNbrContainers = @TotalNbrContainers + @NbrCartons  
    
  Set @QtyPacked = (@NbrCartons * @CartonQty) + (@InnerPack * @NbrLeftOverInnerPacks)

  Update #ContainerBuild Set NbrCartons = @NbrCartons, QtyBreakPacks = @NbrLeftOverInnerPacks,
    FullCartonQty = @CartonQty, QtyPacked = @QtyPacked, 
    InnerPackQty = @InnerPack Where Current Of csr_ContainerBuild

BottomOfLoop:

Fetch Next From csr_ContainerBuild Into @InvtId, @StkUnitQty, @PackUom, @PackSize, @Pack, @StkUnit, @StdCartonBreak, @ClassId, @UnitMultDiv, @CnvFact, @QtyShip, @UnitDesc
End

Close csr_ContainerBuild



-- Calculate the number of free form containers that will be created.
Select A.LineId, A.LineRef 'OrdLineRef', C.LineRef 'ShipperLineRef', C.InvtId 'ShipperInvtId',
D.QtyShip 'ShipperQty', C.UnitDesc 'ShipperUnit', D.WhseLoc, D.LotSerNbr, Cast(0 As float) 'QtyPerContainer',
Cast(0 As float) 'NbrContainers' Into #FreeForm
From ED850SOLine A Inner Join SOShipHeader B On A.CpnyId = B.CpnyId And A.OrdNbr = B.OrdNbr
Left Outer Join SOShipLine C On B.CpnyId = C.CpnyId And B.ShipperId = C.ShipperId And 
A.LineRef = C.OrdLineRef Left Outer Join SOShipLot D On C.CpnyId = D.CpnyId And C.ShipperId =
D.ShipperId And C.LineRef = D.LineRef
Where B.CpnyId = @CpnyId And B.ShipperId = @ShipperId

If @@RowCount > 0 Begin -- this statement can not be separated from the one above!
  Update #FreeForm Set QtyPerContainer = ED850SubLineItem.Qty, NbrContainers = ShipperQty /
    ED850SubLineItem.Qty From ED850SubLineItem Where #FreeForm.ShipperInvtId = ED850SubLineItem.InvtId
    And #FreeForm.LineId = ED850SubLineItem.LineId And #FreeForm.ShipperUnit = ED850SubLineItem.UOM
    And ED850SubLineItem.CpnyId = @CpnyId And ED850SubLineItem.EDIPOID = @EDIPOID

  Select Floor(Min(NbrContainers)) 'NbrContainers', LineId Into #FreeFormContainerCount 
    From #FreeForm Group By LineId

  Select @NbrFreeFormContainers = Sum(NbrContainers) From #FreeFormContainerCount

End Else Begin
  Set @NbrFreeFormContainers = 0
End
  
Set @TotalNbrContainers = @TotalNbrContainers + @NbrFreeFormContainers

-- update the ansetup table.
Begin Tran
Select @LastSerContainer = LastSerContainer From ANSetup
Select @NextNum = (Convert(Int,@LastSerContainer) + @TotalNbrContainers)
Update ANSetup Set LastSerContainer = Replicate('0',10 - Len(Rtrim(LTrim(Str(@NextNum))))) + ltrim(rtrim(str(@NextNum)))
Commit Tran

-- Create containers
Open csr_ContainerBuild2
Set @NextContainerId = @LastSerContainer

Fetch Next From csr_ContainerBuild2 Into @InvtId, @QtyPacked, @SCHeight, @SCHeightUOM, @SCLen, @SCLenUOM, @SCVolume, 
  @SCVolumeUOM, @SCWeight, @SCWeightUOM, @SCWidth, @SCWidthUOM, @NbrCartons, @QtyBreakPacks, @LineRef, @UnitDesc, @InnerPackQty, @FullCartonQty, @WeightDecPl

Set @Cont_Status = @@Fetch_Status

Declare csr_WhseLocTable Cursor For Select LineRef, InvtID, LotSerNbr, WhseLoc, QtyShip From #WhseLocTable Where InvtID = @Invtid For Update
Open csr_WhseLocTable

Fetch Next From csr_WhseLocTable Into @WLTLineRef, @WLTInvtID, @WLTLotSerNbr, @WLTWhseLoc, @WLTQtyShip
Set @WLT_Status = @@Fetch_Status

While ( @Cont_Status = 0) Begin

	If @WLTQtyShip = 0 Begin
		Fetch Next From csr_WhseLocTable Into @WLTLineRef, @WLTInvtID, @WLTLotSerNbr, @WLTWhseLoc, @WLTQtyShip
		Set @WLT_Status = @@Fetch_Status
	End
	
	If rtrim(@WLTInvtID) <> rtrim(@InvtID) Begin
		Close csr_WhseLocTable
		Deallocate csr_WhseLocTable

		Declare csr_WhseLocTable Cursor For Select LineRef, InvtID, LotSerNbr, WhseLoc, QtyShip From #WhseLocTable Where InvtID = @Invtid For Update
		Open csr_WhseLocTable

		Fetch Next From csr_WhseLocTable Into @WLTLineRef, @WLTInvtID, @WLTLotSerNbr, @WLTWhseLoc, @WLTQtyShip
		Set @WLT_Status = @@Fetch_Status
	End
	
	While @NbrCartons > 0 Or @QtyBreakPacks > 0 Begin
		Set @NextContainerId = Right('0000000000' + Cast(Cast(@NextContainerId As int) + 1 As varchar(10)),10)
		Exec EDCalcMod10ChkDigit @NextContainerId, @UCC128 OUTPUT -- get cartons UCC128 number

		If @NbrCartons = 0 Begin
			-- we are processing the break carton
			If @WeightDecPl > 0 
				Set @RoundWeightPlaces = @WeightDecPl
			Else
				Set @RoundWeightPlaces = 3 
			Set @CartonWeight = Round(((@QtyBreakPacks * @InnerPackQty) / @FullCartonQty) * @SCWeight,@RoundWeightPlaces)
			Set @CartonQty = Round(@QtyBreakPacks * @InnerPackQty, @DimPrecision)
			Set @QtyBreakPacks = 0
		End Else Begin
			Set @CartonWeight = @SCWeight  
			Set @CartonQty = @FullCartonQty
		End 

		Insert into EDContainer 
			values(0,' ',0,' ',0,	@NextContainerId,	@CpnyId,	@Crtd_Date,	@Crtd_Prog,	@Crtd_User,0,0,0,	@CuryEffDate,0,0,
				@CuryId,0,0,	@CuryMultDiv,0,0,	@CuryRate,	@CuryRateType,0,0,0,0,0,0,0,	@SCHeight,	@SCHeightUOM,0,'01/01/1900',0,
				@SCLen,	@SCLenUOM,	@Lupd_Date,	@Lupd_Prog,	@Lupd_User,0,0,0,'SC',0,' ',' ',0,0,0,0,'01/01/1900','01/01/1900',0,0,' ',' ',
				@ShipperId,' ',0,'01/01/1900',' ',0,0,0,' ',0,0,0,' ',	@UCC128,' ','01/01/1900',' ',' ',' ',0,0,' ',' ','01/01/1900',
				@SCVolume,	@SCVolumeUOM,	@CartonWeight,	@SCWeightUOM,	@SCWidth,	@SCWidthUOM,	DEFAULT)

		-- If necessary, create  detail record for the carton
		If @TrackDetail = 1 Begin
			Set @tempQty = @FullCartonQty
			
			If @WLTQtyShip = 0 Begin
				Fetch Next From csr_WhseLocTable Into @WLTLineRef, @WLTInvtID, @WLTLotSerNbr, @WLTWhseLoc, @WLTQtyShip
				Set @WLT_Status = @@Fetch_Status
			End
		
			Set @LineNum = -32768

			While @WLT_Status = 0 and @tempQty > 0 Begin
				If @tempQty <= @WLTQtyShip Begin
					Insert Into EDContainerDet 
						Values(@NextContainerId,	@CpnyId,		@Crtd_Date,		@Crtd_Prog,		@Crtd_User,		@WLTInvtID,		@LineNum,	 
								@LineRef,			@WLTLotSerNbr,	@Lupd_Date,		@Lupd_Prog,		@Lupd_User,0,	@WLTQtyShip,	@tempQty,
								' ',' ',0,0,0,0,'01/01/1900','01/01/1900',0,0,' ',' ',
								@ShipperId,			@UnitDesc,
								' ','01/01/1900',' ',' ',' ',0,0,' ',' ','01/01/1900',
								@WLTWhseLoc,		DEFAULT)

					Set @WLTQtyShip = @WLTQtyShip - @tempQty
					Set @tempQty = 0
				End
				Else Begin
					Insert Into EDContainerDet 
						Values(@NextContainerId,	@CpnyId,		@Crtd_Date,		@Crtd_Prog,		@Crtd_User,		@WLTInvtID,		@LineNum,	 
								@LineRef,			@WLTLotSerNbr,	@Lupd_Date,		@Lupd_Prog,		@Lupd_User,0,	@WLTQtyShip,	@WLTQtyShip,
								' ',' ',0,0,0,0,'01/01/1900','01/01/1900',0,0,' ',' ',
								@ShipperId,			@UnitDesc,
								' ','01/01/1900',' ',' ',' ',0,0,' ',' ','01/01/1900',
								@WLTWhseLoc,		DEFAULT)

					Set @tempQty = @tempQty - @WLTQtyShip
					Set @WLTQtyShip = 0
				End
				If @WLTQtyShip =  0 Begin
					Fetch Next From csr_WhseLocTable Into @WLTLineRef, @WLTInvtID, @WLTLotSerNbr, @WLTWhseLoc, @WLTQtyShip
					Set @WLT_Status = @@Fetch_Status
				End
				Set @LineNum = @LineNum + 1  
			End		
		End
		Set @NbrCartons = @NbrCartons - 1
	End
	Fetch Next From csr_ContainerBuild2 Into @InvtId, @QtyPacked, @SCHeight, @SCHeightUOM, @SCLen, @SCLenUOM, @SCVolume, @SCVolumeUOM, @SCWeight, @SCWeightUOM, @SCWidth, @SCWidthUOM, @NbrCartons, @QtyBreakPacks, @LineRef,
	@UnitDesc, @InnerPackQty, @FullCartonQty, @WeightDecPl
 	Set @Cont_Status = @@Fetch_Status
End 
Close csr_WhseLocTable
Deallocate csr_WhseLocTable


-- Create the free form containers
If @NbrFreeFormContainers > 0 Begin
  Declare csr_FreeForm Cursor For Select LineId, Min(NbrContainers) From #FreeFormContainerCount
    Group By LineId Having Min(NbrContainers) > 0
  Open csr_FreeForm
  Fetch Next From csr_FreeForm Into @LineId, @NbrLineFreeFormContainers
  While (@@Fetch_Status = 0) Begin

    While @NbrLineFreeFormContainers > 0 Begin
      Set @NextContainerId = Right('0000000000' + Cast(Cast(@NextContainerId As int) + 1 As varchar(10)),10)
      Exec EDCalcMod10ChkDigit @NextContainerId, @UCC128 OUTPUT -- get cartons UCC128 number
      Insert into EDContainer values(0,' ',0,' ',0,@NextContainerId,@CpnyId,@Crtd_Date,@Crtd_Prog,@Crtd_User,0,0,0,@CuryEffDate,0,0,@CuryId,0,0,@CuryMultDiv,0,0,@CuryRate,@CuryRateType,0,0,0,0,0,0,0,0,'',0,'01/01/1900',0,0,'',
        @Lupd_Date,@Lupd_Prog,@Lupd_User,0,0,0,'PP',0,' ',' ',0,0,0,0,'01/01/1900','01/01/1900',0,0,' ',' ',@ShipperId,' ',0,'01/01/1900',' ',0,0,0,' ',0,0,0,' ',@UCC128,' ','01/01/1900',' ',' ',' ',0,0,' ',' ','01/01/1900',0,'',0,
        '',0,'',DEFAULT)
      Set @LastFreeFormInvtId = ''
      Set @FreeFormLineNbr = -32768
      Declare csr_FreeFormInvtId Cursor For Select ShipperInvtId, ShipperQty, QtyPerContainer, WhseLoc, LotSerNbr, ShipperLineRef, ShipperUnit From #FreeForm Where LineId = @LineId And ShipperQty > 0 For Update
      Open csr_FreeFormInvtId
      Fetch Next From csr_FreeFormInvtId Into @FreeFormInvtId, @FreeFormShipperQty, @FreeFormQtyPerContainer, @FreeFormWhseLoc, @FreeFormLotSerNbr, @FreeFormShipperLineRef, @FreeFormShipperUnit
      While (@@Fetch_Status = 0) Begin
        If @LastFreeFormInvtId <> @FreeFormInvtId Begin
          Set @LastFreeFormInvtId = @FreeFormInvtId
          Set @FreeFormQtyRemain = @FreeFormQtyPerContainer
        End 
        Set @FreeFormQtyToAssign = Case When @FreeFormShipperQty >= @FreeFormQtyRemain Then @FreeFormQtyRemain
                                            Else @FreeFormShipperQty End
        If @FreeFormQtyToAssign > 0 Begin 
          Set @FreeFormLineNbr = @FreeFormLineNbr + 1
          Set @FreeFormQtyRemain = @FreeFormQtyRemain - @FreeFormQtyToAssign
          Update #FreeForm Set ShipperQty = ShipperQty - @FreeFormQtyToAssign Where Current Of csr_FreeFormInvtId
          If @TrackDetail = 1 
            Insert Into EDContainerDet Select @NextContainerId 'ContainerID', @CpnyId 'CpnyID',
            @Crtd_Date 'Crtd_DateTime', @Crtd_Prog 'Crtd_Prog', @Crtd_User 'Crtd_User', 
            @FreeFormInvtId 'InvtID', @FreeFormLineNbr 'LineNbr', @FreeFormShipperLineRef 'LineRef', @FreeFormLotSerNbr 'LotSerNbr', 
            @Lupd_date 'Lupd_DateTime', @Lupd_Prog 'Lupd_Prog', @Lupd_User 'Lupd_User', 0 'NoteID',
            @FreeFormQtyToAssign 'QtyPicked', @FreeFormQtyToAssign 'QtyShipped', ' ' 'S4Future01', 
            ' ' 'S4Future02', 0 'S4Future03', 0 'S4Future04', 0 'S4Future05', 0 'S4Future06', 
            '01/01/1900' 'S4Future07', '01/01/1900' 'S4Future08', 0 'S4Future09', 0 'S4Future10', 
            ' ' 'S4Future11', ' ' 'S4Future12', @ShipperId 'ShipperID', @FreeFormShipperUnit 'UOM', ' ' 'User1',
            '01/01/1900' 'User10', ' ' 'User2', ' ' 'User3', ' ' 'User4', 0 'User5', 0 'User6', 
            ' ' 'User7', ' ' 'User8', '01/01/1900' 'User9', @FreeFormWhseloc 'WhseLoc', NULL 'tstamp'
        End
        Fetch Next From csr_FreeFormInvtId Into @FreeFormInvtId, @FreeFormShipperQty, @FreeFormQtyPerContainer, @FreeFormWhseLoc, @FreeFormLotSerNbr, @FreeFormShipperLineRef, @FreeFormShipperUnit
      End
      Close csr_FreeFormInvtId
      Deallocate csr_FreeFormInvtId
      Set @NbrLineFreeFormContainers = @NbrLineFreeFormContainers - 1
    End
    Fetch Next From csr_FreeForm Into @LineId, @NbrLineFreeFormContainers
  End 
  Close csr_FreeForm
  Deallocate csr_FreeForm
End


-- Check to see if qtyship needs to be changed on any soshiplot/soshipline records due to free form containers
Update SOShipLot Set QtyShip = QtyShip - ShipperQty From #FreeForm Inner Join SOShipLot On
SOShipLot.LineRef = #FreeForm.ShipperLineRef And SOShipLot.WhseLoc = #FreeForm.WhseLoc And
SOShipLot.LotSerNbr = #FreeForm.LotSerNbr Where SOShipLot.CpnyId = @CpnyId And 
SOShipLot.ShipperId = @ShipperId And #FreeForm.ShipperQty > 0
If @@Rowcount > 0 Begin -- This line must not be separated from the line above it or @@rowcount will not work
  Update SOShipLine Set QtyShip = (Select Sum(QtyShip) From SOShipLot Where SOShipLine.CpnyId =
  SOShipLot.Cpnyid And SOShipLine.ShipperId = SOShipLot.ShipperId And SOShipLine.LineRef = 
  SOShipLot.LineRef) Where SOShipLine.CpnyId = @CpnyId And SOShipLine.ShipperId = @ShipperId
  Set @ChangeMade = 1
End  

-- Check to see if qtyship needs to be changed on any soshiplot/soshipline records due to standard cartons
Select @ChangedLineCount = Count(*) From #ContainerBuild Where QtyPacked <> QtyShip
If @ChangedLineCount > 0  Begin
  -- Since we did not ship the full qty on one or more lines we must update the 
  -- soshipline & soshiplot records.
  Update SOShipLot Set QtyShip = QtyShip - (Select QtyShip - QtyPacked From #ContainerBuild
    Where LineRef = SOShipLot.LineRef And WhseLoc = SOShipLot.WhseLoc And LotSerNbr = 
    SOShipLot.LotSerNbr) Where CpnyId = @CpnyId And ShipperId = @ShipperId 
    And LineRef In (Select LineRef From #ContainerBuild Where QtyPacked <> QtyShip) And 
    QtyShip = (Select Max(QtyShip) From SOShipLot A Where A.CpnyId = SOShipLot.CpnyId And 
    A.ShipperId = SOShipLot.ShipperId And A.LineRef = SOShipLot.LineRef And A.WhseLoc = 
    SOShipLot.WhseLoc And A.LotSerNbr = SOShipLot.LotSerNbr)

  Update SOShipLine Set QtyShip = (Select Sum(QtyShip)From SOShipLot Where SOShipLine.CpnyId = 
    SOShipLot.CpnyId And SOShipLine.ShipperId = SOShipLot.ShipperId And SOShipLine.LineRef = 
    SOShipLot.LineRef) Where CpnyId = @CpnyId And ShipperId = @ShipperId
  Set @ChangeMade = 1
End 

Update SOShipHeader Set TotBoxes = @TotalNbrContainers Where CpnyId = @CpnyId And ShipperId = @ShipperId

Close csr_ContainerBuild2
Deallocate csr_ContainerBuild
Deallocate csr_ContainerBuild2
Drop Table #ContainerBuild
Drop Table #WhseLocTable
