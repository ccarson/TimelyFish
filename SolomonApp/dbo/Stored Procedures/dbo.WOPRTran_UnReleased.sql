 CREATE PROCEDURE WOPRTran_UnReleased

AS
   SELECT      *
   FROM     PRTran
   WHERE    EmpID LIKE '%' and
         TimeShtFlg = 1 and
         WrkLocID LIKE '%' and
         EarnDedID LIKE '%' and
         PC_Status = '1'
   ORDER BY    EmpID, TimeShtFlg, Rlsed, Paid, WrkLocID, EarnDedID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPRTran_UnReleased] TO [MSDSL]
    AS [dbo];

