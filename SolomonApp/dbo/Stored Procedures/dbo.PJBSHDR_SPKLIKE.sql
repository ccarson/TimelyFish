 create procedure PJBSHDR_SPKLIKE  @parm1 varchar (16) , @parm2 varchar (6)   as
select * from PJBSHDR
where    project     LIKE @parm1 and
schednbr LIKE @parm2
order by project, schednbr


