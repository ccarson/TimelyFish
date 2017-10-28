 create procedure PJLABDET_SALL  @parm1 varchar (10) , @parm2beg smallint , @parm2end smallint   as
select * from PJLABDET
where    docnbr     =  @parm1 and
linenbr  between  @parm2beg and @parm2end
order by docnbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_SALL] TO [MSDSL]
    AS [dbo];

