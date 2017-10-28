
CREATE PROCEDURE WS_ProjectExpensePosted
@DocNbr VARCHAR(10), @Status VARCHAR(1), @GLBatch VARCHAR(16), @APBatch VARCHAR(30), @Period VARCHAR(6)
AS
  UPDATE PJEXPHDR 
     SET status_1 = @Status, te_id03 = @GLBatch, te_id02 = @APBatch, fiscalno = @Period, lupd_datetime = GETDATE()
         
   WHERE docnbr = @DocNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_ProjectExpensePosted] TO [MSDSL]
    AS [dbo];

