
/****** Object:  Stored Procedure Inventory by date    Script Date: 1/14/2005 12:23:20 PM ******/
CREATE  Procedure CFINVREPORT @parm1 datetime as 
	SELECT cfv_PigGroup_InvDate.Company, cfv_PigGroup_InvDate.PhaseDesc, cfv_PigGroup_InvDate.FacilityType, cfv_PigGroup_InvDate.SiteName, cfv_PigGroup_InvDate.Status, cfv_PigGroup_InvDate.GroupID, cfv_PigGroup_InvDate.GroupDesc, cfv_PigGroup_InvDate.Gender, cfv_PigGroup_InvDate.StartDate, cfv_PigGroup_InvDate.StartWgt, cfv_PigGroup_InvDate.StartQty, cfv_PigGroup_InvDate.Capacity, cfv_PigGroup_InvDate.CurrentInv, cfv_PigGroup_InvDate.State, cfv_PigGroup_InvDate.Ownership, Sum(cfv_PigGroup_InvDate.Qty) AS 'Qty through Entered Date' 
	From cfv_PigGroup_InvDate
	WHERE cfv_PigGroup_InvDate.TranDate<=@parm1
	GROUP BY cfv_PigGroup_InvDate.Company, cfv_PigGroup_InvDate.PhaseDesc, cfv_PigGroup_InvDate.FacilityType, cfv_PigGroup_InvDate.SiteName, cfv_PigGroup_InvDate.Status, cfv_PigGroup_InvDate.GroupID, cfv_PigGroup_InvDate.GroupDesc, cfv_PigGroup_InvDate.Gender, cfv_PigGroup_InvDate.StartDate, cfv_PigGroup_InvDate.StartWgt, cfv_PigGroup_InvDate.StartQty, cfv_PigGroup_InvDate.Capacity, cfv_PigGroup_InvDate.CurrentInv, cfv_PigGroup_InvDate.State, cfv_PigGroup_InvDate.Ownership
