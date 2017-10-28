Create View cfvPigGroup_Open_Multiple 
AS
Select distinct groups.SiteContactID, st.SiteID, groups.BarnNbr, groups.RoomNbr, p.PigGroupID, p.PGStatusID, p.Description, p.EstStartDate  FROM 
            (Select pg.SiteContactID, pg.BarnNbr, RoomNbr = IsNull(pgr.RoomNbr,''), pg.PGStatusID
                        FROM cftPigGroup pg
                        LEFT JOIN cftPigGroupRoom pgr on pg.PigGroupID = pgr.PigGroupID  
                        WHERE PGStatusID <> 'I'
                        GROUP BY pg.SiteContactID, pg.barnnbr, pgr.Roomnbr, pg.PGStatusID
                        having count(*) > 1) AS groups
            LEFT JOIN cftPigGroup p ON groups.SiteContactID = p.SiteContactID AND groups.BarnNbr = p.BarnNbr 
            LEFT JOIN cftPigGroupRoom pgr ON p.PigGroupID = pgr.PigGroupID AND groups.RoomNbr=pgr.RoomNbr
            LEFT JOIN cftSite st ON groups.SiteContactID=st.ContactID
	    Where p.PGStatusID<>'I' AND ((p.PGStatusID='F' AND groups.PGStatusID='A') OR (p.PGStatusID=groups.PGStatusID))





 