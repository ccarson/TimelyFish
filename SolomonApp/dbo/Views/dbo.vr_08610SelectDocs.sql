 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vr_08610SelectDocs AS

SELECT d.CpnyID, d.CuryId, 
       CuryOrigDocAmt = CASE WHEN  (d.doctype in ("PA", "PP", "CM")) 
                          THEN -d.CuryOrigDocAmt 
                          ELSE  d.CuryOrigDocAmt 
                          END, 
       d.CustId, d.DocDate, d.DocType, 
       DueDate = CASE WHEN  (d.doctype in ("PA", "PP", "CM")) 
                   THEN d.docdate 
                   ELSE  d.duedate 
                   END, 
       OrigDocAmt = CASE WHEN  (d.doctype in ("PA", "PP", "CM")) 
                      THEN -d.OrigDocAmt 
                      ELSE  d.OrigDocAmt 
                      END, 
       d.PerPost,d.PerClosed, d.RefNbr, d.Rlsed, d.terms, d.docbal,
       b.AvgDayToPay,
       c.BillAttn, c.BillPhone, cCuryid = c.CuryId, 
       CName = c.Name, c.StmtCycleId,
       s.AgeDays00, s.AgeDays01, s.AgeDays02
  FROM ARdoc d, customer c, arstmt s, ar_balances b
 WHERE d.custid = c.custid AND 
       d.cpnyid = b.cpnyid AND
       b.custid = c.custid AND 
       c.stmtcycleid = s.stmtcycleid AND 
       d.doctype not in ('VT', 'RC') AND 
       d.rlsed = 1

 
