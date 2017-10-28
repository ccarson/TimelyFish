 /****** Object:  Stored Procedure dbo.ar08600_pre    Script Date: 4/7/98 12:54:32 PM ******/
CREATE PROC ar08600_pre @RI_ID smallint
AS
        DECLARE @CountryC_descr varchar(30),
				@LineCnt int

		Select @LineCnt = 0

	        DELETE FROM ar08600_wrk
        WHERE  RI_ID not in
	(select ri_id from rptruntime (nolock) where reportnbr = "08600") and asid = 0 and wsid = 0

	Delete from ar08600_wrk where ri_id = @ri_id and asid = 0 and wsid = 0

        SELECT  @CountryC_descr = descr
        FROM    Country, GLSetup
        WHERE   Country.CountryId = GLSetup.Country



        INSERT  ar08600_wrk( RI_ID,CpnyID,CuryDocBal,CuryID,CuryOrigDocAmt,CuryStmtBal,CustID,DocBal,DocClass,DocDate,
                DocDesc,DocType,OrigDocAmt,RefNbr,Rlsed,StmtBal,StmtDate,ASID, Customer_AgeBal01,Customer_AgeBal02,
                Customer_AgeBal03,Customer_AgeBal04,Customer_BillAddr1,Customer_BillAddr2,Customer_BillAttn,
                Customer_BillCity,Customer_BillCountry,Customer_BillName,Customer_BillState,Customer_BillZip,
                Customer_DunMsg,Cust_TotStmtBal,Cust_LastStmtBal00,Cust_LastStmtBal01,Cust_LastStmtBal02,
                Cust_LastStmtBal03,Cust_LastStmtBal04,Cust_LastStmtBegBal,Cust_LastStmtDate,Customer_PrtStmt,
                Customer_StmtCycleID,Customer_StmtType,

                arAdjust_AdjGDocType,arAdjust_AdjGRefNbr,arAdjust_AdjAmt,arAdjust_AdjDiscAmt,arAdjust_CuryAdjDAmt,
                arAdj_CuryAdjDiscAmt,arAdjust_CustID,

                CountryC_Descr,

                ARDoc1_StmtDate,

		arDoc1_DocDate,arDoc1_DocType,arDoc1_RefNbr,

		arStmt_AgeDays00,arStmt_AgeDays01,arStmt_AgeDays02,arStmt_AgeMsg00,arStmt_AgeMsg01,arStmt_AgeMsg02,
        	arStmt_AgeMsg03,arStmt_LastStmtDate,

		CountryB_Descr)

SELECT  @RI_ID, d.CpnyID, d.CuryDocBal, d.CuryID, d.CuryOrigDocAmt, d.CuryStmtBal, c.CustID, d.DocBal,
	d.DocClass, d.DocDate, d.DocDesc, d.DocType, d.OrigDocAmt, d.RefNbr, d.Rlsed,
	d.StmtBal, d.StmtDate, 0,
	y.AgeBal01, y.AgeBal02, y.AgeBal03, y.AgeBal04,
	c.BillAddr1, c.BillAddr2, c.BillAttn,
	c.BillCity, c.BillCountry, c.BillName,
	c.BillState, c.BillZip, c.DunMsg,
	y.LastStmtBal00+y.LastStmtBal01+y.LastStmtBal02+y.LastStmtBal03+y.LastStmtBal04,
	y.LastStmtBal00, y.LastStmtBal01, y.LastStmtBal02,
	y.LastStmtBal03, y.LastStmtBal04, y.LastStmtBegBal,
	y.LastStmtDate, c.PrtStmt, c.StmtCycleID,
	c.StmtType,

	ISNULL(j.AdjGDocType,' '), 
	ISNULL(j.AdjGRefNbr, ' '),
	ISNULL(j.AdjAmt,0),
	ISNULL(j.AdjDiscAmt,0),
	ISNULL(j.CuryAdjDAmt,0),
	ISNULL(j.CuryAdjdDiscAmt,0),
	ISNULL(j.CustID,' '),

	@CountryC_descr,

	ISNULL( p.StmtDate,  d.StmtDate),
	ISNULL(j.AdjGDocDate,' '),
	ISNULL(j.AdjGDocType,' '), 
	ISNULL(j.AdjGRefNbr, ' '),

	s.AgeDays00, s.AgeDays01, s.AgeDays02, s.AgeMsg00,
	s.AgeMsg01, s.AgeMsg02, s.AgeMsg03, s.LastStmtDate,

	COALESCE(Country.Descr, '')

