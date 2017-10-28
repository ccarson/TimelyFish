 CREATE PROCEDURE WOPJLabHdr_Det_LEStatus
   @LE_Status  varchar( 1 )
AS
   SELECT      *
   FROM        PJLabHdr LEFT JOIN PJLabDet
               ON PJLabHdr.DocNbr = PJLabDet.DocNbr
   WHERE       PJLabHdr.LE_Status = @LE_Status
   ORDER BY    PJLabHdr.LE_Status, PJLabHdr.Employee, PJLabHdr.DocNbr


