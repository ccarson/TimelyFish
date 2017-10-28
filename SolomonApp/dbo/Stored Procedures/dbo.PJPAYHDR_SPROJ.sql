 create procedure PJPAYHDR_SPROJ  @parm1 varchar (16)   as
select * from PJPAYHDR
where
PJPAYHDR.project    =    @parm1


