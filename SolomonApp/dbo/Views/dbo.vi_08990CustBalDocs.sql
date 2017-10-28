 

CREATE VIEW vi_08990CustBalDocs AS

SELECT d.cpnyid, d.custid, d.doctype, 

currbal = (CASE WHEN (d.perpost <= c.PerNbr AND Doctype NOT IN ('AD', 'RA') AND d.MasterDocNbr = '') THEN d.OrigDocamt ELSE 0 END) -
           -- subtract out payments received against invoices that were 
           -- paid equal/prior to current period but have perpost in future
            CASE WHEN DocType IN ('IN','DM','FI','NC','NS','RP','SC')
                 THEN ISNULL((SELECT  SUM(AdjAmt + AdjDiscAmt)
                                FROM ARAdjust j
                               WHERE d.custid = j.custid AND d.refnbr = j.AdjdRefNbr AND 
                                     d.DocType = j.AdjdDoctype AND Perappl <= c.PerNbr),0) 
                 ELSE 0
            END -
           -- add in payments that were applied current/prior to current period but have perpost in future
            CASE WHEN DocType IN ('PA','PP','CM','SB')
                 THEN ISNULL((SELECT SUM(AdjAmt - CuryRGOLAmt) 
                                FROM ARAdjust j
                               WHERE d.custid = j.custid AND d.refnbr = j.AdjgRefNbr AND 
                                     d.DocType = j.AdjgDoctype AND Perappl <= c.PerNbr),0)
                 ELSE 0
            END,

futurebal = (CASE WHEN (d.perpost > c.pernbr AND Doctype NOT IN ('AD', 'RA') AND d.MasterDocNbr = '') THEN d.OrigDocamt ELSE 0 END) -        
  -- subtract out payments received against invoices that were 
           -- paid equal/prior to current period but have perpost in future
            CASE WHEN DocType IN ('IN','DM','FI','NC','NS','RP','SC')
                 THEN ISNULL((SELECT  SUM(AdjAmt + AdjDiscAmt)
                                FROM ARAdjust j
                               WHERE d.custid = j.custid AND d.refnbr = j.AdjdRefNbr AND 
                                     d.DocType = j.AdjdDoctype AND Perappl > c.PerNbr),0) 
                 ELSE 0
            END -
           -- add in payments that were applied current/prior to current period but have perpost in future
            CASE WHEN DocType IN ('PA','PP','CM','SB')
                 THEN ISNULL((SELECT SUM(AdjAmt - CuryRGOLAmt) 
                                FROM ARAdjust j
                               WHERE d.custid = j.custid AND d.refnbr = j.AdjgRefNbr AND 
                                     d.DocType = j.AdjgDoctype AND Perappl > c.PerNbr),0)
                 ELSE 0
            END,

d.refnbr, d.perpost,

BalMul = (CASE WHEN d.doctype IN ('IN', 'FI', 'DM', 'NC', 'SC', 'NS', 'AD') THEN 1
               WHEN d.doctype IN ('PA', 'CM', 'DA', 'RF', 'SB', 'PP', 'RA') THEN -1
               ELSE 0 END )

  FROM ARDoc d INNER JOIN customer c 
                       ON d.custid = c.custid

 WHERE d.Rlsed = 1 AND 
       d.docclass <> 'R' AND 
       d.doctype <> 'VT'








 
