 Create Procedure PJTIMDET_SCOUNT @parm1 varchar (16)  as
select COUNT(*) from Pjtimdet
where
Pjtimdet.project = @parm1 and
Pjtimdet.tl_status <> 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_SCOUNT] TO [MSDSL]
    AS [dbo];

