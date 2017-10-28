 CREATE PROCEDURE p08990CountDocs @Batnbr VARCHAR (10) AS

SELECT NumOfDocs = Convert(float,Count(*))
  FROM ARDoc
 WHERE BatNbr = @Batnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CountDocs] TO [MSDSL]
    AS [dbo];

