 CREATE PROCEDURE WOPJTran_Prj_FiscalNo
   @Project    varchar( 16 ),
   @FiscalNo   varchar( 6 )

AS
   SELECT      *
   FROM        PJTran
   WHERE       Project = @Project and
               FiscalNo = @FiscalNo and
               Batch_Type <> 'ALLC' and
               Alloc_Flag = ' '
   ORDER BY    Project, PJT_Entity, Acct, Trans_Date



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJTran_Prj_FiscalNo] TO [MSDSL]
    AS [dbo];

