 create procedure PJLABDET_SPK0  @parm1 varchar (10) , @parm2 smallint   as
select * from PJLABDET
where    docnbr     =  @parm1 and
linenbr = @parm2
order by docnbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_SPK0] TO [MSDSL]
    AS [dbo];

