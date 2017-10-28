 

CREATE VIEW vr_08621 AS

SELECT v.CpnyName, v.Period, j.RecordID,
       CName = CASE WHEN CHARINDEX('~',c.Name)>0 
                      THEN CONVERT(CHAR(30),LTRIM(RTRIM(SUBSTRING(c.Name,CHARINDEX('~',c.Name)+1,30)))
                                               + SPACE(1)+LTRIM(SUBSTRING(c.Name,1,CHARINDEX('~',c.Name)-1))) 
                     ELSE c.Name 
                END,
       RefNbr=j.AdjgRefNbr, DocType=j.DocType, AdjgDocType=j.AdjgDocType,
       v.CustID, v.CpnyID,
       CuryID=CASE v.CuryID WHEN g.BaseCuryID THEN NULL ELSE v.CuryID END,
       DocDesc=CASE j.RowType WHEN 'A' THEN '' ELSE v.DocDesc END,
       ARAcct=CASE WHEN v.DocType IN('PA','CS') THEN c.ARAcct WHEN v.DocType='PP' THEN c.PrePayAcct ELSE v.BankAcct END,
       ARSub=CASE WHEN v.DocType IN('PA','CS') THEN c.ARSub WHEN v.DocType='PP' THEN c.PrePaySub ELSE v.BankSub END,
       CuryOrigDocAmt = COALESCE(-j.CuryAdjdAmt, CASE WHEN v.DocType IN ('IN','DM','SC','FI','NC','CS','AD') 
                                                        THEN v.CuryOrigDocAmt 
                                                      ELSE -v.CuryOrigDocAmt 
                                                 END),
       OrigDocAmt=COALESCE(-j.AdjAmt,CASE WHEN v.DocType IN ('IN','DM','SC','FI','NC','CS','AD') 
                                             THEN v.OrigDocAmt 
                                          ELSE -v.OrigDocAmt 
                                     END),
       CuryDocBal=CASE WHEN j.RowType='A' OR v.CuryID=g.BaseCuryID 
                         THEN NULL 
                       ELSE CASE WHEN v.DocType IN ('IN','DM','SC','FI','NC','CS','AD') 
                                   THEN v.CuryCalcBal 
                                 ELSE -v.CuryCalcBal 
                            END 
                  END,
       DocBal=CASE j.RowType WHEN 'A' 
                               THEN NULL 
                             ELSE CASE WHEN v.DocType IN ('IN','DM','SC','FI','NC','CS','AD') 
                                         THEN v.CalcBal 
                                       ELSE -v.CalcBal 
                                  END
              END,
       PerPost=CASE j.RowType WHEN 'A' THEN j.PerAppl ELSE v.PerPost END,
       PerEnt= CASE j.RowType WHEN 'A' THEN '' ELSE v.PerEnt END,
       PerClosed=CASE j.RowType WHEN 'A' THEN '' ELSE v.PerClosed END, 
       DocDate=COALESCE(j.AdjgDocDate,v.DocDate),
       CuryAdjdDiscAmt = -j.CuryAdjdDiscAmt, AdjDiscAmt = -j.AdjDiscAmt, cRI_ID=v.RI_ID,
       Parent = v.RefNbr+v.DocType, j.RowType,
-- Concatenate the acct and sub firlds to make report grouping easier
       GrpAcctSub = CASE WHEN v.DocType IN('PA','CS') THEN c.ARAcct 
                         WHEN v.DocType='PP'          THEN c.PrePayAcct 
                         ELSE v.BankAcct
                    END
                  + CASE WHEN v.DocType IN('PA','CS') THEN c.ARSub 
                         WHEN v.DocType='PP'          THEN c.PrePaySub
                         ELSE v.BankSub 
                    END,
       	c.User1 as CustUser1, c.User2 as CustUser2, c.User3 as CustUser3, c.User4 as CustUser4,
       	c.User5 as CustUser5, c.User6 as CustUser6, c.User7 as CustUser7, c.User8 as CustUser8,
	v.ARDocUser1, v.ARDocUser2, v.ARDocUser3, v.ARDocUser4, 
       	v.ARDocUser5, v.ARDocUser6, v.ARDocUser7, v.ARDocUser8       	
  FROM vr_08621_Docs v (NOLOCK) INNER JOIN Customer c (NOLOCK)
                               ON c.CustID=v.CustID
                       INNER JOIN GLSetup g (NOLOCK) 
                               ON g.SetupID='GL'
	               INNER JOIN vr_08621_Adjs j (NOLOCK)
                              ON j.AdjdDocType=v.DocType AND j.AdjdRefNbr=v.RefNbr AND j.CustID=v.CustID
 WHERE  j.PerAppl<=v.Period
   AND (v.DocType IN ('IN','DM','SC','FI','NC','CS', 'AD') OR v.CuryCalcBal<>0)


 
