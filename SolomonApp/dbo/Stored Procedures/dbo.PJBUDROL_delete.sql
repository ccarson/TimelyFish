 create procedure PJBUDROL_delete @parm1 varchar (04) as
Delete from PJBUDROL
WHERE
fsyear_num <= @parm1


