
CREATE proc WS_EmpIDofPJTimecardDetNote 
@parm1 int --Note ID
as  
Begin
select pjlabhdr.employee from PJlabHDR, PJlabDET, snote where snote.nid = @parm1 and pjlabdet.NoteId = snote.nID and pjlabdet.docnbr = pjlabhdr.docnbr 
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJTimecardDetNote] TO [MSDSL]
    AS [dbo];

