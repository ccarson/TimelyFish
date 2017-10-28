 Create Procedure PJPROJ_SALL_Count
 @parm1 varchar (10) as

	select	count(*)
	from	pjproj
	where	project like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_SALL_Count] TO [MSDSL]
    AS [dbo];

