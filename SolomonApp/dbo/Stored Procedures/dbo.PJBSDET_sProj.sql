 create procedure PJBSDET_sProj  @parm1 varchar (16)  as
select * from PJBSDET
where    PJBSDET.Project = @parm1


