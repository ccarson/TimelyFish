 Create Proc Adjustment_Batch_Cpnyid
     @parm1 varchar ( 10),
     @Parm2 Varchar ( 10)
as
     Select * from Batch
        where EditScrnNbr IN  ('10030','10397','10530','11530')
          And Cpnyid = @Parm1
          And BatNbr like @parm2
     Order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Adjustment_Batch_Cpnyid] TO [MSDSL]
    AS [dbo];

