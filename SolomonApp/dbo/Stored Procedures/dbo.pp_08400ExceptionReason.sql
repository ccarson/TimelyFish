 Create Proc pp_08400ExceptionReason
       @Msgid	as Int,
       @batnbr  as VarChar (10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

/********************************************************************************
*    Proc Name: pp_08400ExceptionReason
**++* Narrative: Runs in Debug mode and Display the reason for Why the batch was eliminated
*++*            in preprocessing steps.
**    Inputs   : Msgid  Int, Batnbr VARCHAR(10)
**    Outputs  :
**   Called by: pp_08400
*
*/

-- Message ID 12125
If @Msgid = 12125
  Begin
    SELECT DISTINCT d.BatNbr, d.Refnbr,Msg = 'ARTran Refnbr is Blank or There is no ARTran for ARDoc.'
      FROM ARDoc d INNER JOIN currncy c
                   ON d.curyid+'' = c.curyid
      WHERE d.Batnbr Like @BatNbr
       AND (SELECT COUNT(t.RefNbr)
               FROM ARTran t
               WHERE t.RefNbr = d.RefNbr
                 AND t.TranType = d.DocType) = 0
                 AND d.DocType NOT IN ('PA', 'CM', 'NS', 'NC', 'RP')
  End
-- Message ID 12126
If @Msgid = 12126
  Begin
    SELECT DISTINCT t.BatNbr, t.refnbr, Msg = 'ARdoc Refnbr is Blank, or Invoice and Debit Memo transactions have no documents.'
      FROM ARTran t LEFT outer JOIN ARDoc d
                    ON t.RefNbr = d.RefNbr
                    AND t.TranType = d.DocType
                    AND t.BatNbr = d.BatNbr
      WHERE  t.TranType IN ('IN', 'DM')
             AND d.RefNbr Is Null
             AND t.Batnbr Like @BatNbr
  End

-- Message ID 12347
If @Msgid = 12347
  Begin
    SELECT DISTINCT d.BatNbr, d.RefNbr, d.Custid,
                    Msg = 'Customer ID is blank.'
      FROM ARDoc d LEFT OUTER JOIN customer c
                     ON c.CustID = d.CustID
      WHERE d.CustID = '' OR  c.CustID IS null
        AND d.batnbr like @batnbr
  End

--Message ID 12348
If @Msgid = 12348
   Begin
    SELECT DISTINCT d.BatNbr, d.refnbr,
                    d.taxid00,d.taxid01,d.taxid02,d.taxid03,
                    Msg='Taxid does not exist'
      FROM ARdoc d LEFT OUTER JOIN salestax s1
                              ON taxid00 = s1.taxid
                         LEFT OUTER JOIN salestax s2
                              ON taxid01 = s2.taxid
                         LEFT OUTER JOIN salestax s3
                              ON taxid02 = s3.taxid
                         LEFT OUTER JOIN salestax s4
                              ON taxid03 = s4.taxid
      WHERE ((taxid00 <> '' AND s1.taxid IS null)
          OR (taxid01 <> '' AND s2.taxid IS null)
          OR (taxid02 <> '' AND s3.taxid IS null)
          OR (taxid03 <> '' AND s4.taxid IS null))
          AND d.batnbr like @batnbr
    End

-- Message ID 6928
If @Msgid = 6928
   Begin
    SELECT DISTINCT t.BatNbr, t.refnbr,t.acct,t.sub,Module = 'AR',
                    msg= 'Acct is not valid'
       FROM  ARTran t
       WHERE t.Acct = '' OR  t.Acct is null
         AND t.batnbr like @batnbr
   End

-- Message ID 6929
If @Msgid = 6929
   Begin
    SELECT DISTINCT t.BatNbr, t.refnbr,t.acct,t.sub,Module = 'AR',
                    msg = 'Sub is not valid'
      FROM  ARTran t
      WHERE t.Sub = '' OR t.sub is null
        ANd t.batnbr like @batnbr
   End

--Message ID 6624
If @Msgid = 6624
   Begin
    SELECT DISTINCT d.BatNbr, v.refnbr, v.taxid, Msg = 'Sales Tax ID is used as an individual tax and group tax in the same document.'
       FROM ARDoc d INNER JOIN vp_SalesTaxARUsage v
                          ON d.RefNbr = v.RefNbr
                          AND d.DocType = v.TranType
                          AND v.UserAddress = 'ARDebug'
       WHERE d.batnbr like @BatNbr
       GROUP BY d.BatNbr, v.refnbr, v.UserAddress, v.TaxID
       HAVING COUNT(*) > 1
    End

--Message ID 6958
If @Msgid = 6958
   Begin
    SELECT DISTINCT d.BatNbr, d.Refnbr, msg = 'Taxtype for taxid is null and must be populated with T for a tax or G for a group.'
       FROM ardoc d INNER LOOP JOIN salestax t
                          ON (d.taxid00 = t.taxid OR d.taxid01 = t.taxid OR
                              d.taxid02 = t.taxid OR d.taxid03 = t.taxid)
       WHERE t.taxtype = ''
         AND d.doctype IN ('IN', 'CM', 'DM')
         AND d.batnbr like @batnbr
    End

--Message ID 12008
If @Msgid = 12008
   Begin
    SELECT  Msg = 'Batches that are already released', b.Batnbr,b.Rlsed,b.Status,
            gltran_count = (SELECT count(*) FROM gltran g WHERE g.batnbr = b.batnbr and module  = 'AR'),
            b.*
      FROM BATCH b
     WHERE b.module = 'AR'
       AND b.batnbr like @batnbr
       AND B.Rlsed = 1
   End

--Message ID 12014
If @Msgid = 12014
   Begin
     SELECT Msg = 'Missing installments for Multi Install Docs.',
            d.Batnbr, d.Custid, d.Refnbr, d.Doctype, d.Terms, t.TermsType, t.NbrInstall, t.Cycle, t.Frequency
       FROM ardoc d INNER JOIN terms t
                       ON d.terms = t.termsid
                     LEFT OUTER JOIN docterms c
                       ON d.doctype = c.doctype
                      AND d.refnbr = c.refnbr
      WHERE d.Batnbr = @Batnbr
        AND t.termstype = 'M'
        AND c.doctype IS NULL
   End

--Message ID 12124
If @Msgid = 12124
   Begin
      SELECT t.BatNbr,t.refnbr,t.trantype, t.tranamt, t.curytranamt,
         Msg = 'Curytranamt not equal to tranamt for base currency documents.'

      FROM  GLSetup g,Ardoc d INNER JOIN ARTran t
                              		ON d.BatNbr = t.BatNbr AND
					d.RefNbr = t.RefNbr AND
				 	d.CustID = t.CustID AND
				 	d.DocType = t.TranType
     WHERE  d.batnbr = @batnbr
	    AND g.BaseCuryId = d.CuryID
	    AND round(t.CuryTranAmt,2) <> round(t.TranAmt,2)
  End

If @MsgID = 12306
   Begin
     SELECT Msg = 'Payment batch should be released after the corresponding invoice(s) is released.'
     SELECT Inv = 'INVOICE', InvBatnbr = d.Batnbr, InvRefnbr = d.Refnbr, InvDocType = d.DocType, d.Custid,
            Pay = 'PAYMENT', PayBatnbr = t.Batnbr, PayRefnbr = t.Refnbr, PayDocType = t.TranType
       FROM ARTran t JOIN ARDoc d
                       ON t.custid = d.custid AND t.SiteID = d.Refnbr
                      AND t.Costtype = d.doctype
      WHERE t.drcr = 'U' AND d.rlsed = 0 AND t.Batnbr = @Batnbr
   End

--Message ID 12123
If @Msgid = 12123
   Begin
     SELECT Msg = 'Batch totals do not equal the sum of the documents.'
     SELECT 'BATCH', b.batnbr, b.module, b.rlsed,  b.curycrtot,
            b.crtot, b.ctrltot, b.curyctrltot, c.curyid, c.decpl
       FROM batch b, currncy c (nolock)
      WHERE b.batnbr = @batnbr
        AND b.module = 'AR'
        AND b.curyid = c.curyid

     SELECT 'ARDOC', d.batnbr,
       SumCuryOrigDocamt = sum(convert(dec(28,3),d.curyorigdocamt)),
       SumOrigDocamt = sum(convert(dec(28,3),d.origdocamt))
     FROM ardoc d
    WHERE d.batnbr = @Batnbr
    GROUP BY d.batnbr
   End

--Message ID 12427
If @Msgid = 12427
   Begin
     SELECT DISTINCT Msg = 'Payment CuryID does not Match Invoice Acct CuryID.',
            t.Custid, t.Refnbr, t.TranType,
            InvoiceCury = a.CuryID,PaymentCury = d.CuryID
       FROM ARTran t INNER JOIN ARDoc d
                        ON t.Custid = d.Custid AND t.Refnbr = d.Refnbr
                       AND t.Trantype = d.Doctype
                     INNER JOIN Account a (nolock)
                        ON a.Acct = t.Acct
      WHERE t.batnbr = @batnbr
        AND t.DRCR = 'U' AND a.CuryID <> ' ' AND d.CuryID <> a.CuryID
   End

/*
In single currency databases, there should be no records in the currncy table and
the batch, ARDoc and ARTran tables, the curyID should match the value that's held
in the GLSetup table.  When they don't, we need to update these records.  This is
done with pp_08400prepwrk.  If the curyID does not exist in the currncy table in
multi-currency databases, these records need to be corrected.
*/

-- Message ID 8058
if @MsgID = 8058
   Begin
     Select Distinct Msg = 'Batch CuryID does not exist in the Currncy table.',
            b.Batnbr, b.Module, b.BaseCuryID, b.CuryID
       From Batch b
       left join Currncy c
         on c.CuryID = b.CuryID
         or c.CuryID = b.BaseCuryID
      where b.Batnbr = @Batnbr
        and b.Module = 'AR'
        and c.CuryID is null

     Select Distinct Msg = 'ARDoc CuryID does not exist in the Currncy table.',
            d.CustID, d.Refnbr, D.DocType, D.CuryID
       from ARDoc d
       left join Currncy c
         on c.CuryID = d.CuryID
      where d.Batnbr = @Batnbr
        and c.CuryID is null

     Select Distinct Msg = 'ARTran CuryID does not exist in the Currncy table.',
            t.CustID, t.Refnbr, t.TranType, t.CuryID, t.RecordID
       from ARTran t
       left join Currncy c
         on c.CuryID = t.CuryID
      where t.Batnbr = @Batnbr
        and c.CuryID is null
   End

Print 'Batch Output'
SELECT * FROM Batch WHERE BatNbr = @Batnbr and Module = 'AR'
PRINT 'ArDoc Output'
SELECT BatNbr, ApplBatNbr,* FROM ARDoc WHERE BatNbr = @BatNbr or ApplBatNbr = @BatNbr
PRINT 'ARTran Output'
SELECT * FROM ARTran WHERE BatNbr = @BatNbr


