 Create Proc Batch_Module_BatType_DD_Clrd as
    Select * from Batch where Module = 'PR' and BatType = 'N' and JrnlType = 'DD' and Cleared = 0 order by BatNbr


