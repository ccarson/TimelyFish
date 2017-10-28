
create proc Project_Mask_Contains_Multiple_Currencies 
			@parm1 varchar(10)
as

select case when
   (SELECT count(distinct ProjCuryId) 
	FROM pjproj 
	WHERE project like @parm1) > 1
THEN 1
ELSE 0
END as Result


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Project_Mask_Contains_Multiple_Currencies] TO [MSDSL]
    AS [dbo];

