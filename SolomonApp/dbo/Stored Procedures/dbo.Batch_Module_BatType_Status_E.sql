 Create Proc Batch_Module_BatType_Status_E as
    Select * from Batch where Module = 'PR' and BatType = 'N' and Status IN('R','K') and EditScrnNbr = '02630' order by BatNbr


