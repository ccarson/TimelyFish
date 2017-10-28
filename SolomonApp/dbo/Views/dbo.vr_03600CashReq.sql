 

create view vr_03600CashReq as 
select APDoc.CuryId, Vendor.Name, Vendor.ClassID, vstatus = Vendor.Status, APDoc.CpnyID, APDoc.DiscBal, APDoc.CuryDiscBal, APDoc.DiscDate, 
       APDoc.DocBal, APDoc.CuryDocBal, APDoc.DocClass, APDoc.DocType, APDoc.DueDate, APDoc.InvcDate, 
       APDoc.InvcNbr, APDoc.MasterDocNbr, APDoc.OpenDoc, APDoc.OrigDocAmt, APDoc.CuryOrigDocAmt,
       APDoc.S4Future11,
       PayDate = case when APDoc.PayDate <> 1/1/1900 then APDoc.PayDate 
                 else isnull((select d.paydate from apdoc d where 
                              d.VendId = APDoc.VendId and
                              d.CpnyID = APDoc.CpnyID and
                              d.RefNbr = APDoc.ApplyRefNbr and
                              d.DocClass = 'N' and
                              d.OpenDoc = 1 and
                              d.Rlsed = 1 and 
                              d.Selected = 0), 1/1/1900) end,

       APDoc.RefNbr, APDoc.Rlsed, dstatus = APDoc.Status, APDoc.VendId, RptCompany.CpnyName, RptCompany.RI_ID,
       Vendor.User1 as VendorUser1, Vendor.User2 as VendorUser2, Vendor.User3 as VendorUser3, Vendor.User4 as VendorUser4,
       Vendor.User5 as VendorUser5, Vendor.User6 as VendorUser6, Vendor.User7 as VendorUser7, Vendor.User8 as VendorUser8,
       APDoc.User1 as APDocUser1, APDoc.User2 as APDocUser2, APDoc.User3 as APDocUser3, APDoc.User4 as APDocUser4, 
       APDoc.User5 as APDocUser5, APDoc.User6 as APDocUser6, APDoc.User7 as APDocUser7, APDoc.User8 as APDocUser8, APDoc.BWAmt as BWAmt, APDoc.CuryBWAmt as CuryBWAmt
from vendor, apdoc, rptcompany
where vendor.vendid = apdoc.vendid and apdoc.cpnyid = rptcompany.cpnyid
 
