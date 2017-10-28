 Create Proc Comp_Kit_Site_SubKitStat @parm1 varchar ( 30),@parm2 varchar ( 10),@parm3 varchar ( 1)  as
        Select Kit.* from Kit where
        Kit.Kitid = @parm1 and Kit.Siteid = @parm2 and
        Kit.status = @parm3
         Order by Kit.Kitid, Kit.Siteid, Kit.Status
-- KMT: Find valid sites for a selected BMID.
-- Used in 11.010 as PV for Site ID.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_Site_SubKitStat] TO [MSDSL]
    AS [dbo];

