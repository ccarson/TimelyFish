
CREATE proc WS_EmpIDofPJTimesheetDetNote 
@parm1 int --Note ID
as  
Begin
  SELECT PJTIMHDR.preparer_id 
    FROM PJTIMHDR JOIN PJTIMDET
                    ON PJTIMHDR.docnbr = PJTIMDET.docnbr
                  JOIN snote 
                    ON PJTIMDET.noteid = snote.nID
   WHERE snote.nid = @parm1 
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJTimesheetDetNote] TO [MSDSL]
    AS [dbo];

