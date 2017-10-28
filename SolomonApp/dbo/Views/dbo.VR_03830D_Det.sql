 

create VIEW VR_03830D_Det AS
	select Distinct APAdjust.AdjgRefNbr, 
		AdjDiscAmt = (APAdjust.AdjDiscAmt), 
		AdjAmt = (APAdjust.AdjAmt * CASe When APAdjust.AdjdDocType = 'AD' then -1 else 1 end),
		AdjBkupWthld = (APAdjust.AdjBkupWthld * CASe When APAdjust.AdjdDocType = 'AD' then -1 else 1 end), 
		VendName = a.VendName, 
		VendorID = APAdjust.VendId,
		CpnyID = a.CpnyID, 
		CheckDate = convert(varchar, APAdjust.AdjgDocDate, 101),
		RefNbr = apadjust.AdjdRefNbr
		from apdoc a join APAdjust on a.RefNbr = APAdjust.AdjgRefNbr and a.VendId = APAdjust.VendId and a.BatNbr = APAdjust.AdjBatNbr, RptRuntime r, 
		APSetup, RPTCompany rc where APAdjust.AdjgRefNbr = a.RefNbr and r.ReportName = '03830d' and r.RI_ID =  rc.RI_ID and a.CpnyID = rc.CpnyID 
		and APAdjust.AdjBkupWthld <> 0   and 
		DatePart(YEAR, APAdjust.AdjgDocDate) = Case when r.ShortAnswer00 ='False' 
		then apsetup.Curr1099Yr else case when  r.ShortAnswer00 ='True' then APSetup.Next1099Yr end end				


 
