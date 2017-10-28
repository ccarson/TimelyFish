 CREATE PROC scm_10990_Status_ItemSite_Remove @InvtID varchar(30), @siteID varchar(10), @user varchar(10) as

if @invtid = '%' and @siteid = '%'

	delete s from
	ItemSite s
	where s.Crtd_Prog = '10990' and
  	s.LUpd_Prog = '09901' and
  	s.Crtd_User = @user and
  	s.LUpd_User = @user and
  	s.Crtd_DateTime = LUpd_DateTime and
  	abs(s.QtyAlloc) < 0.0000000005 and
  	abs(s.QtyCustOrd) < 0.0000000005 and
  	abs(s.QtyInTransit) < 0.0000000005 and
  	abs(s.QtyNotAvail) < 0.0000000005 and
  	abs(s.QtyOnBO) < 0.0000000005 and
  	abs(s.QtyOnDP) < 0.0000000005 and
  	abs(s.QtyOnHand) < 0.0000000005 and
  	abs(s.QtyOnKitAssyOrders) < 0.0000000005 and
  	abs(s.QtyOnTransferOrders) < 0.0000000005 and
  	abs(s.QtyOnPO) < 0.0000000005 and
	abs(s.QtyShipNotInv) < 0.0000000005 and
	abs(s.QtyWOFirmDemand) < 0.0000000005 and
	abs(s.QtyWOFirmSupply) < 0.0000000005 and
	abs(s.QtyWORlsedDemand) < 0.0000000005 and
	abs(s.QtyWORlsedSupply) < 0.0000000005 and
	abs(s.TotCost) < 0.0000000005

else

	delete s from
	ItemSite s
	where s.InvtID like @InvtID and
  	s.SiteID like @SiteID and
  	s.Crtd_Prog = '10990' and
  	s.LUpd_Prog = '09901' and
  	s.Crtd_User = @user and
  	s.LUpd_User = @user and
  	s.Crtd_DateTime = LUpd_DateTime and
  	abs(s.QtyAlloc) < 0.0000000005 and
  	abs(s.QtyCustOrd) < 0.0000000005 and
  	abs(s.QtyInTransit) < 0.0000000005 and
  	abs(s.QtyNotAvail) < 0.0000000005 and
  	abs(s.QtyOnBO) < 0.0000000005 and
  	abs(s.QtyOnDP) < 0.0000000005 and
  	abs(s.QtyOnHand) < 0.0000000005 and
  	abs(s.QtyOnKitAssyOrders) < 0.0000000005 and
  	abs(s.QtyOnTransferOrders) < 0.0000000005 and
  	abs(s.QtyOnPO) < 0.0000000005 and
	abs(s.QtyShipNotInv) < 0.0000000005 and
	abs(s.QtyWOFirmDemand) < 0.0000000005 and
	abs(s.QtyWOFirmSupply) < 0.0000000005 and
	abs(s.QtyWORlsedDemand) < 0.0000000005 and
	abs(s.QtyWORlsedSupply) < 0.0000000005 and
	abs(s.TotCost) < 0.0000000005


