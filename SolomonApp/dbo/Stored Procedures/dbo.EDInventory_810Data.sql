 CREATE Proc EDInventory_810Data @InvtId varchar(30) As
Select A.InvtId, A.ClassId, A.Color, A.Size, A.Descr, A.User1, A.User2, A.User3, A.User4, A.User5,
A.User6, A.User7, A.User8, B.BOLClass, B.ProdLineId, B.Pack, B.PackSize, Cast(B.PackUOM As char(6)), B.Density,
B.DensityUOM, B.Depth, B.DepthUOM, B.Diameter, B.DiameterUOM, B.Gauge, B.GaugeUOM, B.Height,
B.HeightUOM, B.Len, B.LenUOM, B.Volume, B.VolUOM, B.Weight, B.WeightUOM, B.Width, B.WidthUOM,
B.CategoryCode, B.CountryOrig, B.Style, B.User1, B.User2, B.User3,
B.User4, B.User5, B.User6, B.User7, B.User8, B.User9, B.User10,  C.BOLDesc, D.Descr, E.Descr
From Inventory A Inner Join InventoryADG B On A.InvtId = B.InvtId Left Outer Join EDBOLClass C
On B.BOLClass = C.BOLClass Left Outer Join ProductClass D On A.ClassId = D.ClassId
Left Outer Join ProductLine E On B.ProdLineId = E.ProdLineId Where A.InvtId = @InvtId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDInventory_810Data] TO [MSDSL]
    AS [dbo];

