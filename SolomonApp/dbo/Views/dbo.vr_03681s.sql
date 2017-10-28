 

CREATE VIEW vr_03681s AS

SELECT  vr.RI_ID, vr.ReportDate,
        vr.VendID, vname = SUBSTRING(CASE 
		WHEN CHARINDEX("~", ven.Name) > 0 
		THEN LTRIM(RTRIM(RIGHT(ven.Name, DATALENGTH(ven.Name)-CHARINDEX("~", ven.Name)))) + " " + SUBSTRING(ven.Name, 1, (CHARINDEX("~", ven.Name) - 1))
		ELSE ven.Name 
	END, 1, 30), ven.status vStatus, 
        vr.CpnyID, vr.CpnyName,
	Cur = SUM(CASE 
		WHEN vr.ReportDate <= vr.DueDate
                THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
 		ELSE 0 END),
	Past00 = SUM(CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue00) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) >= 1 
		THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END),
	Past01 = SUM(CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue01) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) >CONVERT(INT, s.PastDue00) 
		THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END),
	Past02 = SUM(CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) <= CONVERT(INT, s.PastDue02) AND 
			DATEDIFF(Day, vr.DueDate, vr.ReportDate) > CONVERT(INT, s.PastDue01)
            THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END),
	Over02 = SUM(CASE
		WHEN DATEDIFF(Day, vr.DueDate, vr.ReportDate) > CONVERT(INT, s.PastDue02)
            THEN CASE WHEN vr.doctype IN ('CK','HC','EP') THEN -vr.Balance ELSE vr.Balance END
		ELSE 0 END),
        Max(ven.User1) as VendorUser1, Max(ven.User2) as VendorUser2, Max(ven.User3) as VendorUser3, Max(ven.User4) as VendorUser4, 
        Max(ven.User5) as VendorUser5, Max(ven.User6) as VendorUser6, Max(ven.User7) as VendorUser7, Max(ven.User8) as VendorUser8		
FROM vr_03681_docs vr, APSetup s (NOLOCK), Vendor ven 
WHERE vr.vendid = ven.vendid AND vr.Balance <> 0 
GROUP BY vr.CpnyID,vr.VendID, vr.CpnyName,vr.RI_ID, vr.ReportDate, 
         ven.Name, ven.Status



 
