 CREATE procedure [dbo].[smPJPROJ_spk1_CpnyID]
	@parm1 varchar (15)
	,@parm2 varchar(10)
	,@parm3 varchar(16)

as
--Customer ID Uses a "LIKE" comparison operator because it may contain a % in SD30300 Service Call Lookup
--This SQL cannot be dynamically generated because it is used the ProjectID PV in SD30300 and the PVREC wouldn't match

	select * from PJPROJ
where
--	customer LIKE @parm1
--		AND
--	cpnyid = @parm2
--		AND
	project like @parm3
		AND
	status_pa  =    "A"
	order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smPJPROJ_spk1_CpnyID] TO [MSDSL]
    AS [dbo];

