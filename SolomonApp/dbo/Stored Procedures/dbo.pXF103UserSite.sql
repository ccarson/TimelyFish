

CREATE   Procedure pXF103UserSite
	@parm1 varchar(47),
	@parm2 varchar(6)
As
Select *
From cftUserSitePerm
Where UserId=@parm1 AND SiteContactID Like @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF103UserSite] TO [MSDSL]
    AS [dbo];

