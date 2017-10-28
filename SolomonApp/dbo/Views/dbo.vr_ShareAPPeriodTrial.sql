 

--APPTABLE
--USETHISSYNTAX

/****** 10/13/98 DCM 		     Added s.balance * -1 to account for VC's ******/
/****** 11/2/98  DCM    TR A-002370  Added SELECT j.adjamt... when v.ord = 1 so report will display pp's minus check amount ***/
/****** 4/9/99   DCM    DE 205868    Commented out case for Balance for PP's  *******/


CREATE VIEW vr_ShareAPPeriodTrial AS

SELECT l.Period, s.ParentPerClosed, v.*, 
	Balance = CASE 
		WHEN v.ord = 1 THEN s.balance --(CASE v.DocType 
                                --WHEN 'PP' 
                              --then s.balance + isnull((SELECT j.adjamt from apadjust j where v.refnbr = j.adjdrefnbr and v.doctype = "PP"),0)
                               --else    s.Balance 
                              --end)  
		WHEN v.ord = 2 AND ParentPerClosed = "000000" and s.parenttype <> 'AD' and s.balance < 0 Then s.balance   * (Case v.DocType When "VC" Then -1 Else 1 END)
		ELSE 0 END, 
	CurrBalance = CASE v.Ord WHEN 1 THEN s.CurrBalance ELSE 0 END, s.ParentOrd	
FROM vr_ShareAPVendorDetail v, vr_SharePeriodList l, vr_ShareAPSum s
WHERE v.PerPost <= l.Period AND l.Period = s.Period AND v.Parent = s.Parent AND v.ParentType = s.ParentType AND
	((l.Period = s.ParentPerClosed OR l.Period = v.PerPost) OR (v.ParentType = "AD" AND s.Balance <> 0) OR (v.Ord = 1 AND 
	v.ParentType <> "AD") OR (v.Ord = 2 AND v.ParentType <> "AD") OR (v.Ord = 3 AND v.ParentType <> "AD"))

 
