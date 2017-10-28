-- Author: TJONES
-- Created: 1/26/05
-- Used in CF15000.EXE
CREATE PROCEDURE cfpContactNote_ContactID_NID
	@ContactID varchar(6),
	@NID varchar(10)
	AS 
	SELECT * FROM cftContactNote
	WHERE SiteContactID = @ContactID
	AND NID LIKE @NID
	ORDER BY NID DESC

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpContactNote_ContactID_NID] TO [MSDSL]
    AS [dbo];

