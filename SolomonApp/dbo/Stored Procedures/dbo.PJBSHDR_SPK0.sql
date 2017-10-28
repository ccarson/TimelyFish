 create procedure PJBSHDR_SPK0  @parm1 varchar (16) , @parm2 varchar (6)   as
select * from PJBSHDR
where    project = @parm1 and
schednbr = @parm2
order by project, schednbr


