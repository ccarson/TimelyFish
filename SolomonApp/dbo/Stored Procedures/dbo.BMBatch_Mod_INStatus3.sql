 Create Proc BMBatch_Mod_INStatus3 @Module varchar ( 2) as
       Select * from Batch
           Where Module = @Module
             and Status IN ('B', 'S', 'I')
             and JrnlType = 'BM'
           order by BatNbr, Status


