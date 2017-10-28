 

CREATE VIEW vr_08611 AS

SELECT  v.*,Period = v.perpost, 
        DaysPastDue = DATEDIFF(Day, v.DueDate, v.ReportDate), 
        cRI_ID = v.RI_ID, 
        c.BillAttn, c.BillPhone, cname=c.Name, c.classid,
        t.descr,
        b.avgdaytopay,
	Cur = CASE 
		WHEN ARSetup.S4Future09=0 AND v.DocType IN('CM','PA','PP') OR v.ReportDate <= v.DueDate 
                THEN (v.CalcdOrigDocAmt - v.jAdjAmt + v.gadjamt) 
                ELSE 0 
                END,
        Past00 = CASE
		WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (v.ReportDate > v.DueDate) 
                   AND DATEDIFF(Day, v.DueDate, v.ReportDate) <= CONVERT(INT,s.agedays00) 
                THEN 
                     (v.CalcdOrigDocAmt - v.jAdjAmt + v.gadjamt)  Else 0 End,

	Past01 = CASE
	        WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (DATEDIFF(Day, v.DueDate, v.ReportDate) > CONVERT(INT,s.agedays00) AND 
			DATEDIFF(Day, v.DueDate, v.ReportDate) <= CONVERT(INT,s.agedays01)) THEN 
                        (v.CalcdOrigDocAmt - v.jAdjAmt + v.gadjamt) Else 0 End,

	Past02 = CASE
	        WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (DATEDIFF(Day, v.DueDate, v.ReportDate) > CONVERT(INT,s.agedays01) AND 
			DATEDIFF(Day, v.DueDate, v.ReportDate) <= CONVERT(INT,s.agedays02)) 
                THEN (v.CalcdOrigDocAmt - v.jAdjAmt + v.gadjamt) Else 0 End,
	Over02 = CASE
                WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (DATEDIFF(Day, v.DueDate, v.ReportDate) > CONVERT(INT,s.agedays02)) THEN 
                (v.CalcdOrigDocAmt - v.jAdjAmt + v.gadjamt) Else 0 End,
	cCur = CASE 
		WHEN ARSetup.S4Future09=0 AND v.DocType IN('CM','PA','PP') OR v.ReportDate <= v.DueDate THEN 
                (v.CalcdCuryOrigDocAmt - v.jCuryAdjdAmt + v.gCuryadjgamt) ELSE 0 END, 
	cPast00 = CASE
		WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (v.ReportDate > v.DueDate) 
                     AND DATEDIFF(Day, v.DueDate, v.ReportDate) <= CONVERT(INT,s.agedays00) 
                THEN  (v.CalcdCuryOrigDocAmt - v.jCuryAdjdAmt + v.gCuryadjgamt)  Else 0 End,
	cPast01 = CASE
	        WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (DATEDIFF(Day, v.DueDate, v.ReportDate) > CONVERT(INT,s.agedays00) AND 
			DATEDIFF(Day, v.DueDate, v.ReportDate) <= CONVERT(INT,s.agedays01)) THEN 
                       (v.CalcdCuryOrigDocAmt - v.jCuryAdjdAmt + v.gCuryadjgamt) Else 0 End, 
	cPast02 = CASE
	        WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (DATEDIFF(Day, v.DueDate, v.ReportDate) > CONVERT(INT,s.agedays01) AND 
			DATEDIFF(Day, v.DueDate, v.ReportDate) <= CONVERT(INT,s.agedays02)) THEN 
                        (v.CalcdCuryOrigDocAmt - v.jCuryAdjdAmt + v.gCuryadjgamt) Else 0 End,
	cOver02 = CASE
                WHEN (ARSetup.S4Future09=1 OR v.DocType NOT IN('CM','PA','PP')) AND (DATEDIFF(Day, v.DueDate, v.ReportDate) > CONVERT(INT,s.agedays02)) THEN 
                     (v.CalcdCuryOrigDocAmt - v.jCuryAdjdAmt + v.gCuryadjgamt) Else 0 End,
        s.StmtCycleId, AgeDays00 = CONVERT(INT,S.aGEdAYS00), AgeDays01 = CONVERT(INT,S.aGEdAYS01),
        AgeDays02 = CONVERT(INT,S.aGEdAYS02), 
       	c.User1 as CustUser1, c.User2 as CustUser2, c.User3 as CustUser3, c.User4 as CustUser4,
       	c.User5 as CustUser5, c.User6 as CustUser6, c.User7 as CustUser7, c.User8 as CustUser8
  FROM vr_08611_docs v (NOLOCK) INNER JOIN Customer c (NOLOCK) ON v.custid = c.custid
              INNER JOIN arstmt s (NOLOCK)  ON c.StmtCycleId = s.StmtCycleId  
              INNER JOIN ar_balances b (NOLOCK) ON v.custid = b.custid
                                      AND v.cpnyid = b.cpnyid                   
              LEFT OUTER JOIN  terms t (NOLOCK) ON v.Terms = t.TermsId, ARSetup (NOLOCK)


 
