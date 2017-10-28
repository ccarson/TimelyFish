 --- DCR added 5/6/98
--- DCR removed status = 'V' 12/17/98
Create Proc Select_03030_Batch @parm1 varchar(10), @parm2 varchar ( 10) as
       Select * from Batch
           where CpnyID = @parm1
                 and ((EditScrnNbr = '03030' and status in ('B','C','H','P','S','U'))
				OR (EditScrnNbr = '03620'and status in ('C','P','U')))
             and module = 'AP'
		 and BatNbr like @parm2
		 and BatNbr not in (Select BatNbr from APDoc where Status = 'T')
           order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Select_03030_Batch] TO [MSDSL]
    AS [dbo];

