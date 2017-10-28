 Create Procedure LotSerMst_All_Active
AS
	Select *
	from LotSerMst
	where status = 'A'


