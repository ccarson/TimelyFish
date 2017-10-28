 create procedure PJEXPDET_SMAXLINE  @parm1 varchar (10)   as
select max(linenbr) from PJEXPDET
where    docnbr     =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_SMAXLINE] TO [MSDSL]
    AS [dbo];

