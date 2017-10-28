 /****** Object:  Stored Procedure dbo.APARLink_APDocs_PWP    Script Date: 06/7/06 ******/
Create Procedure APARLink_APDocs_PWP @VendID varchar(15), @DocType varchar (2), @RefNbr varchar (10) as

SELECT *
  FROM APARLink
 WHERE VendID = @VendID
   AND APDoctype = @DocType
   AND APRefnbr = @RefNbr


