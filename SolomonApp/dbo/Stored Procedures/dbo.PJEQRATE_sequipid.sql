 create procedure PJEQRATE_sequipid @parm1 varchar (10) , @parm2 varchar (16) , @parm3beg smalldatetime , @parm3end smalldatetime  as
select *
	from PJEQRATE
		left outer join PJPROJ
			on PJEQRATE.project = PJPROJ.project
	where PJEQRATE.equip_id = @parm1 and
		PJEQRATE.project like @parm2 and
		(PJEQRATE.effect_date  between @parm3beg and @parm3end)
	order by PJEQRATE.equip_id, PJEQRATE.project, PJEQRATE.effect_date


