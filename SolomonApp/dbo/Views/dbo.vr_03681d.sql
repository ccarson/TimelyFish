 

CREATE VIEW vr_03681d AS

SELECT Period = vr.perpost, vr.RI_ID, vr.ReportDate,  
       vr.APAcct, vr.APSub, 
       vr.VendID, vname = SUBSTRING(CASE 
		WHEN CHARINDEX("~", ven.Name) > 0 
		THEN LTRIM(RTRIM(RIGHT(ven.Name, DATALENGTH(ven.Name)-CHARINDEX("~", ven.Name)))) + " " + SUBSTRING(ven.Name, 1, (CHARINDEX("~", ven.Name) - 1))
		ELSE ven.Name 
	END, 1, 30), ven.Status vstatus, ven.CuryID vCuryId,
       vr.Status dstatus, vr.RefNbr, vr.CuryID, vr.DueDate, 
       PayDate=CASE WHEN vr.DocType="AD" 
                    THEN NULL 
                    ELSE vr.PayDate 
                    END, 
       vr.DiscDate, vr.DocDate, 	
       vr.InvcNbr, vr.InvcDate, vr.DocType, vr.OrigDocAmt, 
       vr.CpnyID, vr.MasterDocNbr, 
       vr.S4Future11, cRI_ID = vr.RI_ID, vr.CpnyName,
	 Cur = CASE 
		WHEN vr.ReportDate <= vr.DueDate 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
                ELSE 0 END,
	 Past00 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue00)  
                          AND DATEDIFF(Day, vr.DueDate, vr.ReportDate) >= 1 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END,
	Past01 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue01) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) >CONVERT(INT, s.PastDue00) 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END,
	Past02 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue02) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) > CONVERT(INT, s.PastDue01) 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END,
	Over02 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) > CONVERT(INT, s.PastDue02) 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END, 
	cCur = CASE 
		WHEN vr.ReportDate <= vr.DueDate 
		THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.CurrBalance ELSE vr.CurrBalance END 
		ELSE 0 END,
	cPast00 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue00) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) >= 1 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.CurrBalance ELSE vr.CurrBalance END 
		ELSE 0 END,
	cPast01 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue01) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) > CONVERT(INT, s.PastDue00) 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.CurrBalance ELSE vr.CurrBalance END 
		ELSE 0 END,
	cPast02 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue02) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) > CONVERT(INT, s.PastDue01) 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.CurrBalance ELSE vr.CurrBalance END 
		ELSE 0 END,
	cOver02 = CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) > CONVERT(INT, s.PastDue02) 
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.CurrBalance ELSE vr.CurrBalance END 
		ELSE 0 END,
       vr.docUser1,vr.docUser2,
       vr.docUser3,vr.docUser4,
       vr.docUser5,vr.docUser6,
       vr.docUser7,vr.docUser8
  FROM vr_03681_docs vr, APSetup s (NOLOCK), Vendor ven
 WHERE vr.vendid = ven.vendid AND vr.Balance <> 0


 
