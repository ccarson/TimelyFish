
CREATE proc WS_EmpIDofPJTimesheetProdDetNote 
@parm1 int --Note ID
as  
Begin
  SELECT PJTIMHDR.preparer_id 
    FROM PJTIMHDR JOIN PJUOPDET
                    ON PJTIMHDR.docnbr = PJUOPDET.docnbr
                  JOIN snote 
                    ON PJUOPDET.noteid = snote.nID
   WHERE snote.nid = @parm1 
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJTimesheetProdDetNote] TO [MSDSL]
    AS [dbo];

