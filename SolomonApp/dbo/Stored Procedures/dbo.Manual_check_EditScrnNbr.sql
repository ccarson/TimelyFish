 Create Proc Manual_check_EditScrnNbr @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select * from Batch
           where (EditScrnNbr = '02040' OR EditScrnNbr = '02630' OR EditScrnNbr = '02635')
             and module = 'PR'
             and CpnyId like @parm1
             and BatNbr like @parm2
             and Status <> 'K'
             and Status <> 'R'
             order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Manual_check_EditScrnNbr] TO [MSDSL]
    AS [dbo];

