 


Create view vr_08600SelectDocs as

        SELECT  d.cpnyid,
d.CustId,
                d.DocType,
                d.RefNbr,
                d.DocClass
        FROM    ARDoc d, vr_08600SelectCust v, rptcompany r
        WHERE   d.CustId = v.CustId
        AND     (d.DocBal > 0.0 or d.StmtBal > 0.0)
        AND     d.Rlsed = 1
        AND     v.StmtType = "O"
        AND     d.StmtDate <> "01/01/1900"
	AND 	d.docclass <> "R"
	AND 	d.doctype Not In ('VT', 'RP')
        AND     d.cpnyid = r.cpnyid

Union

        SELECT  d.cpnyid,
d.CustId,
                d.DocType,
                d.RefNbr,
                d.DocClass
        FROM    ARDoc d, vr_08600SelectCust v, ARStmt s, rptcompany r
        WHERE   d.CustId = v.CustId
        AND     v.StmtType = "B"
        AND     d.StmtDate = s.LastStmtDate
        AND     v.stmtcycleid = s.stmtcycleid
	AND 	d.DocClass <> "R"
	AND 	d.doctype Not In ('VT', 'RP')
	AND     d.cpnyid = r.cpnyid




 
