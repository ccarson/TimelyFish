 CREATE PROC CalcChk_Delete_EmpId @EmpId varchar(10) as
    delete d from CalcChk c, CalcChkDet d
     where c.EmpID    = @EmpID
       and c.CheckNbr <> ''
       and c.EmpId    = d.EmpId
       and c.ChkSeq   = d.ChkSeq

    delete CalcChk
     where EmpID    = @EmpID
       and CheckNbr <> ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CalcChk_Delete_EmpId] TO [MSDSL]
    AS [dbo];

