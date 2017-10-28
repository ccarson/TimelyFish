 

CREATE VIEW PJvCn010

AS 

Select 
'perpost' = case when APDoc.perpost is null then APDocRet.perpost
                        else APDoc.perpost end,
'Rlsed' = case when APDoc.Rlsed is null then APDocRet.rlsed
                        else APDoc.rlsed end,
'Cpnyid' = case when APDoc.Cpnyid is null then APDocRet.cpnyid
                        else APDoc.cpnyid end,
'Vendid' = case when APDoc.Vendid is null then APDocRet.Vendid
                        else APDoc.Vendid end,
'InvcDate' = case when APDoc.InvcDate is null then APDocRet.InvcDate
                        else APDoc.InvcDate end,
'InvcNbr' = case when APDoc.InvcNbr is null then APDocRet.InvcNbr
                        else APDoc.InvcNbr end,
'Docbalance' = case when APDoc.DocBal is null then APDocRet.DocBal
                        else APDoc.DocBal end,
'RegInvcDate' = APDoc.InvcDate,
'RetInvcDate' = APDocRet.InvcDate,
'DocType' = APDoc.DocType,
'RetDocType' = APDocRet.DocType,
'DocBal' = APDoc.DocBal, 
'RetDocBal' = APDocRet.DocBal,
PJPAYHDR.project, PJPAYHDR.subcontract,
APDoc.DirectDeposit 
from  
    (PJPAYHDR PJPAYHDR LEFT OUTER JOIN APDoc APDocRet ON
        PJPAYHDR.batnbr = APDocRet.BatNbr AND
    PJPAYHDR.refnbr_ret = APDocRet.RefNbr)
     LEFT OUTER JOIN APDoc APDoc ON
        PJPAYHDR.batnbr = APDoc.BatNbr AND
    PJPAYHDR.refnbr = APDoc.RefNbr



 
