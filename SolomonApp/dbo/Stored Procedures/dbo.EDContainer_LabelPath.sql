 CREATE Proc EDContainer_LabelPath @ContainerId varchar(10) As
Declare @Path varchar(255)
Select @Path = C.LabelDBPath From EDContainer A, SOShipHeader B, EDSiteExt C
Where A.ContainerId = @ContainerId And A.CpnyId = B.CpnyId And A.ShipperId = B.ShipperId And
B.SiteId = C.SiteId
If LTrim(RTrim(@Path)) = ''
  Select @Path = LabelDBPath From ANSetup
Select @Path



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_LabelPath] TO [MSDSL]
    AS [dbo];

