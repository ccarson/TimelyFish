 create procedure PJSUBDET_SPK1  @parm1 varchar (16) , @parm2 varchar (16)   as
select  *       from PJSUBDET
where
PJSUBDET.project       =    @parm1 and
PJSUBDET.subcontract   =    @parm2
order by PJSUBDET.project, PJSUBDET.subcontract, PJSUBDET.sub_line_item



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_SPK1] TO [MSDSL]
    AS [dbo];

