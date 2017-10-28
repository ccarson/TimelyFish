 CREATE PROCEDURE IRFind_QtyOnHand @invtid varchar (30), @SiteId VarChar(10)
AS
-- Select  Sum(isnull(Qtyonhand,0)) as 'QOH' from itemsite where Invtid = @invtid and SiteId Like @SiteId
-- Use Location and LocTable to handle cases where some whselocs should not be counted.  Use the InclQtyAvail flag to tell this.  Do outer join, and use <> 0, so null and 1 are both accepted
-- Select  Sum(isnull(Qtyonhand,0)) as 'QOH' from Location,LocTable where Location.Invtid = @invtid and Location.SiteId Like @SiteId AND Location.SiteId *= LocTable.SiteId and Location.WhseLoc *= LocTable.WhseLoc and LocTable.InclQtyAvail <> 0
-- VM, 7/2/01, above line commented out because the qty was summed even when LocTable.InclQtyAvail = 0
SELECT SUM(isnull(QtyOnHand, 0)) as 'QOH'
	FROM Location
		LEFT OUTER JOIN LocTable On
		Location.SiteID = LocTable.SiteID
		AND Location.WhseLoc = LocTable.WhseLoc
	WHERE
		Location.InvtID = @InvtID
		AND Location.SiteID LIKE @SiteID
		AND IsNull(LocTable.InclQtyAvail,1) = 1

-- and ltrim(rtrim(siteid)) <> '5'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRFind_QtyOnHand] TO [MSDSL]
    AS [dbo];

