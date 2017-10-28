 /****** Object:  Stored Procedure dbo.Get_Max_StmtDate   Script Date: 9/6/01 12:49:19 PM ******/
CREATE PROCEDURE Get_Max_StmtDate
@CpnyID varchar ( 10),
@BankAcct varchar(10),
@BankSub varchar ( 24)

AS

SELECT MAX(StmtDate)
  FROM BankRec
 WHERE CpnyID = @CpnyID
   AND BankAcct = @BankAcct
   AND BankSub = @BankSub


