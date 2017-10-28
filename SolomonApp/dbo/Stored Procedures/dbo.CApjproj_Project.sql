 CREATE Procedure CApjproj_Project @Parm1 Varchar(16) as
select * from PJPROJ where project like @parm1 and status_pa = 'A'  order by project


