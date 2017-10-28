


-- =============================================
-- Author:		Matt Brandt
-- Create date: 10/08/2010
-- Description:	This function projects the expected weight of a pig given a starting weight and the number of days
-- to project.  The number of days can be negative to find how much smaller the pig would have been a certain number of days ago.
-- 20110817 sripley, removed the temp table, load, and replaced with cft_BaseDay table.  performance reasons for ssrs report (Marketing distribution)
-- =============================================
CREATE FUNCTION [dbo].[cffn_GROWTH_CURVE_CALCULATOR] 
(@StartWeight Float, @GrowthDays Int)
RETURNS Float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @FinalWeight Float
	Declare @TargetDay Int
	Declare @BaseWeight Float

Set @TargetDay = (Select Top 1 BaseDay From cft_BaseDay Where BaseWeight >= @StartWeight Order By BaseDay)
Set @BaseWeight = (Select BaseWeight From cft_BaseDay Where BaseDay = @TargetDay)

	Select @FinalWeight = 
		Case When @StartWeight < 13.4 Then Null
			When @StartWeight > 400 Then Null
			When @GrowthDays = 0 Then @StartWeight
		Else (+.00000000112727959858*Power(Cast((@TargetDay+@GrowthDays) as Float),5)
		-.00000061832868927803*Power(Cast((@TargetDay+@GrowthDays) as Float),4)
		+.0000780882571955743*Power(Cast((@TargetDay+@GrowthDays) as Float),3)
		+.00491088524256611*Power(Cast((@TargetDay+@GrowthDays) as Float),2)
		+.583106762875104*(@TargetDay+@GrowthDays)
		+12.9792372275697) 
		+ (@StartWeight-@BaseWeight) 
		End
			
Return @FinalWeight

End


