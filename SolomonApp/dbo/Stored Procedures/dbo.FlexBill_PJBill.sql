
Create Proc FlexBill_PJBill @parm1 varchar (16) as

SELECT approval_sw, approver, inv_attach_cd, inv_format_cd, last_bill_date, project
  FROM PJBILL 
 WHERE project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FlexBill_PJBill] TO [MSDSL]
    AS [dbo];

