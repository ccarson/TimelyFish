
/****** Created to view groups that may be closing    Script Date: 12/8/2004 8:28:18 PM ******/


CREATE       View cfv_PotentialClose (Company, Phase, Facility, Status, GroupID, PGDesc, Gender, Room, StartDate, DaysIn, 
		StartWgt, StartQty, CurrentInv, Mortality, Source, LstFeed, CloseDate, NoSold, ServiceManager)
 	AS
	Select ps.Company, ps.PhaseDesc, ps.FacilityType, ps.Status, ps.GroupID, ps.GroupDesc, ps.Gender, ps.RoomNbr, ps.StartDate, ps.DaysIn, 
	ps.StartWgt, ps.StartQty, ps.CurrentInv, ps.Mortality, ps.Source, ps.LastFeed, ps.CloseDate, ps.NoSold, ps.ContactName
	From cfv_PigGroupSummary ps
	Where ps.CurrentInv<25

