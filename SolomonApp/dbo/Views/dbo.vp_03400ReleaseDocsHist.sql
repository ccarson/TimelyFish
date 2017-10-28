 

CREATE VIEW vp_03400ReleaseDocsHist AS 

/****** File Name: 0310vp_03400ReleaseDocsHist.Sql		******/
/****** Last Modified by Chuck Schroeder on 10/22/98 at 12:35pm 	******/
/****** Calculate amounts that will affect AR history balances.	******/

SELECT v.UserAddress, h.FiscYr, h.VendId, h.CpnyId,
	PtdCrAdjs00 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "01" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs01 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "02" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs02 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "03" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs03 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "04" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs04 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "05" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs05 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "06" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs06 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "07" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs07 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "08" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs08 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "09" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs09 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "10" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs10 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "11" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs11 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "12" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	PtdCrAdjs12 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "13" AND v.DocType = "AC") 
		THEN v.origdocamt ELSE 0 END),
	YtdCrAdjs = SUM(CASE WHEN v.DocType = "AC" 
                             THEN CASE WHEN (PerPost <= RTRIM(CurYr) + RTRIM(CurPer)) 
                                       THEN v.origdocamt 
                                       ELSE 0 END 
                             ELSE 0 END),
	PtdDiscTkn00 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "01" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn01 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "02" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn02 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "03" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn03 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "04" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn04 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "05" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn05 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "06" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn06 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "07" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn07 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "08" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn08 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "09" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn09 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "10" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn10 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "11" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn11 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "12" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	PtdDiscTkn12 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "13" AND v.DocType = "DT") 
		THEN v.origdocamt ELSE 0 END),
	YtdDiscTkn = SUM(CASE WHEN v.DocType = "DT" 
                             THEN CASE WHEN (PerPost <= RTRIM(CurYr) + RTRIM(CurPer)) 
                                       THEN v.origdocamt 
                                       ELSE 0 END 
                             ELSE 0 END),
	PtdDrAdjs00 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "01" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs01 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "02" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs02 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "03" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs03 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "04" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs04 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "05" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs05 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "06" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs06 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "07" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs07 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "08" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs08 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "09" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs09 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "10" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs10 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "11" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs11 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "12" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	PtdDrAdjs12 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "13" AND v.DocType = "AD") 
		THEN v.origdocamt ELSE 0 END),
	YtdDrAdjs = SUM(CASE WHEN v.DocType = "AD" 
                             THEN CASE WHEN (PerPost <= RTRIM(CurYr) + RTRIM(CurPer)) 
                                       THEN v.origdocamt 
                                       ELSE 0 END 
                             ELSE 0 END),
	PtdPaymt00 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "01" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt01 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "02" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt02 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "03" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt03 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "04" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt04 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "05" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt05 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "06" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt06 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "07" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt07 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "08" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt08 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "09" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt09 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "10" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt10 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "11" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt11 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "12" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	PtdPaymt12 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "13" AND v.DocType in ("PA","VC")) 
		THEN v.origdocamt ELSE 0 END),
	YtdPaymt = SUM(CASE WHEN v.DocType  in ("PA","VC")
                             THEN CASE WHEN (PerPost <= RTRIM(CurYr) + RTRIM(CurPer)) 
                                       THEN v.origdocamt 
                                       ELSE 0 END 
                             ELSE 0 END),
	PtdPurch00 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "01" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch01 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "02" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch02 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "03" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch03 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "04" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch04 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "05" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch05 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "06" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch06 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "07" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch07 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "08" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch08 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "09" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch09 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "10" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch10 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "11" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch11 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "12" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	PtdPurch12 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "13" AND v.DocType = "VO") 
		THEN v.origdocamt ELSE 0 END),
	YtdPurch =  SUM(CASE WHEN v.DocType = "VO" 
                             THEN CASE WHEN (PerPost <= RTRIM(CurYr) + RTRIM(CurPer)) 
                                       THEN v.origdocamt 
                                       ELSE 0 END 
                             ELSE 0 END),
    PtdBkupWthld00 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "01" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld01 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "02" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld02 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "03" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld03 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "04" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld04 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "05" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld05 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "06" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld06 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "07" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld07 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "08" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld08 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "09" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld09 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "10" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld10 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "11" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld11 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "12" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	PtdBkupWthld12 = SUM(CASE WHEN (RIGHT(RTRIM(v.PerPost),2) = "13" AND v.DocType = "BW") 
		THEN v.origdocamt ELSE 0 END),
	YTDBkupWthld =  SUM(CASE WHEN v.DocType = "BW" 
                             THEN CASE WHEN (PerPost <= RTRIM(CurYr) + RTRIM(CurPer)) 
                                       THEN v.origdocamt 
                                       ELSE 0 END 
                             ELSE 0 END)
FROM vp_03400ReleaseDocs v, APHist h
WHERE v.VendId = h.VendId AND v.FiscYr = h.FiscYr AND v.CpnyID = h.CpnyID
GROUP BY v.UserAddress, h.FiscYr, h.VendId, h.CpnyID




 
