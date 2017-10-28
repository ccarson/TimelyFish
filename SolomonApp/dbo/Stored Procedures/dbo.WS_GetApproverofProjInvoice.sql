CREATE proc WS_GetApproverofProjInvoice @parm1 varchar(10) --Draft Nbr
AS  
   select approver_id from PJINVHDR where draft_num = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_GetApproverofProjInvoice] TO [MSDSL]
    AS [dbo];

