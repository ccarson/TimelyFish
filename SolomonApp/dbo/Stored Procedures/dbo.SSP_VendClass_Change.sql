CREATE PROCEDURE [dbo].[SSP_VendClass_Change]
@OldClassID VARCHAR (10), @NewClassID VARCHAR (10)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_VendClass_Change] TO [MSDSL]
    AS [dbo];

