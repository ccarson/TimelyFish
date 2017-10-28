CREATE PROCEDURE [dbo].[SSP_WhseLoc_Combiner]
@OLDLOC1 VARCHAR (130), @OLDLOC2 VARCHAR (10), @NEWLOC VARCHAR (10)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_WhseLoc_Combiner] TO [MSDSL]
    AS [dbo];

