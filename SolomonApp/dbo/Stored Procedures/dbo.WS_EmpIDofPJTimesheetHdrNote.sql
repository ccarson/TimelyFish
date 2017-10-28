
CREATE proc WS_EmpIDofPJTimesheetHdrNote 
@parm1 int --Note ID
as  
Begin
  SELECT PJTIMHDR.preparer_id 
    FROM PJTIMHDR JOIN snote 
                    ON PJTIMHDR.noteid = snote.nID 
   WHERE snote.nid = @parm1
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJTimesheetHdrNote] TO [MSDSL]
    AS [dbo];

