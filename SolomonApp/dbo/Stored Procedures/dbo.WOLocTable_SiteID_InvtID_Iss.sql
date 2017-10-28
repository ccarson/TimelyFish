 CREATE PROCEDURE WOLocTable_SiteID_InvtID_Iss
	@Parm1		varchar(10),
	@Parm2		varchar(30),
	@Parm3		varchar(30),
	@Parm4		varchar(30),
	@Parm5		varchar(10)

As
	SELECT		location.*
	FROM		Loctable LT,location
	WHERE		LT.siteid = @parm1 and
			LT.WOIssueValid <> 'N' and
			((LT.InvtIDValid = 'Y' and LT.InvtID = @parm2 and Location.invtid = @parm3) or
			(LT.InvtIDValid <> 'Y' and Location.invtid = @parm4)) and
			LT.whseloc like @parm5 and
			LT.siteid = Location.siteid and
			LT.whseloc = Location.whseloc
	ORDER BY	LT.WhseLoc


