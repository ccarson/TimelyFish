 Create Procedure Select_VO_VM_APDocs @parm1 varchar ( 10) As
select * from apdoc
where s4future11 = 'VM'
and doctype = 'VO'
and MasterDocNbr = @parm1
order by refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Select_VO_VM_APDocs] TO [MSDSL]
    AS [dbo];

