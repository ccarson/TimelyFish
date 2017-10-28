 Create Proc EDSite_Single @parm1 varchar(10), @parm2 varchar(3)  As Select * from EDSite where SiteID = @parm1 and Trans = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSite_Single] TO [MSDSL]
    AS [dbo];

