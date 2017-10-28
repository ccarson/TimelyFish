 Create Proc pp_03400ExceptionReason
       @Msgid	as Int,
       @BatNbr  as VarChar (10)
as

/********************************************************************************
*    Proc Name: pp_03400ExceptionReason
**++* Narrative: Runs in Debug mode and Display the reason for Why the batch was eliminated
*++*            in preprocessing steps.
**    Inputs   : Msgid  Int, Batnbr VARCHAR(10)
**    Outputs  :
**   Called by: pp_03400
* ********************************************************************************/

-- Message ID 6019
If @Msgid = 6019

SELECT DISTINCT  d.BatNbr, d.refnbr,  msg = 'APTrans are missing or the sum of amounts does not match the APDoc'
FROM APDoc d, Currncy c
WHERE @BatNbr = d.BatNbr and d.curyid = c.curyid AND d.DocType <> 'ZC'
  AND d.DocType <> 'SC' AND d.DocType <> 'VC' AND d.DocType <> 'MC'
  AND (  ( (ROUND(d.CuryOrigDocAmt, c.DecPl) <> (SELECT ROUND(SUM(t.CuryTranAmt * SIGN(t.UnitPrice)), c.DecPl)
                                            FROM APTran t
                                           WHERE t.RefNbr = d.RefNbr AND t.TranType = d.DocType)
            )
            AND DocType IN ('CK')
           )
        OR (
            (ROUND(d.CuryPmtAmt, c.DecPl) <> (SELECT ROUND(SUM(t.CuryTranAmt * SIGN(t.UnitPrice)), c.DecPl)
                                          FROM APTran t
                                         WHERE t.RefNbr = d.RefNbr AND t.TranType = d.DocType
                                           AND t.Acct = d.Acct AND t.Sub = d.Sub)
            OR d.CuryPmtAmt <> d.CuryOrigDocAmt)
            AND DocType IN ('HC','EP')
           )
        OR (
            (SELECT COUNT(t.RefNbr)
               FROM APTran t
              WHERE t.RefNbr = d.RefNbr AND t.TranType = d.DocType) = 0
                AND d.DocType NOT IN ('CK')
           )
      )

    Print ''

If @Msgid = 6019
SELECT DISTINCT  d.BatNbr, d.refnbr,  msg = 'APTrans are missing or the sum of amounts does not match the APDoc'
  FROM APDoc d
 WHERE @BatNbr = d.BatNbr
   AND d.DocType IN ('VO', 'AD', 'AC')
   AND (ROUND(Convert(dec(28,3),d.CuryOrigDocAmt)
            - Convert(dec(28,3),d.CuryTaxTot00)
            - Convert(dec(28,3),d.CuryTaxTot01)
            - Convert(dec(28,3),d.CuryTaxTot02)
            - Convert(dec(28,3),d.CuryTaxTot03), 3)
                       <>
            (SELECT ROUND(SUM(Convert(dec(28,3),t.CuryTranAmt)) ,3)
               FROM ApTran t
              WHERE d.batnbr = t.batnbr
                AND d.refnbr = t.refnbr
            )
	    -  ---less taxes from price inclusive tax
            isnull ((SELECT round( SUM(Convert(dec(28,3),tTrantot)) ,3)
                 FROM vp_ExceptionAPPrcTaxIncl  v
               WHERE d.RefNbr = v.tRefNbr
                 AND d.BatNbr = v.tBatNbr ),0)
	 )

-- Message ID -1
If @Msgid = -1
 SELECT DISTINCT d.BatNbr, d.RefNbr, msg = 'Vendor does not exist for this Document'
FROM APDoc d
Left outer Join Vendor v
on d.vendid = v.vendid
WHERE
	v.vendid is null
	and @BatNbr = d.BatNbr

--Message ID -2
If @Msgid = -2
   SELECT DISTINCT d.BatNbr, d.refnbr,
                    d.taxid00,d.taxid01,d.taxid02,d.taxid03,
                    Msg='Taxid does not exist'
      FROM APdoc d LEFT OUTER JOIN salestax s1
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
          ANd d.batnbr like @batnbr

--Message ID 12008
If @Msgid = 12008
    SELECT   b.Batnbr,b.Rlsed,b.Status, msg = 'Batches that are already released'
     FROM Batch b
	where @BatNbr = b.batnbr
	AND b.Module  = 'AP'
   	AND (SELECT COUNT(*)
         FROM GLTRAN t
         WHERE b.module = t.module AND b.batnbr = t.batnbr AND t.posted = 'P') > 0

/*
In single currency databases, there should be only one record in the currncy table and
the batch, APDoc and APTran tables, the curyID should match the value that's held
in the GLSetup table.  When they don't, we need to update these records.  This is
done with pp_03400prepwrk.  If the curyID does not exist in the currncy table in
multi-currency databases, these records need to be corrected.
*/

-- Message ID 8058
If @Msgid = 8058
   Begin
     Select Distinct Msg = 'Batch CuryID does not exist in the Currncy table.',
            b.Batnbr, b.Module, b.BaseCuryID, b.CuryID
       From Batch b
       left join Currncy c
         on c.CuryID = b.CuryID
         or c.CuryID = b.BaseCuryID
      where b.Batnbr = @Batnbr
        and b.Module = 'AP'
        and c.CuryID is null

     Select Distinct Msg = 'APDoc CuryID does not exist in the Currncy table.',
            d.VendID, d.Refnbr, D.DocType, D.CuryID
       from APDoc d
       left join Currncy c
         on c.CuryID = d.CuryID
      where d.Batnbr = @Batnbr
        and c.CuryID is null

     Select Distinct Msg = 'APTran CuryID does not exist in the Currncy table.',
            t.VendID, t.Refnbr, t.TranType, t.CuryID, t.RecordID
       from APTran t
       left join Currncy c
         on c.CuryID = t.CuryID
      where t.Batnbr = @Batnbr
        and c.CuryID is null
   End

Print 'Batch Output'
SELECT * FROM Batch WHERE BatNbr = @Batnbr and Module = 'AP'
PRINT 'APDoc Output'
SELECT BatNbr, * FROM APDoc WHERE BatNbr = @BatNbr
PRINT 'APTran Output'
SELECT * FROM APTran WHERE BatNbr = @BatNbr


