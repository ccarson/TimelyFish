 /****** Object:  Stored Procedure dbo.LocTable_SID_InvtID_WLoc_Qty    Script Date: 4/17/98 10:58:18 AM ******/
/****** Object:  Stored Procedure dbo.LocTable_SID_InvtID_WLoc_Qty    Script Date: 4/16/98 7:41:52 PM ******/
Create Proc LocTable_SID_InvtID_WLoc_Qty @parm1 varchar (10), @parm2 varchar (30), @parm3 varchar (30), @parm4 varchar (30),@parm5 varchar (10) as
select location.* from loctable LT,location where LT.siteid = @parm1
and LT.SalesValid <> 'N' and ((LT.InvtIDValid = 'Y' and LT.InvtID = @parm2 and Location.invtid = @parm3)
or (LT.InvtIDValid <> 'Y' and Location.invtid = @parm4)) and LT.whseloc like @parm5
and LT.siteid = Location.siteid and LT.whseloc = Location.whseloc
Order by LT.WhseLoc


