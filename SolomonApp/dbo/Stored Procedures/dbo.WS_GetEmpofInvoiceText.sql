
CREATE proc WS_GetEmpofInvoiceText @parm1 varchar(10) --Draft Number
AS  

    SELECT PJINVHDR.approver_id 
      FROM PJINVHDR JOIN PJINVTXT 
                      ON PJINVHDR.draft_num = PJINVTXT.draft_num
     WHERE PJINVTXT.draft_num = @parm1 AND PJINVTXT.text_type = 'I' --Invoice Text.


