 CREATE PROCEDURE PurchOrd_RcptNbr
    @RcptNbr CHAR(10)
AS
    -- PurchOrds used with this POReceipt
    SELECT DISTINCT PurchOrd.*
     FROM POReceipt WITH (NOLOCK)
      INNER JOIN PurchOrd WITH (NOLOCK)
       ON PurchOrd.PONbr = POReceipt.PONbr
     WHERE POReceipt.RcptNbr = @RcptNbr
     ORDER BY PurchOrd.PONbr


