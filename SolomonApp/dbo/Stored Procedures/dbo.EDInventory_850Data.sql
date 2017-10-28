 CREATE Proc EDInventory_850Data @InvtId varchar(30) As
Select Case B.PackMethod When 'SC' Then B.Pack Else Cast(0 As Smallint) End  'Pack',
Case B.PackMethod When 'SC' Then B.PackSize Else Cast(0 As Smallint) End  'PackSize',
Case B.PackMethod When 'SC' Then Cast(B.PackUOM As char(6)) Else Cast (' ' As char(6)) End 'PackUOM' , B.Density,
B.DensityUOM, B.Depth, B.DepthUOM, B.Diameter, B.DiameterUOM, B.Gauge, B.GaugeUOM, B.Height,
B.HeightUOM, B.Len, B.LenUOM, B.Volume, B.VolUOM, B.Weight, B.WeightUOM, B.Width, B.WidthUOM,
A.Size, A.Color, A.Style, A.InvtId, A.ClassId, A.Descr, A.User1, A.User2, A.User3, A.User4,
A.User5, A.User6, A.User7, A.User8, B.User1, B.User2, B.User3, B.User4, B.User5, B.User6,
B.User7, B.User8, B.User9, B.User10 From Inventory A Inner Join InventoryADG B On
A.InvtId = B.InvtId Where A.InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_850Data] TO [MSDSL]
    AS [dbo];

