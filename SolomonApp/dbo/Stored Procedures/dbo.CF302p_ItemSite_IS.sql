Create Procedure CF302p_ItemSite_IS @parm1 varchar (30), @parm2 varchar (10) as 
    Select * from ItemSite Where InvtId = @parm1 and SiteId = @parm2
