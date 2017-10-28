 /****** Object:  Stored Procedure dbo.PWP_APDocs_Linked    Script Date: 06/7/06 ******/
Create Procedure PWP_APDocs_Linked @VendID varchar(15), @RefNbr varchar (10), @SubContract varchar (16),
                                 @ProjectID varchar(16) as

SELECT a.*, APLINKED = 1
  FROM APDoc a JOIN Terms t
                 ON a.Terms = t.TermsID
               JOIN APARLINK l
                 ON a.Vendid = l.Vendid
                AND a.Doctype = l.APDocType
                AND a.RefNbr = l.APRefNbr
 WHERE a.Doctype IN ('AC','VO')
   AND t.DiscType = 'P'
   AND a.Vendid LIKE @VendID
   AND a.RefNbr LIKE @RefNbr
   AND a.SubContract LIKE @SubContract
   AND a.ProjectID LIKE @ProjectID
   AND a.docbal > 0
 ORDER BY a.VendID, a.Refnbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PWP_APDocs_Linked] TO [MSDSL]
    AS [dbo];

