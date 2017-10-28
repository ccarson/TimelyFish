
CREATE proc WS_EmpIDofPJExpHdrNote 
@parm1 int --Note ID
as  
Begin
select pjexphdr.employee from PJEXPHDR, snote where snote.nid = @parm1 and pjexphdr.NoteId = snote.nID 
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_EmpIDofPJExpHdrNote] TO [MSDSL]
    AS [dbo];

