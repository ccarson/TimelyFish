 /****** Object:  Stored Procedure dbo.Check_Valid_Refnbr_Combo    Script Date: 11/29/00 12:30:33 PM ******/
CREATE PROC Check_Valid_Refnbr_Combo @parm1 varchar(15), @parm2 varchar (2), @parm3 varchar(10) AS
SELECT *
  FROM ARDoc
 WHERE CustID = @parm1
   AND Doctype = @parm2
   AND refnbr = @parm3


