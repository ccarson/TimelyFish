 CREATE PROCEDURE p08310_SalesPerHistory @SlsPerID VARCHAR (10) AS

SELECT COUNT(*)
  FROM SlsPerHist
 WHERE SlsperId = @SlsPerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08310_SalesPerHistory] TO [MSDSL]
    AS [dbo];

