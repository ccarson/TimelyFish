CREATE proc WS_GetApproverofProjInvHdrNote @parm1 int --Note ID
AS  
   SELECT p.approver_id 
     FROM PJINVHDR p JOIN SNote s
                     ON p.NoteId = s.nID
    WHERE s.nid = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetApproverofProjInvHdrNote] TO [MSDSL]
    AS [dbo];

