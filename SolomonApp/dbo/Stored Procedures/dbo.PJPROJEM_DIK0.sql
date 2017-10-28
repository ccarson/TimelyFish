 create procedure PJPROJEM_DIK0  @parm1 varchar (10) as
delete from PJPROJEM
where Employee = @parm1

