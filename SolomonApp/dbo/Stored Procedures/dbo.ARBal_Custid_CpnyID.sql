 /****** Object:  Stored Procedure dbo.ARBal_Custid_CpnyID    Script Date: 4/7/98 12:30:32 PM ******/
CREATE PROC ARBal_Custid_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 15) AS
SELECT *
  FROM AR_Balances
 WHERE CpnyID = @parm1
   AND CustID = @parm2
 ORDER BY CpnyID, CustID


