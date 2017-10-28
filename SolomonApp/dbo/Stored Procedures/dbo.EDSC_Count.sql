 CREATE Procedure EDSC_Count @CpnyId varchar(10), @OrdNbr varchar(15), @InvtId varchar(30), @CustId varchar(15), @SiteId varchar(10), @QtyOrd float, @OrdUom varchar(6), @UnitMultDiv varchar(1), @CnvFact float As
Declare @AutoGenContainer smallint
Declare @TrackLevel varchar(10)
Declare @SingleContainer smallint
Declare @ContainerIDs smallint
Declare @Active smallint
Declare @Pack  smallint
Declare @PackSize smallint
Declare @PackUOM varchar(6)
Declare @NbrCartons int
Declare @StockDecpl smallint
Declare @InnerPack int
Declare @CartonQty int
Declare @PackMethod varchar(2)
Declare @StockUnitMultDiv varchar(1)
Declare @StockCnvFact float
Declare @ClassId varchar(6)
Declare @QtyOrdStkUnit varchar(6)
Declare @BreakCarton smallint

Set @NbrCartons = 0

-- check to make sure ASN is installed and active
Select @AutoGenContainer = AutoContainer, @Active = Active from ANSetup
If IsNull(@AutoGenContainer,9) = 9 Or @Active <> 1 Or @AutoGenContainer = 0
 Set @NbrCartons = 0

-- check to make sure that the site allows for the pregeneration of containers.
Select @ContainerIDs = ContainerIDs From EDSite Where SiteId = @SiteId
Set @ContainerIDs = IsNull(@ContainerIDs,0) -- convert nulls to zero
If @ContainerIDs <> 1
 Goto ExitProg

-- check to see if the customer tracks containers
Select @TrackLevel = ContTrackLevel From CustomerEDI where Custid = @CustId
If @TrackLevel = '' Or @TrackLevel = 'NCR'
 Goto ExitProg

-- If the order calls for a single container then just return the number 1
Select @SingleContainer = SingleContainer from EDSOHeader where CpnyId = @CpnyId and OrdNbr = @OrdNbr
Set @SingleContainer = IsNull(@SingleContainer,0)
If @SingleContainer = 1 Begin
  Set @NbrCartons = 1
  Goto ExitProg
End

-- Check to see if part is a standard carton part.
Select @PackMethod = A.PackMethod, @Pack = A.Pack, @BreakCarton = A.StdCartonBreak, @PackSize = A.PackSize, @PackUOM = A.PackUOM, @ClassId = B.ClassId From InventoryADG A Inner Join Inventory B On A.InvtId = B.InvtId Where A.InvtId = @InvtId
Set @PackMethod = IsNull(@PackMethod,'PP')
If @PackMethod <> 'SC'
  Goto ExitProg

Select @StockDecpl = DecPlQty from InSetup

If @PackUOM = @OrdUOM Begin
  Select @CartonQty = @Pack * @PackSize
  Select @InnerPack = @PackSize
End Else Begin
  Select @StockUnitMultDiv = MultDiv, @StockCnvFact = CnvFact From InUnit Where FromUnit = @PackUom And ToUnit = @OrdUom And InvtId In (@InvtId,'*') And ClassId In (@ClassId,'*') Order By UnitType
  If @@RowCount = 0
    Goto ExitProg
  If @StockUnitMultDiv = 'M' Begin
    Set @CartonQty = Round(@PackSize * @StockCnvFact * @Pack,@StockDecpl)
    Set @InnerPack = @PackSize * @StockCnvFact
  End Else Begin
    Set @CartonQty = Round((@PackSize / @StockCnvFact) * @Pack,@StockDecpl)
    Set @InnerPack = @PackSize / @StockCnvFact
  End
End

-- convert qty ord to stock UOM
If @UnitMultDiv = 'M'
  Select @QtyOrdStkUnit = Round(@QtyOrd * @CnvFact,@StockDecpl)
Else
  Select @QtyOrdStkUnit = Round(@QtyOrd/@CnvFact, @StockDecpl)

-- calculate the number of cartons
Set @NbrCartons = 0
While @QtyOrd >= @CartonQty And @CartonQty > 0 Begin
  Set @NbrCartons = @NbrCartons + 1
  Set @QtyOrd = @QtyOrd - @CartonQty
End

-- check to see if we need to add an additional carton for left over inner packs.
If @BreakCarton = 1 And @QtyOrd >= @InnerPack
  Set @NbrCartons = @NbrCartons + 1

ExitProg:
Select @NbrCartons


