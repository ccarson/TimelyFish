CREATE PROCEDURE [dbo].[SSP_VendClass_Combiner]
@OLDCLASS1 VARCHAR (10), @OLDCLASS2 VARCHAR (10), @NEWCLASS VARCHAR (10)
WITH ENCRYPTION
AS
BEGIN
--The script body was encrypted and cannot be reproduced here.
    RETURN
END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SSP_VendClass_Combiner] TO [MSDSL]
    AS [dbo];

