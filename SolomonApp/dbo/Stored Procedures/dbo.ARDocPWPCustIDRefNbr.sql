 /****** Object:  Stored Procedure dbo.ARDocPWPCustIDRefNbr    Script Date: 06/7/06 ******/
Create Procedure ARDocPWPCustIDRefNbr @CustID varchar(15), @RefNbr varchar (10) as
SELECT *
  FROM ARDoc
 WHERE CustID = @CustID
   AND RefNbr LIKE @RefNbr
   AND DocType = 'IN'
   AND Docbal > 0
 ORDER BY CustID, DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDocPWPCustIDRefNbr] TO [MSDSL]
    AS [dbo];

