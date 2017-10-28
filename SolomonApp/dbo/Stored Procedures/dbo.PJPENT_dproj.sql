 create procedure PJPENT_dproj @parm1 varchar (16)   as
delete from PJPENT
where PJPENT.project =  @parm1


