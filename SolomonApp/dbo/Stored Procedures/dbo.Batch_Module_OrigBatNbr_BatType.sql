 
CREATE PROC Batch_Module_OrigBatNbr_BatType @Module varchar ( 2), @OrigBatNbr varchar ( 10), @BatType varchar(1) as
       SELECT * FROM Batch
           WHERE Module  = @Module
            AND OrigBatNbr  = @OrigBatNbr
            AND BatType = @BatType

