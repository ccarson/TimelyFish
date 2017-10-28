 Create Proc  Batch_PR_Checks as
       Select * from Batch
           where Module      =   'PR'
             and EditScrnNbr IN  ('02040', '02070', '02630')
           order by Module ,
                    BatNbr ,
                    Status


