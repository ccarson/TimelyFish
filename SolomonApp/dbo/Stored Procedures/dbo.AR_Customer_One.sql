 /****** Object:  Stored Procedure dbo.AR_Customer_One    Script Date: 4/7/98 12:30:33 PM ******/
CREATE PROC AR_Customer_One @parm1 varchar(15) AS
SELECT *
  FROM Customer
 WHERE custid = @parm1
 ORDER BY custid


