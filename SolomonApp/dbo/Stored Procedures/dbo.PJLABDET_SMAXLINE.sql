 create procedure PJLABDET_SMAXLINE  @parm1 varchar (10)   as
select max(linenbr) from PJLABDET
where    docnbr     =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_SMAXLINE] TO [MSDSL]
    AS [dbo];

