CREATE proc WS_GetApproverofProjInvDetNote @parm1 int --Note ID
AS  
   SELECT p.approver_id 
     FROM PJINVDET d JOIN PJINVHDR p 
                       ON d.draft_num = p.draft_num
                     JOIN SNote s
                     ON d.NoteId = s.nID
    WHERE s.nid = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetApproverofProjInvDetNote] TO [MSDSL]
    AS [dbo];

