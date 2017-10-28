 create procedure PJTIMDET_SMAXLINE  @parm1 varchar (10)   as
select max(linenbr) from PJTIMDET
where    docnbr     =  @parm1

