 

CREATE VIEW vr_08621_Docs AS

SELECT r.RI_ID, CuryID=MAX(d.CuryID), CpnyName=MAX(y.CpnyName), PerOpen = MAX(d.S4Future01),
       d.CustID, d.RefNbr, d.DocType, d.CpnyID, DocDesc=MAX(d.DocDesc), Period=MAX(r.EndPerNbr),
       BankAcct=MAX(d.BankAcct), BankSub=MAX(d.BankSub),
       CuryOrigDocAmt=MAX(d.CuryOrigDocAmt), OrigDocAmt=MAX(d.OrigDocAmt),
       CuryDocBal=MAX(d.CuryDocBal), DocBal=MAX(d.DocBal),
       PerPost=MAX(d.PerPost), PerEnt=MAX(d.PerEnt), PerClosed=MAX(d.PerClosed), DocDate=MAX(d.DocDate),
-- If the document is a Cash Sale or a Multi-Install MasterDoc, there are no supporting adjustments so start with a 0 docamt.
-- If the document is a future period document with current period applications, start balance calculations at 0
-- since the document does not really have an original value until the future period.
       CuryCalcBal=CASE WHEN d.DocType = 'CS' OR (MAX(T.TermsType) IS NOT NULL AND MAX(d.MasterDocNbr) = ' ')
                            OR MAX(d.Perpost) > MAX(r.EndPerNbr) 
                          THEN 0 
                        ELSE MAX(d.CuryOrigDocAmt)
                   END       
                     - SUM(COALESCE(i.CuryAdjdAmt+i.CuryAdjdDiscAmt,p.CuryAdjgAmt,0)), 
-- If the document is a Cash Sale or a Multi-Install MasterDoc, there are no supporting adjustments so start with a 0 docamt.
-- If the document is a future period document with current period applications, start balance calculations at 0
-- since the document does not really have an original value until the future period.
       CalcBal=CASE WHEN d.DocType = 'CS' OR (MAX(T.TermsType) IS NOT NULL AND MAX(d.MasterDocNbr) = ' ')
                            OR MAX(d.Perpost) > MAX(r.EndPerNbr) 
                      THEN 0 
                    ELSE MAX(d.OrigDocAmt)
               END 
                 - SUM(COALESCE(i.AdjAmt + i.AdjDiscAmt, p.AdjAmt - p.CuryRGOLAmt, 0)),
       	Max(d.User1) as ARDocUser1, Max(d.User2) as ARDocUser2, Max(d.User3) as ARDocUser3, Max(d.User4) as ARDocUser4, 
       	Max(d.User5) as ARDocUser5, Max(d.User6) as ARDocUser6, Max(d.User7) as ARDocUser7, Max(d.User8) as ARDocUser8                    
                 
  FROM RptRuntime r INNER JOIN RptCompany y ON y.RI_ID=r.RI_ID 
                    INNER JOIN ARDoc d 
                            ON d.CpnyID=y.CpnyID
                     LEFT JOIN Terms t ON d.terms = t.termsid and t.termstype = 'M'
                     LEFT JOIN	ARAdjust i 
                            ON i.AdjdRefNbr=d.RefNbr AND i.AdjdDocType=d.DocType 
                           AND i.CustID=d.CustID AND i.PerAppl<=r.EndPerNbr 
                     LEFT JOIN	ARAdjust p 
                            ON p.AdjgRefNbr=d.RefNbr AND p.AdjgDocType=d.DocType 
                           AND p.CustID=d.CustID AND p.PerAppl<=r.EndPerNbr
 WHERE r.ReportNbr='08621' AND d.Rlsed=1 
   AND d.s4Future01 <= r.EndPerNbr 
   AND (d.PerClosed >= r.BegPerNbr OR PerClosed = ' ')
 GROUP BY r.RI_ID, d.CustID, d.DocType, d.RefNbr, d.CpnyID


 
