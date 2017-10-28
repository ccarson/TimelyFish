 create procedure PJBSHDR_sPJGLSUB  @parm1 varchar (16) , @parm2 varchar (24) , @parm3 varchar (10) as
select * from PJBSHDR, PJPROJ
where    PJBSHDR.project  = PJPROJ.project
and PJBSHDR.project like @parm1
and PJPROJ.gl_subacct like @parm2
and PJBSHDR.CpnyId like @parm3
order by PJBSHDR.project, PJBSHDR.schednbr


