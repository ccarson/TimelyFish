 /****** Object:  Stored Procedure dbo.vb08240_Max_perappl    Script Date: 11/29/00 12:30:33 PM ******/
CREATE PROC vb08240_Max_perappl @parm1 varchar(15), @parm2 varchar (2), @parm3 varchar(10) AS
SELECT MAX(perappl)
  FROM aradjust
 WHERE CustID = @parm1
   AND AdjgDoctype = @parm2
   AND Adjgrefnbr = @parm3


