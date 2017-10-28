

CREATE VIEW 
	stage.vw_Farm
AS
SELECT      
	FarmKey			=	ISNULL( f.FarmKey, 0 ) 
  , SourceID        =   sites.site_id
  , IsActive        =   sites.active
  , FarmNumber      =   CAST( farms.farm_number AS nvarchar(10) )
  , FarmName        =   CAST( farms.farm_name   AS nvarchar(30) )
  , TattooLength    =   farms.tattoo_length
  , MainSiteId      =   farms.main_site_id
  , FarmGUID        =   farms.farm_guid
  , SourceGUID		=   farms.SourceGUID
FROM            
    stage.SITES AS sites
INNER JOIN
    stage.FARMS AS farms 
        ON farms.site_id = sites.site_id
LEFT OUTER JOIN
	dimension.Farm AS f 
		ON f.SourceID = sites.site_id 
where farms.main_site_id > 0 and farm_name not like 'Farm 1'