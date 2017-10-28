 CREATE PROC PRTran_BatNbr_Emp_LineNbr
@BatNbr   varchar(10),
@EmpID    varchar(10),
@LineNbr1 smallint,
@LineNbr2 smallint
AS
SELECT *
FROM PRTran
WHERE BatNbr=@BatNbr AND EmpID=@EmpID
      AND LineNbr BETWEEN @LineNbr1 AND @LineNbr2


