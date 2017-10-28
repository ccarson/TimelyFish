 Create Proc Batch_Control_PV
   @Parm1 Char(2),
   @Parm2 Char(10),
   @Parm3 Char(10)
as

Select * From Batch
   Where Module = @Parm1
         And Cpnyid = @Parm2
         And BatNbr LIKE @Parm3
         And Rlsed = 1
         And ((Status IN ('P', 'C', 'U') and Module <> 'PO') or (Status = 'C' and Module = 'PO'))
   Order By BatNbr


