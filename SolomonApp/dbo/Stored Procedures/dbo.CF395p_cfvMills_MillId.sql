Create Procedure CF395p_cfvMills_MillId @parm1 varchar (6) as 
    Select v.* from cfvMills v Join cftMillSite s on v.MillId = s.MillId
	Where v.MillId Like @parm1
	Order by v.MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF395p_cfvMills_MillId] TO [MSDSL]
    AS [dbo];

