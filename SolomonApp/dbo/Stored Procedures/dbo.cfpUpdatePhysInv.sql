

CREATE  procedure cfpUpdatePhysInv @parm1 varchar(15) as

update p
	set p.bookqty = i.qtyonhand, 
	p.unitcost = i.avgcost, 
	p.extcostvariance = round((p.PhysQty-i.qtyonhand)*i.avgcost,2)
from pidetail p
JOIN itemsite i ON p.invtid = i.invtid AND p.siteid = i.siteid
where p.piid = @parm1

