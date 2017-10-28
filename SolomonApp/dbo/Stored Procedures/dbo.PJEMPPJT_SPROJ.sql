 create procedure PJEMPPJT_SPROJ  @parm1 varchar (16)   as
select * from PJEMPPJT
where    project     =   @parm1


