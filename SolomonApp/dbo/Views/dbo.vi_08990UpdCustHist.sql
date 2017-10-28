 

CREATE VIEW vi_08990UpdCustHist AS

SELECT 	

v.FiscalYr, v.CustId, v.cpnyid, 
	PTDCrMemo00 = SUM(CASE WHEN (v.PerNbr = "01" AND v.updflag = "CM") THEN v.amount ELSE 0 END),
	PTDCrMemo01 = SUM(CASE WHEN (v.PerNbr = "02" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo02 = SUM(CASE WHEN (v.PerNbr = "03" AND v.updflag = "CM") THEN v.amount ELSE 0 END),
	PTDCrMemo03 = SUM(CASE WHEN (v.PerNbr = "04" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo04 = SUM(CASE WHEN (v.PerNbr = "05" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo05 = SUM(CASE WHEN (v.PerNbr = "06" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo06 = SUM(CASE WHEN (v.PerNbr = "07" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo07 = SUM(CASE WHEN (v.PerNbr = "08" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo08 = SUM(CASE WHEN (v.PerNbr = "09" AND v.updflag = "CM") THEN v.amount ELSE 0 END),
	PTDCrMemo09 = SUM(CASE WHEN (v.PerNbr = "10" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo10 = SUM(CASE WHEN (v.PerNbr = "11" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo11 = SUM(CASE WHEN (v.PerNbr = "12" AND v.updflag = "CM") THEN v.amount ELSE 0 END), 
	PTDCrMemo12 = SUM(CASE WHEN (v.PerNbr = "13" AND v.updflag = "CM") THEN v.amount ELSE 0 END),

	PTDDisc00 = SUM(CASE WHEN (v.PerNbr = "01" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc01 = SUM(CASE WHEN (v.PerNbr = "02" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDdisc02 = SUM(CASE WHEN (v.PerNbr = "03" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc03 = SUM(CASE WHEN (v.PerNbr = "04" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc04 = SUM(CASE WHEN (v.PerNbr = "05" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc05 = SUM(CASE WHEN (v.PerNbr = "06" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc06 = SUM(CASE WHEN (v.PerNbr = "07" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc07 = SUM(CASE WHEN (v.PerNbr = "08" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc08 = SUM(CASE WHEN (v.PerNbr = "09" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc09 = SUM(CASE WHEN (v.PerNbr = "10" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc10 = SUM(CASE WHEN (v.PerNbr = "11" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc11 = SUM(CASE WHEN (v.PerNbr = "12" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),
	PTDDisc12 = SUM(CASE WHEN (v.PerNbr = "13" AND (v.updflag ='CM' or v.updflag = 'PA'))
                               THEN v.discamt ELSE 0 END),

	PTDRcpt00 = SUM(CASE WHEN (v.PerNbr = "01" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt01 = SUM(CASE WHEN (v.PerNbr = "02" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt02 = SUM(CASE WHEN (v.PerNbr = "03" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt03 = SUM(CASE WHEN (v.PerNbr = "04" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt04 = SUM(CASE WHEN (v.PerNbr = "05" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt05 = SUM(CASE WHEN (v.PerNbr = "06" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt06 = SUM(CASE WHEN (v.PerNbr = "07" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt07 = SUM(CASE WHEN (v.PerNbr = "08" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt08 = SUM(CASE WHEN (v.PerNbr = "09" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt09 = SUM(CASE WHEN (v.PerNbr = "10" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt10 = SUM(CASE WHEN (v.PerNbr = "11" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt11 = SUM(CASE WHEN (v.PerNbr = "12" AND v.updflag = "PA") THEN v.amount ELSE 0 END),
	PTDRcpt12 = SUM(CASE WHEN (v.PerNbr = "13" AND v.updflag = "PA") THEN v.amount ELSE 0 END),

	YTDCrMemo = sum(Case when ((v.fiscalyr = (substring(arsetup.currpernbr, 1, 4))) 
	--and  (v.pernbr <= (substring(arsetup.currpernbr, 5, 2))) 
	and v.updflag = "CM") then v.amount else 0 end),


	YTDRcpt = sum(Case when ((v.fiscalyr = (substring(arsetup.currpernbr, 1, 4))) 
	--and (v.pernbr <= (substring(arsetup.currpernbr, 5, 2))) 
	and v.updflag = "PA") then v.amount else 0 end),


	YTDDisc = sum(Case when ((v.fiscalyr = (substring(arsetup.currpernbr, 1, 4))) 
	--and (v.pernbr <= (substring(arsetup.currpernbr, 5, 2))) 
	and v.updflag = "PA") then v.discamt else 0 end)


FROM vi_08990SumCredits v, ARHist h, arsetup
WHERE v.FiscalYr = h.FiscYr AND v.CustId = h.CustId AND v.CpnyID = h.CpnyID
GROUP BY v.cpnyid, v.custid, v.fiscalyr


 
