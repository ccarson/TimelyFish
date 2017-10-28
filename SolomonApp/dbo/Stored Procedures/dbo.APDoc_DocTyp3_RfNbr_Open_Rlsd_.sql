 --- DCR added cpnyid 4/13/98
/****** Object:  Stored Procedure dbo.APDoc_DocTyp3_RfNbr_Open_Rlsd_    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_DocTyp3_RfNbr_Open_Rlsd_ @parm1 varchar ( 255), @parm2 varchar ( 10), @parm3 varchar(10) as  
Select APDoc.ApplyRefNbr, APDoc.Batnbr, APDoc.CuryDiscBal, APDoc.CuryDiscTkn, APDoc.CuryDocBal, APDoc.CuryId, APDoc.CuryMultDiv,  
APDoc.CuryPmtAmt, APDoc.CuryRate, APDoc.CuryRateType, APDoc.DiscBal, APDoc.DiscDate, APDoc.DiscTkn,  
APDoc.DocBal, APDoc.DocDate, APDoc.DocType, APDoc.DueDate, APDoc.InvcDate,  
APDoc.InvcNbr, APDoc.OrigDocAmt, APDoc.PayDate, APDoc.PmtAmt, APDoc.PmtMethod, APDoc.PONbr,  
APdoc.RefNbr, APDoc.Selected, APDoc.Status, APDoc.VendID, APDoc.CpnyID, APDoc.S4Future11, APDoc.MasterDocNbr, APDoc.Terms, APDoc.VendName, APDoc.CuryBWAmt, Vendor.MultiChk,  
Vendor.Name, Vendor.PmtMethod, Vendor.Status, Vendor.ReqBkupWthld
from APDoc LEFT OUTER JOIN Vendor ON APDoc.VendId = Vendor.VendId  
where  
APDoc.DocType  in ('AC', 'AD', 'VO', 'PP')  
and APDoc.Status in ('A', @parm1)  
and APDoc.CpnyID like @parm2  
and APDoc.RefNbr  like  @parm3  
and APDoc.OpenDoc  =  1  
and APDoc.Rlsed    =  1  
and APDoc.Selected = 0  
and COALESCE(Vendor.Status, 'A') <> 'H'  
Order by APDoc.RefNbr, APDoc.DocType  



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_DocTyp3_RfNbr_Open_Rlsd_] TO [MSDSL]
    AS [dbo];

