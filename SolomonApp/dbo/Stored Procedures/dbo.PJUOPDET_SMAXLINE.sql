 create procedure PJUOPDET_SMAXLINE  @parm1 varchar (10)   as
select max(linenbr) from PJUOPDET
where    docnbr     =  @parm1

