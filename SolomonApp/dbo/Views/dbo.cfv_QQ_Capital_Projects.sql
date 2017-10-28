
CREATE VIEW 
    [dbo].[cfv_QQ_Capital_Projects] 
AS

SELECT DISTINCT
    Account             =   pjTran.gl_acct
  , Project             =   pjTran.project
  , Task                =   pjTran.pjt_entity
  , TranDetailNum       =   pjtran.detail_num
  , SubAccount          =   pjTran.gl_subacct
  , SubAccountDesc      =   subAcct.Descr
  , TransactionDate     =   pjtran.trans_date
  , Amount              =   pjtran.amount
  , Units               =   pjtran.units
  , TranComment         =   pjTran.tr_comment
  , Batch               =   pjTran.tr_id04
  , BatchCreator        =   pjTran.Crtd_User
  , ReferenceNumber     =   pjTran.voucher_num
  , PONumber            =   apTran.PONbr
  , Vendor              =   vendor.Name
  , VendorID            =   apTran.VendID
  , PeriodToPost        =   glTran.PerPost
  , Module              =   glTran.Module
  , InvoiceNumber       =   apDoc.InvcNbr

FROM   
    dbo.PJTran AS pjTran 
INNER JOIN 
    dbo.PJPROJ AS pjProj 
        ON pjtran.project = pjproj.project
LEFT OUTER JOIN 
    dbo.GLTran AS glTran
        ON pjTran.tr_id04           =   glTran.BatNbr 
            AND pjTran.project      =   glTran.ProjectID
            AND pjTran.trans_date   =   glTran.TranDate
            AND pjTran.tr_comment   =   glTran.TranDesc
            AND pjTran.voucher_num  =   glTran.RefNbr 
LEFT OUTER JOIN 
    dbo.Vendor AS Vendor 
        ON pjtran.vendor_num = Vendor.VendId
LEFT OUTER JOIN 
    dbo.APTran AS apTran 
        ON pjTran.tr_id04           =   apTran.BatNbr 
            AND pjTran.project      =   apTran.ProjectID
            AND pjTran.amount       =   apTran.TranAmt
            AND pjTran.trans_date   =   apTran.TranDate
            AND pjTran.tr_comment   =   apTran.TranDesc
            AND pjTran.vendor_num   =   apTran.VendId
            AND pjTran.voucher_num  =   apTran.RefNbr 
LEFT OUTER JOIN 
    dbo.APDoc AS APDoc 
        ON apTran.BatNbr = apDoc.BatNbr
            AND apTran.RefNbr = apDoc.RefNbr
LEFT OUTER JOIN 
    dbo.SubAcct AS subAcct 
        ON pjTran.gl_subacct = subAcct.Sub

WHERE pjtran.project like 'CP%'  and pjtran.crtd_datetime > '2012/12/31' 

