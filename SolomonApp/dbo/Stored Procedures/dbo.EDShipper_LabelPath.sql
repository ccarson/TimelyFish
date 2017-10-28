 CREATE Proc EDShipper_LabelPath @CpnyId varchar(10), @ShipperId varchar(15) As
Declare @Path varchar(255)
Select @Path = B.LabelDBPath From SOShipHeader A, EDSiteExt B Where A.CpnyId = @CpnyId And
A.ShipperId = @ShipperId And A.SiteId = B.SiteId
If LTrim(RTrim(@Path)) = ''
  Select @Path = LabelDBPath From ANSetup
Select @Path



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipper_LabelPath] TO [MSDSL]
    AS [dbo];

