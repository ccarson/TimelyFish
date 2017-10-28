 Create Proc EDSite_940ConvMeth @SiteId varchar(10) As
Select ConvMeth From EDSite Where SiteId = @SiteId And Trans = '940'


