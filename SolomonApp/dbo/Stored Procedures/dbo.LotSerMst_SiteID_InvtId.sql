Create Proc LotSerMst_SiteID_InvtId
@parm1 varchar ( 10), 
@parm2 varchar ( 30),
@parm3 varchar ( 1) as

Declare @ExecStr as varchar (1000)
Declare @OrderByStr as varchar (100)

Set @OrderByStr = Case @parm3
					When 'E' Then ' Order by SiteID, WhseLoc, InvtID, Expdate, LotSerNbr'
					When 'L' Then ' Order by SiteID, WhseLoc, InvtID, LIFOdate desc, LotSerNbr desc'
					When 'F' Then ' Order by SiteID, WhseLoc, InvtID, RcptDate, LotSerNbr'
					Else ' Order by SiteID, WhseLoc, InvtID, LotSerNbr'
				End
Set @ExecStr = 'Select InvtId, QtyAlloc, QtyAvail, SiteId, WhseLoc, LotSerNbr from LotSerMst where SiteID = ' + '''' + @parm1 + '''' + ' and InvtId = ' + '''' + @parm2 + '''' + ' and Status = ''A''' + rtrim(@OrderByStr)

Exec (@ExecStr)
