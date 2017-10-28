 


CREATE VIEW vp_08400CorrectARPayments as
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400CorrectARPayments
*
*++* Narrative: This view will check to see if there is a difference between 
*++*            docbal and the sum of the trans.     
*
*
*   Called by: pp_08400
* 
*/

Select w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 

       DifDocBal = (Min(convert(decimal(28,3),a.docbal)) - 
                   (Min(convert(decimal(28,3),a.applamt)) 
                    + sum(convert(decimal(28,3),t.tranamt)))) * -1,

       OrigDocbal = Min(convert(decimal(18,3),a.docbal))

  FROM wrkrelease w INNER JOIN batch b
                          ON w.batnbr = b.batnbr
                          AND w.module = b.module
                    INNER JOIN artran t
                          ON b.batnbr = t.batnbr
                    INNER JOIN ardoc a
                          ON a.applbatnbr = t.batnbr
                          AND a.custid = t.custid
                          AND a.doctype = t.trantype
                          AND a.refnbr = t.refnbr
                    INNER JOIN glsetup g (nolock)
                          ON g.basecuryid <> a.curyid
 WHERE w.module = 'AR' 
       AND b.editscrnnbr = '08030'
        
GROUP BY w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr




 
