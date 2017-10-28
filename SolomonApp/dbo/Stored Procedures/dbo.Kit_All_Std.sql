 Create Proc Kit_All_Std @Parm1 varchar ( 30) as
            Select *
                From Kit K Join Inventory I
                         On K.KitId = I.InvtId
                Where K.KitId like @Parm1
                  And I.ValMthd = 'T'
                Order By KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Kit_All_Std] TO [MSDSL]
    AS [dbo];

