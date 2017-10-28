 /****** Object:  Stored Procedure dbo.ARDoc_Bat_Cust_Type_Ref2    Script Date: 4/7/98 12:30:32 PM ******/
CREATE PROCEDURE ARDoc_Bat_Cust_Type_Ref2 @parm1 varchar (10), @parm2 varchar (15), @parm3 varchar ( 2), @parm4 varchar ( 10) as
SELECT *
  FROM ARDoc
 WHERE CpnyId = @parm1
   AND CustId = @parm2
   AND DocType = @parm3
   AND RefNbr = @parm4
   AND Rlsed = 1
 ORDER BY BatNbr, CustId, DocType, RefNbr


