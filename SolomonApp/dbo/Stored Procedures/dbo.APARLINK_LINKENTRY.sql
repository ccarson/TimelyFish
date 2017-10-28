 /****** Object:  Stored Procedure dbo.APARLINK_LINKENTRY    Script Date: 06/7/06 ******/
Create Procedure APARLINK_LINKENTRY @VendID varchar(15), @APRefNbr varchar (10),
                                   @SubContract varchar (16), @APProjectID varchar(16),
                                   @Custid varchar(15), @ARRefNbr varchar (10),
                                   @ARProjectID varchar(16) AS

SELECT l.*,APCpnyID = d.CpnyID, APDocType = d.DocType, APProject = d.ProjectID,
       APRefNbr = d.RefNbr, d.SubContract,d.VendID, APDocBal = d.DocBal, APDocDate = d.DocDate,
       ARCpnyID = a.CpnyID, ARDocType = a.Doctype, ARProject = a.ProjectID, ARRefNbr = a.RefNbr,
       a.Custid, ARDocBal = a.DocBal, ARDueDate = a.DueDate

  FROM APARLINK l JOIN APDoc d
                    ON l.Vendid = d.VendID
                   AND l.APDoctype = d.doctype
                   AND l.APRefnbr = d.RefNbr
                  JOIN ARDoc a
                    ON l.Custid = a.Custid
                   AND l.ARDoctype = a.Doctype
                   AND l.ARRefNbr = a.RefNbr

 WHERE l.Vendid LIKE @VendID
   AND l.APRefNbr LIKE @APRefNbr
   AND d.SubContract LIKE @SubContract
   AND d.ProjectID LIKE @APProjectID
   AND l.Custid LIKE @Custid
   AND l.ARRefNbr LIKE @ARRefNbr
   AND a.ProjectID LIKE @ARProjectID
   AND l.Status = 'O'
 ORDER BY l.VendID,l.APRefnbr, l.APDocType, l.Custid, l.ARRefNbr


