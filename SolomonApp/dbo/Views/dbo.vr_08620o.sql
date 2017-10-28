 

CREATE VIEW vr_08620o AS

SELECT	y.CpnyName, RecordID, 
	CName = CASE WHEN CHARINDEX('~',c.Name)>0 
                      THEN CONVERT(CHAR(30),LTRIM(RTRIM(SUBSTRING(c.Name,CHARINDEX('~',c.Name)+1,30)))
                                              + SPACE(1)+LTRIM(SUBSTRING(c.Name,1,CHARINDEX('~',c.Name)-1))) 
                     ELSE c.Name 
                END,
	RefNbr = j.AdjgRefNbr, DocType=j.DocType, AdjgDocType=j.AdjgDocType,
	d.CustID, d.CpnyID,
	CuryID = CASE d.CuryID WHEN g.BaseCuryID THEN NULL ELSE d.CuryID END,
	DocDesc = CASE j.RowType WHEN 'A' 
                                 THEN CASE WHEN j.AdjgDoctype = 'CM' 
                                           THEN cm.DocDesc 
                                           ELSE '' END
                                 ELSE d.DocDesc END,
	ARAcct = CASE WHEN d.DocType IN('PA','CS') THEN c.ARAcct WHEN d.DocType='PP' THEN c.PrePayAcct ELSE d.BankAcct END,
	ARSub = CASE WHEN d.DocType IN('PA','CS') THEN c.ARSub WHEN d.DocType='PP' THEN c.PrePaySub ELSE d.BankSub END,
	CuryOrigDocAmt = ISNULL(-j.CuryAdjdAmt,CASE WHEN d.DocType IN ('IN','DM','SC','FI','NC','CS','AD') 
                                                     THEN d.CuryOrigDocAmt ELSE -d.CuryOrigDocAmt END),
	OrigDocAmt = ISNULL(-j.AdjAmt,CASE WHEN d.DocType IN ('IN','DM','SC','FI','NC','CS','AD')
                                            THEN d.OrigDocAmt ELSE -d.OrigDocAmt END),
	CuryDocBal = CASE WHEN j.RowType='A' OR d.CuryID=g.BaseCuryID 
                          THEN NULL
                        ELSE
	                   CASE WHEN d.DocType IN ('IN','DM','SC','FI','NC','CS','AD') 
                                  THEN d.CuryDocBal ELSE -d.CuryDocBal END 
                   END,
	DocBal = CASE j.RowType WHEN 'A' 
                                 THEN NULL 
                               ELSE
		                  CASE WHEN d.DocType IN ('IN','DM','SC','FI','NC','CS','AD') 
                                         THEN d.DocBal ELSE -d.DocBal END 
                 END,
	PerPost = ISNULL(j.PerAppl,d.PerPost),
	PerEnt = CASE j.RowType WHEN 'A' THEN '' ELSE d.PerEnt END,
	PerClosed = CASE j.RowType WHEN 'A' THEN '' ELSE d.PerClosed END, 
	DocDate = ISNULL(j.AdjgDocDate,d.DocDate),
	CuryAdjdDiscAmt = -j.CuryAdjdDiscAmt, AdjDiscAmt=-j.AdjDiscAmt, cRI_ID=r.RI_ID,
	Parent = d.RefNbr+d.DocType, j.RowType,
	GrpAcctSub = CASE WHEN d.DocType IN('PA','CS') THEN c.ARAcct WHEN d.DocType='PP' THEN c.PrePayAcct ELSE d.BankAcct END
	                + CASE WHEN d.DocType IN('PA','CS') THEN c.ARSub WHEN d.DocType='PP' THEN c.PrePaySub ELSE d.BankSub END,
       	c.User1 as CustUser1, c.User2 as CustUser2, c.User3 as CustUser3, c.User4 as CustUser4,
       	c.User5 as CustUser5, c.User6 as CustUser6, c.User7 as CustUser7, c.User8 as CustUser8,
       	d.User1 as ARDocUser1, d.User2 as ARDocUser2, d.User3 as ARDocUser3, d.User4 as ARDocUser4, 
       	d.User5 as ARDocUser5, d.User6 as ARDocUser6, d.User7 as ARDocUser7, d.User8 as ARDocUser8
  FROM  RptRuntime r INNER LOOP JOIN RptCompany y 
                             ON y.RI_ID=r.RI_ID 
                     INNER JOIN ARDoc d 
                             ON d.CpnyID=y.CpnyID
	             INNER JOIN Customer c 
                             ON c.CustID=d.CustID
	             CROSS JOIN GLSetup g (NOLOCK) 
                      LEFT  JOIN vr_08620_Adjs j 
                             ON j.AdjdRefNbr=d.RefNbr 
                            AND j.AdjdDocType=d.DocType AND j.CustID=d.CustID
                      LEFT JOIN ARDOC CM 
                             ON j.AdjgRefNbr = cm.RefNbr 
                            AND j.AdjgDocType = cm.DocType AND j.CustID = cm.CustID
                            AND j.Adjgdoctype = 'CM'
WHERE	r.ReportNbr='08620' AND d.Rlsed=1 AND d.OpenDoc=1


 