FROM    Customer c INNER JOIN ARStmt s 
                           ON s.StmtCycleID=c.StmtCycleID 
                   INNER JOIN RptCompany m 
                           ON m.RI_ID=@RI_ID 
                   INNER JOIN  (SELECT CustID, AgeBal01=SUM(AgeBal01), AgeBal02=SUM(AgeBal02), 
                                       AgeBal03=SUM(AgeBal03), AgeBal04=SUM(AgeBal04),
		                       LastStmtBal00=SUM(LastStmtBal00), LastStmtBal01=SUM(LastStmtBal01), 
                                       LastStmtBal02=SUM(LastStmtBal02), LastStmtBal03=SUM(LastStmtBal03), 
                                       LastStmtBal04=SUM(LastStmtBal04), LastStmtBegBal=SUM(LastStmtBegBal), 
                                       LastStmtDate=MAX(LastStmtDate), CurrBal=SUM(CurrBal)
	                          FROM AR_Balances b INNER JOIN RptCompany m 
                                                        ON m.CpnyID=b.CpnyID
                                 WHERE RI_ID=@RI_ID AND LastStmtDate<>'' 
                                 GROUP BY CustID) y 
                           ON y.CustID=c.CustID
	            LEFT LOOP JOIN ARDoc d 
                           ON  d.CpnyID=m.CpnyID AND d.CustID=c.CustID AND d.Rlsed=1 AND
							d.DocType<>'AD' AND --exclude Accrued Revenue docs
	                       d.DocType<>'RP' AND d.S4Future12<>'RP' AND d.StmtDate<>'' AND
	                       ((d.StmtBal>0 OR d.DocBal>0) AND c.StmtType = 'O' 
                                        OR c.StmtType = 'B' AND d.StmtDate = s.LastStmtDate)
	            LEFT LOOP JOIN ARAdjust j 
                           ON j.AdjdDocType=d.DocType AND j.AdjdRefNbr=d.RefNbr AND 
                              j.CustID=d.CustID AND j.S4Future12 NOT IN ('RA','RP')
                    LEFT LOOP JOIN ARDoc p 
                           ON p.CustID=j.CustID AND p.DocType=j.AdjgDocType AND 
                              p.RefNbr=j.AdjgRefNbr
                    LEFT JOIN Country 
                           ON Country.CountryId = c.BillCountry
 WHERE c.PrtStmt=1 AND
       (d.CustID IS NOT NULL OR y.LastStmtBegBal<>0 OR y.LastStmtBal00<>0 OR
              y.LastStmtBal01<>0 OR y.LastStmtBal02<>0 OR y.LastStmtBal03<>0 OR 
              y.LastStmtBal04<>0 OR y.CurrBal<>0)

-- Now Add discounts
INSERT  ar08600_wrk( RI_ID,CpnyID,CuryDocBal,CuryID,CuryOrigDocAmt,CuryStmtBal,CustID,DocBal,DocClass,DocDate,
		DocDesc,DocType,OrigDocAmt,RefNbr,Rlsed,StmtBal,StmtDate,ASID, Customer_AgeBal01,Customer_AgeBal02,
		Customer_AgeBal03,Customer_AgeBal04,Customer_BillAddr1,Customer_BillAddr2,Customer_BillAttn,
                Customer_BillCity,Customer_BillCountry,Customer_BillName,Customer_BillState,Customer_BillZip,
                Customer_DunMsg,Cust_TotStmtBal,Cust_LastStmtBal00,Cust_LastStmtBal01,Cust_LastStmtBal02,
                Cust_LastStmtBal03,Cust_LastStmtBal04,Cust_LastStmtBegBal,Cust_LastStmtDate,Customer_PrtStmt,
                Customer_StmtCycleID,Customer_StmtType, arAdjust_AdjGDocType,arAdjust_AdjGRefNbr,arAdjust_AdjAmt,
		arAdjust_AdjDiscAmt,arAdjust_CuryAdjDAmt, arAdj_CuryAdjDiscAmt,arAdjust_CustID, CountryC_Descr,
		ARDoc1_StmtDate, arDoc1_DocDate,arDoc1_DocType,arDoc1_RefNbr, arStmt_AgeDays00,arStmt_AgeDays01,
		arStmt_AgeDays02,arStmt_AgeMsg00,arStmt_AgeMsg01,arStmt_AgeMsg02, arStmt_AgeMsg03,arStmt_LastStmtDate,
                CountryB_Descr)

