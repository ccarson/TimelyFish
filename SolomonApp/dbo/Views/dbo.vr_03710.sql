 

CREATE VIEW vr_03710 AS
SELECT d.*, RptRuntime.RI_ID  
FROM apdoc d, RptCompany, RptRuntime 
WHERE d.CpnyID = RptCompany.CpnyID AND RptRuntime.RI_ID = RptCompany.RI_ID and d.docclass='C' 
     AND (d.perpost between RptRuntime.BegPerNbr and RptRuntime.EndPerNbr OR d.status='O' and d.PerPost <= RptRuntime.EndPerNbr or d.PerClosed between RptRuntime.BegPerNbr and RptRuntime.EndPerNbr) AND
     d.DocType IN ('HC','EP','CK', 'VC')


 
