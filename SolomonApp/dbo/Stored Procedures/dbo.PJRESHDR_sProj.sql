 create procedure PJRESHDR_sProj @parm1 varchar (16)   as
select * from PJRESHDR
where project =  @parm1


