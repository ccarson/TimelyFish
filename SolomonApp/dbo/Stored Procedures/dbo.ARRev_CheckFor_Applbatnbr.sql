 /****** Object:  Stored Procedure dbo.ARRev_CheckFor_Applbatnbr    Script Date: 11/12/00 12:30:32 PM ******/
CREATE PROC ARRev_CheckFor_Applbatnbr @Batnbr varchar (10), @custid varchar ( 15),
            @Doctype varchar ( 2), @refnbr varchar ( 10) AS

SELECT *
  FROM ARDoc
 WHERE Batnbr = @Batnbr AND
       ApplBatnbr = '' AND
       Custid = @custid AND
       Doctype = @Doctype AND
       Refnbr = @refnbr


