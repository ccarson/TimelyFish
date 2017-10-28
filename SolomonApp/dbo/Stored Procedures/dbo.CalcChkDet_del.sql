 CREATE PROC CalcChkDet_del
@EmpID   varchar(10),
@ChkSeq  varchar(2),
@EDType  varchar(1),
@WrkLocId varchar(6),
@EDid    varchar(10)
AS
DELETE CalcChkDet
WHERE EmpID=@EmpID AND ChkSeq=@ChkSeq AND EDType=@EDType AND WrkLocId=@WrkLocId AND EarnDedID=@EDid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChkDet_del] TO [MSDSL]
    AS [dbo];

