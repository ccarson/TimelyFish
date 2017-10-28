 CREATE PROCEDURE EDRecalcBolInfo  @BOLNbr varchar(20) AS
Declare @TotWt float, @WTUOM varchar(6), @Volume float, @VolumeUOM varchar(6)
Declare @NbrofContainers int, @PackMethod varchar(2), @ShpWeight float
Declare @SCAC varchar(5)
--use max on UOM fields because it doesnt matter which UOM we get
Select @TotWt = Sum(A.Weight), @WTUOM = Max(A.WeightUOM), @Volume = Sum(A.Volume), @VolumeUOM = Max(A.VolumeUOM) From EDContainer A, EDShipTicket B Where B.BolNbr = @BOLNbr And A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId
Select @NbrofContainers = Count(*), @PackMethod = Min(A.PackMethod), @ShpWeight = Sum(A.ShpWeight) From EDContainer A, EDShipTicket B Where B.BolNbr = @BOLNbr And A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId And A.TareFlag = 0
Select @SCAC = B.SCAC From EDShipment A, ShipVia B where A.ViaCode = B.ShipViaId and A.BOLNbr = @BOLNbr
 -- If any of these are null, it gets replaced with a space or zero
Set @SCAC =  isnull(@SCAC, ' ')
Set @TotWt = isnull(@TotWt, 0)
Set @WTUOM = isnull(@WTUOM,' ')
Set @Volume = isnull(@Volume, 0)
Set @VolumeUOM = isnull(@VolumeUOM, ' ')
Set @NbrofContainers = isnull(@NbrofContainers, 0)
Set @PackMethod = isnull(@PackMethod, ' ')
Set @ShpWeight =  isnull(@ShpWeight, 0)

Update EDShipment set SCAC = @SCAC, Weight = @TotWt, WeightUOM = @WTUOM, Volume = @Volume,
VolumeUOM = @VolumeUOM, NbrContainer = @NbrofContainers,PackMethod = @PackMethod,
ShpWeight = @ShpWeight
Where BOLNbr = @BOLNbr


