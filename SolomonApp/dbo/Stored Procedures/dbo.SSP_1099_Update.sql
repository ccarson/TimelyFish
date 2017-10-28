CREATE PROCEDURE [dbo].[SSP_1099_Update]
@VendID VARCHAR (10), @BoxNbr VARCHAR (2), @UpdateAll SMALLINT
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_1099_Update] TO [MSDSL]
    AS [dbo];

