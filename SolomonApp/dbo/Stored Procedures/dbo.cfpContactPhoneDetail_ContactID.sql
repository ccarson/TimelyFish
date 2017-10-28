-- Author: TJONES
-- Created: 1/26/05
-- Used in CF15000.EXE
CREATE PROCEDURE cfpContactPhoneDetail_ContactID
	@ContactID varchar(6)
	AS
	SELECT * FROM cfv_ContactPhoneDetail
	WHERE ContactID = @ContactID
	ORDER BY PhoneType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpContactPhoneDetail_ContactID] TO [MSDSL]
    AS [dbo];

