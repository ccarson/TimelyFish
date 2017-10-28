CREATE PROCEDURE [dbo].[SSP_WhseLoc_Change]
@OldLoc VARCHAR (10), @NewLoc VARCHAR (10)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_WhseLoc_Change] TO [MSDSL]
    AS [dbo];

