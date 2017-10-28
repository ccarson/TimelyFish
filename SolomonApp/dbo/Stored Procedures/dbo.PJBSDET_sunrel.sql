 create procedure PJBSDET_sunrel  @parm1 varchar (16) ,  @parm2 varchar (6)  as
select * from PJBSDET
where    PJBSDET.Project = @parm1
and PJBSDET.Schednbr= @parm2
and PJBSDET.Rel_Status <> 'Y'
order by project, schednbr


