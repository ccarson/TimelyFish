

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 5/17/2012
-- Description:	Returns Removals by Period and Site
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SOW_REMOVAL_PARITY_remove]
(
	
	 @StFYPeriod		char(7),
	 @EnFYPeriod		char(7)

   
)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Declare @RP Table
	(FiscalPeriod smallint
	,FiscalYear smallint
	,RemovalType varchar(20)
	,Removal int
	,Parity int)
	
	Insert Into @RP
	
	Select 
	FiscalPeriod, 
	FiscalYear, 
	RemovalType, 
	Sum(HeadCount) as 'Removal',
	Case when Parity >= 7 then 7 else Parity end as 'Parity'
	from  dbo.cft_SOW_REMOVAL 
	where ContactID not in ('002286','001455','002287')
	group by 
	FiscalPeriod, 
	FiscalYear, 
	RemovalType,
	Case when Parity >= 7 then 7 else Parity end
		
	Select 
	RIGHT(r.FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(r.FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(r.FiscalPeriod))) as 'FYPeriod',
	r.Parity, 
	r.RemovalType, 
	ParityPercent = Cast(Cast(r.Removal as decimal(10,6))/Cast((Select Sum(Removal) from @RP 
	where r.FiscalYear = FiscalYear and r.FiscalPeriod = FiscalPeriod and r.RemovalType = RemovalType) as decimal(10,6)) as decimal(10,6))
	from @RP r
	Where RIGHT(r.FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(r.FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(r.FiscalPeriod))) between @StFYPeriod and @EnFYPeriod
	order by
	RIGHT(r.FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(r.FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(r.FiscalPeriod))),
	r.Parity, 
	r.RemovalType
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_REMOVAL_PARITY_remove] TO [db_sp_exec]
    AS [dbo];

