CREATE  VIEW dbo.cfv1099VendorAPTranDiff
AS

--*************************************************************
--	Purpose: 
--	Author: Eric Lind
--	Date: 
--	Usage:  Report 1099VendorAPTranDiff
--	
--*************************************************************


SELECT APTranAcct.VendId, APTranAcct.CpnyID, VendorBal.CurrentYear, APTranAcct.TransTotal

FROM

  (SELECT APDoc.VendId, APDoc_Check.CpnyID, Sum(APTran.CuryTranAmt) AS TransTotal, DatePart(yyyy, TranDate) AS [Year],  Vendor.Curr1099Yr

  FROM
    (((APDoc INNER JOIN (APAdjust INNER JOIN APDoc AS APDoc_Check ON (APAdjust.AdjgRefNbr = APDoc_Check.RefNbr) AND (APAdjust.AdjgDocType   = APDoc_Check.DocType)) 
             ON (APDoc.RefNbr = APAdjust.AdjdRefNbr) AND (APDoc.DocType = APAdjust.AdjdDocType))

   INNER JOIN APTran ON (APDoc.BatNbr = APTran.BatNbr) AND (APDoc.RefNbr = APTran.RefNbr) AND (APDoc.VendId = APTran.VendId))
   )
   INNER JOIN Vendor ON APDoc.VendId = Vendor.VendId

   WHERE APTran.Acct IN('71400','46220','71500','71700','67100','20400','20450','21300','44400','44410','44420','44430','44440','44450','44460','44470')
	AND DatePart(yyyy, TranDate) = Vendor.Curr1099Yr

GROUP BY APDoc.VendId, APDoc_Check.CpnyID, DatePart(yyyy, TranDate) , Vendor.Curr1099Yr) APTranAcct

JOIN
(SELECT AP_Balances.VendID, AP_Balances.CpnyID, Sum([CYBox00]+[CYBox01]+[CYbox02]+[cybox03]+[cybox04]+[cybox05]+[cybox06]+[cybox07]+[cybox08]+[cybox09]+[cybox10]) AS CurrentYear
FROM AP_Balances
GROUP BY AP_Balances.VendID, AP_Balances.CpnyID) VendorBal
ON (VendorBal.VendID = APTranAcct.VendID) AND (APTranAcct.CpnyID = VendorBal.CpnyID)

WHERE APTranAcct.TransTotal <> VendorBal.CurrentYear





