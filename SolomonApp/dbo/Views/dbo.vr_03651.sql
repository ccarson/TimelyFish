 

CREATE	VIEW vr_03651

AS

SELECT	Parent=CASE dRefNbr WHEN '' THEN gRefNbr ELSE dRefNbr END,
	CpnyID,
	Ord=MIN(Ord),
	s.VendID,
	RefNbr=CASE gRefNbr WHEN '' THEN dRefNbr ELSE gRefNbr END,
	DocDate=CASE gRefNbr WHEN '' THEN MAX(dDocDate) ELSE MAX(gDocDate) END,
	InvcNbr=CASE gRefNbr WHEN '' THEN MAX(InvcNbr) ELSE '' END,
	InvcDate=CASE gRefNbr WHEN '' THEN MAX(InvcDate) ELSE '' END,
	DocType=CASE gRefNbr WHEN '' THEN dDocType ELSE gDocType END,
	PerEnt=CASE gRefNbr WHEN '' THEN MAX(dPerEnt) ELSE MAX(gPerEnt) END,
	MasterDocNbr=CASE gRefNbr WHEN '' THEN MAX(MasterDocNbr) ELSE '' END,
	S4Future11=CASE gRefNbr WHEN '' THEN MAX(s.S4Future11) ELSE '' END,
	PerPost=CASE gRefNbr WHEN '' THEN MAX(dPerPost) ELSE MAX(gPerPost) END,
	PerClosed=CASE gRefNbr WHEN '' THEN MAX(dPerClosed) ELSE MAX(gPerClosed) END,
	OrigDocAmt=CASE gRefNbr WHEN '' THEN MAX(dOrigDocAmt)*CASE WHEN dDocType IN('AD','PP') THEN -1 ELSE 1 END
		ELSE -SUM(gOrigDocAmt+gPPFutureRGOLAmt) END,
	CuryOrigDocAmt=CASE gRefNbr WHEN '' THEN MAX(dCuryOrigDocAmt)*CASE WHEN dDocType IN('AD','PP') THEN -1 ELSE 1 END
		ELSE -SUM(gCuryOrigDocAmt) END,
	VName=MAX(Name),
	APAcct=MAX(s.APAcct),
	APSub=MAX(s.APSub),
	Balance=CASE gRefNbr WHEN '' THEN MAX(dDocBal)*CASE dDocType WHEN 'AD' THEN -1 ELSE 1 END
		ELSE -SUM(CASE WHEN dPerPost>Period THEN gOrigDocAmt+gPPFutureRGOLAmt ELSE 0 END) END,
	DocBal=CASE gRefNbr WHEN '' THEN MAX(dDocBal)*CASE dDocType WHEN 'AD' THEN -1 ELSE 1 END
		ELSE 0 END,
	CuryID=CASE gRefNbr WHEN '' THEN MAX(dCuryID) ELSE MAX(gCuryID) END,
	CurrBalance=CASE gRefNbr WHEN '' THEN MAX(dCuryDocBal)*CASE dDocType WHEN 'AD' THEN -1 ELSE 1 END
		ELSE -SUM(CASE WHEN dPerPost>Period THEN gCuryOrigDocAmt ELSE 0 END) END,
	CpnyName=MAX(CpnyName),
	Period,
	dStatus=CASE gRefNbr WHEN '' THEN MAX(dStatus) ELSE '' END,
	vStatus=MAX(v.Status),
	DueDate=CASE gRefNbr WHEN '' THEN MAX(dDueDate) ELSE MAX(gDate) END,
	PayDate=CASE gRefNbr WHEN '' THEN MAX(dPayDate) ELSE MAX(gDate) END,
	cRI_ID=MIN(RI_ID),
        Max(s.APDocUser1) as APDocUser1, Max(s.APDocUser2) as APDocUser2, Max(s.APDocUser3) as APDocUser3, Max(s.APDocUser4) as APDocUser4, 
        Max(s.APDocUser5) as APDocUser5, Max(s.APDocUser6) as APDocUser6, Max(s.APDocUser7) as APDocUser7, Max(s.APDocUser8) as APDocUser8,		
        Max(v.User1) as VendorUser1, Max(v.User2) as VendorUser2, Max(v.User3) as VendorUser3, Max(v.User4) as VendorUser4, 
        Max(v.User5) as VendorUser5, Max(v.User6) as VendorUser6, Max(v.User7) as VendorUser7, Max(v.User8) as VendorUser8		
