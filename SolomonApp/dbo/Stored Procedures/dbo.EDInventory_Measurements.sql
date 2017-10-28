 CREATE Proc EDInventory_Measurements @InvtId varchar(30) As
Select Case B.PackMethod When 'SC' Then B.Pack Else Cast(0 As Smallint) End  'Pack',
Case B.PackMethod When 'SC' Then B.PackSize Else Cast(0 As Smallint) End  'PackSize',
Case B.PackMethod When 'SC' Then B.PackUOM Else Cast (' ' As char(5)) End 'PackUOM' , B.Density,
B.DensityUOM, B.Depth, B.DepthUOM, B.Diameter, B.DiameterUOM, B.Gauge, B.GaugeUOM, B.Height,
B.HeightUOM, B.Len, B.LenUOM, B.Volume, B.VolUOM, B.Weight, B.WeightUOM, B.Width, B.WidthUOM,
A.Size, A.Color From Inventory A Inner Join InventoryADG B On A.InvtId = B.InvtId
Where A.InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_Measurements] TO [MSDSL]
    AS [dbo];

