 Create Proc EDSite_ShipNow @SiteId varchar(10) As
Select S4Future09 From Site Where SiteId = @SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSite_ShipNow] TO [MSDSL]
    AS [dbo];

