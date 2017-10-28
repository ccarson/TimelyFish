 Create Procedure PJLABHDR_SPK2 @parm1 varchar (10)  as
select * from PJLabhdr, pjemploy
where pjlabhdr.le_status =  'C' and
pjlabhdr.employee =  pjemploy.employee and
(pjemploy.manager1 = @parm1 or
pjemploy.manager2 = @parm1)
order by pjlabhdr.docnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABHDR_SPK2] TO [MSDSL]
    AS [dbo];

