CREATE PROCEDURE [dbo].[SSP_TermsID_Change]
@OldTermsID VARCHAR (2), @NewTermsID VARCHAR (2)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_TermsID_Change] TO [MSDSL]
    AS [dbo];

