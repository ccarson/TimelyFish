 CREATE PROCEDURE Customer_ARdoc_Batnbr  @parm1  AS VARCHAR (10), @parm2 AS VARCHAR (15) AS
SELECT DISTINCT customer.*
  FROM ardoc, customer
 WHERE ardoc.custid = customer.custid AND ardoc.batnbr LIKE @parm1
   AND ardoc.custid LIKE @parm2
 ORDER BY customer.custid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_ARdoc_Batnbr] TO [MSDSL]
    AS [dbo];

