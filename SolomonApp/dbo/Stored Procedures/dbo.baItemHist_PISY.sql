Create Procedure baItemHist_PISY @parm1 varchar (30), @parm2 varchar (10), @parm3 varchar (4) as 
    Select  * from ItemHist Where InvtId = @parm1 and SiteId = @parm2 and FiscYr < @parm3
	Order by InvtId, SiteId, FiscYr Desc

