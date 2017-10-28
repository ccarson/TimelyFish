CREATE PROCEDURE [dbo].[SSP_Task_Change]
@OldTask VARCHAR (24), @NewTask VARCHAR (24)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_Task_Change] TO [MSDSL]
    AS [dbo];

