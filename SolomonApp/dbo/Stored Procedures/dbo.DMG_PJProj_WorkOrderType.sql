 create proc DMG_PJProj_WorkOrderType
	@WONbr		varchar( 16 )
	AS
	Select		Status_20			-- WO Type - M, R, P
	From		PJProj
	Where		Project = @WONbr


