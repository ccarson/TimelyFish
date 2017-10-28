 CREATE PROC CalcChkDet_Emp_Seq_EDTp_Id_
@EmpID   varchar(10),
@ChkSeq  varchar(2),
@EDType  varchar(1),
@WrkLocId varchar(6),
@EDid    varchar(10)
AS
SELECT *
FROM CalcChkDet
WHERE EmpID=@EmpID AND ChkSeq=@ChkSeq AND EDType=@EDType AND WrkLocId=@WrkLocId AND EarnDedID=@EDid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChkDet_Emp_Seq_EDTp_Id_] TO [MSDSL]
    AS [dbo];

