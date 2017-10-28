 
/*
	Return the decimal places for base currency, base BMI currency, inventory setup cost and quantity
*/
Create View vr_SOPlanCheck
AS

	Select	Distinct
		InvtID, SiteID, WillPrint = 1
		From	SOPlan
		Where	Plantype In ('50','52', '60', '62', '64')	


 
