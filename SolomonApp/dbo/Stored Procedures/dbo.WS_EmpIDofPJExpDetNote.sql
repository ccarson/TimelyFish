
CREATE proc WS_EmpIDofPJExpDetNote 
@parm1 int --Note ID
as  
Begin
select pjexphdr.employee from PJEXPHDR, PJEXPDET, snote where snote.nid = @parm1 and pjexpdet.NoteId = snote.nID and pjexpdet.docnbr = pjexphdr.docnbr 
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJExpDetNote] TO [MSDSL]
    AS [dbo];

