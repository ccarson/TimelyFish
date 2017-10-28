CREATE PROCEDURE [dbo].[SSP_VendID_Combiner]
@OLDVENDID1 VARCHAR (15), @OLDVENDID2 VARCHAR (15), @NEWVENDID VARCHAR (15)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_VendID_Combiner] TO [MSDSL]
    AS [dbo];

