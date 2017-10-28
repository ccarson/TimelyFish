 

CREATE VIEW vi_SiteWithInvtFlag
AS
SELECT  
	ExistingSiteFlag = ' ',
	Invtid = null,
	Site.*

 FROM Site

union

SELECT  
	ExistingSiteFlag = 
		CASE WHEN ItemSite.SiteID IS NULL
			THEN SPACE (1) 
		ELSE
			'X'
		END,
	  ItemSite.Invtid,
	  Site.*

 FROM Site
 left outer join ItemSite
   on Site.SiteID = ItemSite.SiteID


 