FROM
(SELECT	r.RI_ID,Ord,Period=BegPerNbr,d.VendID,c.CpnyID,CpnyName=MAX(c.CpnyName),
	dDocDate=MAX(d.DocDate),gDocDate=CASE Ord WHEN 1 THEN '' ELSE MAX(g.DocDate) END,
	dDueDate=MAX(d.DueDate),dPayDate=MAX(d.PayDate),gDate=MAX(COALESCE(j.AdjgDocDate,'')),
	dStatus=MAX(d.Status),
	MasterDocNbr=MAX(d.MasterDocNbr),S4Future11=MAX(d.S4Future11),
	APAcct=MAX(d.Acct),APSub=MAX(d.Sub),InvcNbr=MAX(d.InvcNbr),InvcDate=MAX(d.InvcDate),
	dDocType=CASE WHEN Ord=1 OR MAX(d.PerPost)<=MAX(BegPerNbr) AND (MAX(d.PerPost)=MAX(BegPerNbr)
		OR MAX(d.PerClosed)=MAX(BegPerNbr) OR MAX(COALESCE(a.AdjgPerPost,''))=MAX(BegPerNbr) OR
		ROUND(MAX(CASE d.DocType WHEN 'PP' THEN 0 ELSE d.OrigDocAmt END)
		-SUM(COALESCE(a.AdjAmt+a.AdjDiscAmt,0)),MAX(Currncy.DecPl))<>0) THEN d.DocType ELSE '' END,
	dRefNbr=CASE WHEN Ord=1 OR MAX(d.PerPost)<=MAX(BegPerNbr) AND (MAX(d.PerPost)=MAX(BegPerNbr)
		OR MAX(d.PerClosed)=MAX(BegPerNbr) OR MAX(COALESCE(a.AdjgPerPost,''))=MAX(BegPerNbr) OR
		ROUND(MAX(CASE d.DocType WHEN 'PP' THEN 0 ELSE d.OrigDocAmt END)
		-SUM(COALESCE(a.AdjAmt+a.AdjDiscAmt,0)),MAX(Currncy.DecPl))<>0) THEN d.RefNbr ELSE '' END,
	dPerPost=MAX(d.PerPost),dPerClosed=MAX(d.PerClosed),dPerEnt=MAX(d.PerEnt),
	gPerPost=MAX(COALESCE(g.PerPost,'')),gPerClosed=MAX(COALESCE(g.PerClosed,'')),gPerEnt=MAX(COALESCE(g.PerEnt,'')),
	ParentPerClosed=MAX(COALESCE(a.AdjgPerPost,'')),
	gDocType=CASE WHEN Ord=1 THEN '' WHEN Ord=3 AND MAX(d.PerPost)<=MAX(BegPerNbr) AND (MAX(d.PerPost)=MAX(BegPerNbr)
		OR MAX(d.PerClosed)=MAX(BegPerNbr) OR MAX(COALESCE(a.AdjgPerPost,''))=MAX(BegPerNbr) OR
		ROUND(MAX(CASE d.DocType WHEN 'PP' THEN 0 ELSE d.OrigDocAmt END)
		-SUM(COALESCE(a.AdjAmt+a.AdjDiscAmt,0)),MAX(Currncy.DecPl))<>0)
		THEN 'DT' when Ord=4 then (CASE When Max(j.AdjBkupWthld) <> 0 then 'BW' END) ELSE j.AdjgDocType END,
	gRefNbr=CASE Ord WHEN 1 THEN '' ELSE j.AdjgRefNbr END,
	dOrigDocAmt=MAX(d.OrigDocAmt),dCuryOrigDocAmt=MAX(d.CuryOrigDocAmt),
	gPPFutureRGOLAmt=CASE WHEN Ord=2 AND MAX(j.AdjgPerPost)>BegPerNbr AND MAX(j.AdjgPerPost)<>MAX(g.PerPost)
		THEN MAX(j.CuryRGOLAmt) ELSE 0 END,
	gOrigDocAmt=CASE Ord WHEN 2 THEN MAX(j.AdjAmt) WHEN 3 THEN MAX(j.AdjDiscAmt) when 4 then (CASE When Max(j.AdjBkupWthld) <> 0 then MAX(j.adjbkupwthld) END) ELSE 0 END
		*CASE d.DocType WHEN 'AD' THEN -1 ELSE 1 END,
	gCuryOrigDocAmt=CASE Ord WHEN 2 THEN CASE WHEN MAX(g.CuryID)=MAX(d.CuryID)
		THEN MAX(j.CuryAdjdAmt) ELSE MAX(j.CuryAdjgAmt) END when 4 then (CASE When Max(j.AdjBkupWthld) <> 0 then MAX(j.adjbkupwthld) END)
		WHEN 3 THEN CASE WHEN MAX(g.CuryID)=MAX(d.CuryID)
		THEN MAX(j.CuryAdjdDiscAmt) ELSE MAX(j.CuryAdjgDiscAmt) END ELSE
		CASE WHEN MAX(g.CuryID)=MAX(d.CuryID) THEN MAX(j.CuryAdjdAmt)+MAX(j.CuryAdjdDiscAmt)
		ELSE MAX(j.CuryAdjgAmt)+MAX(j.CuryAdjgDiscAmt) END END
		*CASE d.DocType WHEN 'AD' THEN -1 ELSE 1 END,
	dDocBal=ROUND(MAX(CASE d.DocType WHEN 'PP' 
	                                 THEN -d.OrigDocAmt + isnull(jpp.adjamt + jpp.curyrgolamt,CASE WHEN j.ADJDRefNbr IS NOT NULL 
                                                                                                   THEN CASE WHEN vc.VENDID IS NULL 
	                                                                                                         THEN 0
	                                                                                                         ELSE d.OrigDocAmt
	                                                                                                          END
                                                                                                   ELSE d.OrigDocAmt END) 
	                                 ELSE d.OrigDocAmt END)
		-SUM(COALESCE(a.AdjAmt+a.AdjDiscAmt+a.adjBkupWthld ,0)),MAX(Currncy.DecPl)),
	dCuryDocBal=MAX(CASE d.DocType WHEN 'PP' 
	                               THEN -d.CuryOrigDocAmt + isnull(jpp.curyadjdamt,CASE WHEN j.ADJDRefNbr IS NOT NULL 
                                                                                                   THEN CASE WHEN vc.VENDID IS NULL 
	                                                                                                         THEN 0
	                                                                                                         ELSE d.CuryOrigDocAmt
	                                                                                                          END
                                                                                                   ELSE d.CuryOrigDocAmt END)  
	                               ELSE d.CuryOrigDocAmt END)
		-SUM(COALESCE(a.CuryAdjdAmt+a.CuryAdjdDiscAmt,0)),
	dCuryID=MAX(d.CuryID),gCuryID=MAX(COALESCE(g.CuryID,'')),
	gAcct=CASE Ord WHEN 1 THEN '' ELSE j.AdjgAcct END, gSub=CASE Ord WHEN 1 THEN '' ELSE j.AdjgSub END,
        Max(d.User1) as APDocUser1, Max(d.User2) as APDocUser2, Max(d.User3) as APDocUser3, Max(d.User4) as APDocUser4, 
        Max(d.User5) as APDocUser5, Max(d.User6) as APDocUser6, Max(d.User7) as APDocUser7, Max(d.User8) as APDocUser8		
FROM	RptRuntime r INNER JOIN RptCompany c ON c.RI_ID=r.RI_ID INNER JOIN APDoc d ON d.CpnyID=c.CpnyID
	LEFT JOIN APDoc m ON m.MasterDocNbr=d.RefNbr AND m.S4Future11='MI'
	LEFT JOIN APAdjust j ON j.AdjdRefNbr=d.RefNbr AND j.AdjdDocType=d.DocType AND j.VendID=d.VendID AND j.PerAppl <= BegPerNbr
	LEFT JOIN APAdjust a ON a.AdjdRefNbr=d.RefNbr AND a.AdjdDocType=d.DocType AND a.VendID=d.VendID AND a.AdjdDoctype <> 'pp' AND a.PerAppl <= BegPerNbr
    LEFT JOIN APAdjust vc ON vc.ADJDREFNBR = j.ADJDRefNbr AND vc.VENDID = j.VendID AND vc.AdjdDoctype = d.DocType 
                         AND vc.AdjdDocType = 'PP' AND vc.ADJGDocType = 'VC'AND vc.perappl <= r.begpernbr 
	LEFT OUTER JOIN vr_apreport_adjpp jpp ON d.vendid = jpp.vendid
						AND d.refnbr = jpp.adjdRefnbr
						AND d.doctype = jpp.adjdDoctype
						AND r.ri_id = jpp.ri_id
	LEFT JOIN APDoc g ON g.RefNbr=j.AdjgRefNbr AND g.DocType=j.AdjgDocType AND g.Acct=j.AdjgAcct AND g.Sub=j.AdjgSub
	AND g.VendID=j.VendID AND g.PerPost<=BegPerNbr CROSS JOIN vr_Ord4
	CROSS JOIN GLSetup (NOLOCK) INNER JOIN Currncy (NOLOCK) ON Currncy.CuryID=GLSetup.BaseCuryID
WHERE	m.MasterDocNbr IS NULL AND d.Rlsed=1 AND d.DocType IN('VO','AD','AC','PP')
	AND (Ord=1 AND d.PerPost<=BegPerNbr
	OR g.RefNbr IS NOT NULL AND( Ord=2 OR Ord=3 AND j.AdjDiscAmt<>0 OR (Ord=4 and j.AdjBkupWthld <>0)))
GROUP BY r.RI_ID,c.CpnyID,d.VendID,BegPerNbr,Ord,d.DocType,d.RefNbr,j.AdjgDocType,j.AdjgRefNbr,j.AdjgAcct,j.AdjgSub) s
	INNER JOIN Vendor v ON v.VendID=s.VendID
WHERE	Ord<>1 OR dPerPost<=Period AND (dDocBal<>0 OR dPerPost=Period OR dPerClosed=Period OR ParentPerClosed=Period)
GROUP BY RI_ID,CpnyID,s.VendID,Period,dDocType,dRefNbr,gDocType,gRefNbr,gAcct,gSub
HAVING	MAX(dDocType)<>'' OR MAX(gPerPost)=MAX(Period) OR MAX(gPerClosed)=MAX(Period)
	OR SUM(CASE WHEN dPerPost>Period THEN gOrigDocAmt ELSE 0 END)<>0


 
