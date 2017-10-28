CREATE PROCEDURE [dbo].[SSP_VendID_Merge]
@OldVendor VARCHAR (15), @NewVendor VARCHAR (15)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_VendID_Merge] TO [MSDSL]
    AS [dbo];

