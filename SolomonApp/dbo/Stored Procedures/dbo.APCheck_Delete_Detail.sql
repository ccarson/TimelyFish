 ---DCR rollover from 2.5 7/5/98
Create Procedure APCheck_Delete_Detail @parm1 varchar ( 255) as
Select * from APDoc where DocClass = 'C' and PerClosed <= @parm1 and Perclosed <> ' '
Order by DocClass, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APCheck_Delete_Detail] TO [MSDSL]
    AS [dbo];

