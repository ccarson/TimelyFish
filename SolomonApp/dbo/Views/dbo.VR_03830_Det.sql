 

create VIEW VR_03830_Det AS
					select  distinct VendId = adj.VendId,  VendName = a.VendName, CpnyID = a.CpnyID,

					
					January =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0101 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0131 then adj.adjbkupwthld else 0 end) ,

					February =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0201 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0229 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					March =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0301 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0331 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld  *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end) ,

					April =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0401 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0430 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					May =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0501 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0531 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					June =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0601 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0630 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld  *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					July =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0701 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0731 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld  *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					August =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0801 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0831 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					September =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 0901 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 0930 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld  *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					October =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 1001 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 1031 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					November =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 1101 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 1130 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end)  ,

					December =  (CASE when Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) >= 1201 and Right(Convert(Varchar(6), adj.AdjgDocDate, 12),4) <= 1231 then CASe when a.CpnyID = a.CpnyID then adj.adjbkupwthld  *  CASe when adj.AdjdDocType = 'AD' then -1 else 1 end end else 0 end),
					
					RefNbr = adj.AdjdRefNbr
					
							
					from APAdjust adj 
join APDoc a on a.RefNbr = adj.AdjgRefNbr and a.VendId = adj.VendId and a.BatNbr = adj.AdjBatNbr, RptRuntime r, APSetup, RPTCompany rc 
where adj.AdjBkupWthld <> 0 and r.ReportName = '03830' and r.RI_ID =  rc.RI_ID and a.CpnyID = rc.CpnyID 
and DatePart(YEAR, adj.AdjgDocDate) = Case when r.ShortAnswer00 ='False' then apsetup.Curr1099Yr else 
case when  r.ShortAnswer00 ='True' then APSetup.Next1099Yr end end

 
