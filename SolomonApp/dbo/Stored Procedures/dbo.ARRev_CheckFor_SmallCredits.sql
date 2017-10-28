 /****** Object:  Stored Procedure dbo.ARRev_CheckFor_SmallCredits    Script Date: 12/27/00 12:30:32 PM ******/
CREATE PROC ARRev_CheckFor_SmallCredits @custid varchar (15), @Adjgdoctype varchar (2),
                                         @Adjgrefnbr varchar(10) AS

SELECT DISTINCT d.*
  FROM ARAdjust a JOIN ARDoc d
             ON a.custid = d.custid AND
                a.adjddoctype = d.doctype AND
                a.adjdrefnbr = d.refnbr
 WHERE a.custid = @custid AND a.AdjgDoctype = @adjgdoctype AND
       a.adjgrefnbr = @adjgrefnbr AND a.adjddoctype = 'SC'


