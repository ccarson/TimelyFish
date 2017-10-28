 Create Procedure APDoc_DocTyp3 @parm1 varchar ( 255), @parm2 varchar ( 4), @parm3 varchar ( 10) as
Select CuryDiscBal,CuryDiscTkn,CuryDocBal,CuryPmtAmt,DiscBal,DiscDate,DiscTkn,
DocBal,DocDate,DocType,DueDate,InvcDate,InvcNbr,OrigDocAmt,PayDate,PmtAmt,PONbr,
RefNbr, Selected, APDoc.Status, APDoc.VendID,MultiChk, Name, Vendor.Status
from APDoc
	left outer join Vendor
		on APDoc.VendId = Vendor.VendId
where
APDoc.DocType  in ('AC', 'AD', 'VO')
and APDoc.Status in ('A', @parm1)
and APDoc.CuryId = @parm2
and APDoc.RefNbr  like  @parm3
and APDoc.OpenDoc  =  1
and APDoc.Rlsed    =  1
and APDoc.Selected = 0
Order by RefNbr, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_DocTyp3] TO [MSDSL]
    AS [dbo];

