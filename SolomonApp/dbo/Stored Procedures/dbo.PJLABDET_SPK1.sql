 create procedure PJLABDET_SPK1  @parm1 varchar (10)   as
select * from PJLABDET
where    docnbr     =  @parm1
order by docnbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_SPK1] TO [MSDSL]
    AS [dbo];

