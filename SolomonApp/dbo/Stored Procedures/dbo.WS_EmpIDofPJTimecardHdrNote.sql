
CREATE proc WS_EmpIDofPJTimecardHdrNote 
@parm1 int --Note ID
as  
Begin
select pjlabhdr.employee from PJlabHDR, snote where snote.nid = @parm1 and pjlabhdr.NoteId = snote.nID 
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJTimecardHdrNote] TO [MSDSL]
    AS [dbo];

