 Create Proc EDVInbound_810880ConvMeth @VendId varchar(15) As
Select ConvMeth From EDVInbound Where VendId = @VendId And Trans In ('810','880')


