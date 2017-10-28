 create procedure PJBSREV_sUnrel  @parm1 varchar (16)   as
select * from PJBSREV
where    PJBSREV.Project = @parm1
and PJBSREV.Rel_Status <> 'Y'


