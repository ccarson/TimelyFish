

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 5/17/2012
-- Description:	Returns Removals by Period and Site
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_REMOVAL_SITE_remove]
(
	
	 @StFYPeriod		char(7),
	 @EnFYPeriod		char(7)

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select 
	RIGHT(FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(FiscalPeriod))) as 'FYPeriod',
	ContactName, 
	Case when Parity >= 7 then 7 else Parity end as 'Parity', 
	RemovalType, 
	PrimaryReason,
	Sum(HeadCount) as 'Removal'
	from  dbo.cft_SOW_REMOVAL 
	where ContactID not in ('002286','001455','002287')
	and RIGHT(FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(FiscalPeriod))) between @StFYPeriod and @EnFYPeriod
	group by 
	FiscalPeriod, 
	FiscalYear, 
	ContactID, 
	ContactName, 
	Case when Parity >= 7 then 7 else Parity end, 
	RemovalType,
	PrimaryReason
	
END


