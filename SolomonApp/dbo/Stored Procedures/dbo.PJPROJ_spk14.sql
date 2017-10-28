 create procedure [dbo].[PJPROJ_spk14] @parm1 varchar (4), @parm2 varchar(16)  as
select * from PJPROJ
where  status_pa  =    'A'
and PJPROJ.ProjCuryId = @parm1
and project    like @parm2
order by project

