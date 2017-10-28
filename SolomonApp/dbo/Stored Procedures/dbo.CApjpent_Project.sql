 Create Procedure CApjpent_Project @Parm1 Varchar(16), @Parm2 Varchar(32) as
select * from PJPENT where project = @parm1
and pjt_entity like @parm2 and status_pa = 'A'
order by project, pjt_entity


