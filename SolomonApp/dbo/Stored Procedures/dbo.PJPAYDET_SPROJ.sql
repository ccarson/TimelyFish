 create procedure PJPAYDET_SPROJ  @parm1 varchar (16)  as
select * from PJPAYDET
where
PJPAYDET.project       =    @parm1


