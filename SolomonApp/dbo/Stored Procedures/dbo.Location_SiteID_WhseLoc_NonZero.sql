 Create Proc Location_SiteID_WhseLoc_NonZero @parm1 varchar(10), @parm2 varchar(10) as
select * from Location
where 	SiteID = @parm1 and
	WhseLoc = @parm2 and (
	abs(QtyAlloc) >= 0.0000000005 or
	abs(QtyOnHand) >= 0.0000000005 or
	abs(QtyShipNotInv) >= 0.0000000005 or
	abs(QtyWORlsedDemand) >= 0.0000000005)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Location_SiteID_WhseLoc_NonZero] TO [MSDSL]
    AS [dbo];

