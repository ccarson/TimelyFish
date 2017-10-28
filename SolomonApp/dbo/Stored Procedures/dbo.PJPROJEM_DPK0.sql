 create procedure PJPROJEM_DPK0  @parm1 varchar (16) as
delete from PJPROJEM
where Project = @parm1

