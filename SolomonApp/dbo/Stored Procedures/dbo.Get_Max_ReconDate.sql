 /****** Object:  Stored Procedure dbo.Get_Max_ReconDate   Script Date: 9/6/01 12:49:19 PM ******/
CREATE PROCEDURE Get_Max_ReconDate
@CpnyID varchar ( 10),
@BankAcct varchar(10),
@BankSub varchar ( 24)

AS

SELECT MAX(ReconDate)
  FROM BankRec
 WHERE CpnyID = @CpnyID
   AND BankAcct = @BankAcct
   AND BankSub = @BankSub


