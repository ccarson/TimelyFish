 create procedure PJEXPDET_SALL  @parm1 varchar (10) , @parm2beg smallint , @parm2end smallint   as
select * from PJEXPDET, PJEXPTYP
where    PJEXPDET.docnbr  =  @parm1 and
PJEXPDET.linenbr  between  @parm2beg and @parm2end  and
PJEXPDET.exp_type = PJEXPTYP.exp_type
order by PJEXPDET.docnbr, PJEXPDET.linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_SALL] TO [MSDSL]
    AS [dbo];