SELECT  @RI_ID, min(d.CpnyID), 0, min(d.CuryID), sum(j.CuryadjgDiscAmt), 0, j.CustID, 0, min(d.DocClass), 
		d.DocDate, '', 'DA', sum(j.AdjDiscAmt), d.RefNbr, 1, 0, min(y.LastStmtDate), 0, min(y.AgeBal01), 
		min(y.AgeBal02), Min(y.AgeBal03), min(y.AgeBal04), min(c.BillAddr1), min(c.BillAddr2), 
		min(c.BillAttn), min(c.BillCity), min(c.BillCountry), min(c.BillName), min(c.BillState), 
		min(c.BillZip), min(c.DunMsg), 
		min(y.LastStmtBal00 + y.LastStmtBal01 + y.LastStmtBal02 + y.LastStmtBal03 + y.LastStmtBal04),
                min(y.LastStmtBal00), min(y.LastStmtBal01), min(y.LastStmtBal02), min(y.LastStmtBal03), min(y.LastStmtBal04), 
		min(y.LastStmtBegBal), min(y.LastStmtDate), 1, min(c.StmtCycleID), 'B', min(j.AdjGDocType), d.RefNbr,
                0, 0, 0, 0, 0, @CountryC_descr, min(y.LastStmtDate), ' ', ' ',  ' ', min(s.AgeDays00), Min(s.AgeDays01), 
		min(s.AgeDays02), min(s.AgeMsg00), min(s.AgeMsg01), min(s.AgeMsg02), min(s.AgeMsg03), 
		min(s.LastStmtDate), ''

FROM ARAdjust j JOIN ARDOC d
	ON j.custid = d.custid
        	and j.adjddoctype = d.doctype 
        	and j.adjdrefnbr = d.refnbr
		and j.adjDiscAmt > 0
        JOIN Customer c
        	ON d.CustId = c.CustId
        INNER JOIN RptCompany m 
		ON m.RI_ID=@RI_ID 
        INNER JOIN  (SELECT CustID, AgeBal01=SUM(AgeBal01), AgeBal02=SUM(AgeBal02),  AgeBal03=SUM(AgeBal03), 
			AgeBal04=SUM(AgeBal04), LastStmtBal00=SUM(LastStmtBal00), LastStmtBal01=SUM(LastStmtBal01), 
			LastStmtBal02=SUM(LastStmtBal02), LastStmtBal03=SUM(LastStmtBal03), 
			LastStmtBal04=SUM(LastStmtBal04), LastStmtBegBal=SUM(LastStmtBegBal), 
                        LastStmtDate=MAX(LastStmtDate), CurrBal=SUM(CurrBal)

        	       FROM AR_Balances b INNER JOIN RptCompany m 
		         ON m.CpnyID=b.CpnyID
		      WHERE RI_ID=@RI_ID AND LastStmtDate<>'' 
		      GROUP BY CustID) y 

                ON y.CustID=c.CustID

             	INNER JOIN ARStmt s 
                	ON s.StmtCycleID=c.StmtCycleID 
WHERE c.PrtStmt=1 and j.crtd_datetime between s.CloseDateTime_Prev and s.CloseDateTime and c.stmttype = 'B'

Group By j.CustID, d.DocDate, d.DocType, d.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ar08600_pre] TO [MSDSL]
    AS [dbo];

