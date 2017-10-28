 /****** Object:  Stored Procedure dbo.APDocVendIDDoctypeRefNbr_PWP    Script Date: 06/7/06 ******/
Create Procedure APDocVendIDDoctypeRefNbr_PWP @VendID varchar(15), @Doctype varchar (2), @RefNbr varchar (10) as

SELECT APCpnyID = CpnyID, APDocType = DocType, APProject = ProjectID, APRefNbr = RefNbr,
       SubContract,VendID, APDocBal = DocBal, APDocDate = DocDate
  FROM APDoc d
 WHERE VendID = @VendID
   AND Doctype = @Doctype
   AND RefNbr = @RefNbr


