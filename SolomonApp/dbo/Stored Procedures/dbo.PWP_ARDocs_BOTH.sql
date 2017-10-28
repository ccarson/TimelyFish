 /****** Object:  Stored Procedure dbo.PWP_ARDocs_BOTH    Script Date: 06/7/06 ******/
Create Procedure PWP_ARDocs_BOTH @Custid varchar(15), @RefNbr varchar (10),
                                 @ProjectID varchar(16) as

SELECT a.*, CASE WHEN l.Custid IS NULL Then 0 Else 1 END ARLINKED
  FROM ARDoc a LEFT JOIN APARLINK l
                 ON a.Custid = l.Custid
                AND a.Doctype = l.ARDocType
                AND a.RefNbr = l.ARRefNbr
 WHERE a.Doctype = 'IN'
   AND a.Custid LIKE @Custid
   AND a.RefNbr LIKE @RefNbr
   AND a.ProjectID LIKE @ProjectID
   AND a.docbal > 0
 ORDER BY a.Custid, a.Refnbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PWP_ARDocs_BOTH] TO [MSDSL]
    AS [dbo];

