 create procedure PJPROJEM_DEMPPROJ  @parm1 varchar (10), @parm2 varchar (16) as
delete from PJPROJEM
where Employee = @parm1 and
Project = @parm2

