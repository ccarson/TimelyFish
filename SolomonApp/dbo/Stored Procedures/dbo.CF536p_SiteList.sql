
CREATE PROCEDURE CF536p_SiteList
AS 
select distinct c.ContactID, c.ContactName
	FROM cftPigGroup pg
	JOIN cftContact c ON pg.SiteContactID = c.Contactid
	WHERE pg.CF03 = ''
	AND pg.PGStatusID Not IN('I','X')
	ORDER BY c.ContactName


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF536p_SiteList] TO [MSDSL]
    AS [dbo];

