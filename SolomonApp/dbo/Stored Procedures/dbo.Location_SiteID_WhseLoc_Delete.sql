 Create Proc Location_SiteID_WhseLoc_Delete @parm1 varchar(10), @parm2 varchar(10) as
delete from Location
where 	SiteID = @parm1 and
	WhseLoc = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_SiteID_WhseLoc_Delete] TO [MSDSL]
    AS [dbo];

