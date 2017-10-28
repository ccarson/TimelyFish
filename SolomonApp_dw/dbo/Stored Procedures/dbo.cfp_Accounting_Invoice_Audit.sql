










CREATE  PROCEDURE [dbo].[cfp_Accounting_Invoice_Audit]
	-- Add the parameters for the stored procedure here
	@BgDateRng DATETIME,
	@EnDateRng DATETIME,
	@LOG char(1)='Y'
AS
BEGIN
/*
===============================================================================
Purpose: 

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec [$(CFFDB)].dbo.cfp_PrintTs  'start 1'
exec 
exec [$(CFFDB)].dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-02-14  sripley		Initial build

===============================================================================
*/

-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-------------------------------------------------------------------------------
-- Declare standard variables
-------------------------------------------------------------------------------
DECLARE @RowCount               INT
DECLARE @StepMsg                VARCHAR(255)
DECLARE @DatabaseName           NVARCHAR(128)
DECLARE @ProcessName            VARCHAR(50)
DECLARE @ProcessStatus          INT
DECLARE @RecordsProcessed       BIGINT
DECLARE @Comments               VARCHAR(2000)
DECLARE @Error                  INT
DECLARE @Criteria               VARCHAR(2000)
declare @StartDate DATETIME
declare @EndDate DATETIME


-------------------------------------------------------------------------------
-- Set standard variables
-------------------------------------------------------------------------------
SET @DatabaseName       = db_name()
SET @ProcessName        = 'cfp_Accounting_Invoice_Audit'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
-------------------------------------------------------------------------------
-- Create temp table
-------------------------------------------------------------------------------

create table #crtd_audit_log
(crtd_user char(10) null,
 crtd_inv_cnt smallint null,
 crtd_line_cnt smallint null)
 
create table #lupd_audit_log
(lupd_user char(10) null,
 lupd_inv_cnt smallint null,
 lupd_line_cnt smallint null)
 
 
-------------------------------------------------------------------------------
--  Insert rows where the crtd_datetime is in range
-------------------------------------------------------------------------------

insert into #crtd_audit_log
select  t.Crtd_User, count(distinct(d.invcnbr)), count(t.lineref)
from [$(SolomonApp)].dbo.APDoc d (nolock)
join [$(SolomonApp)].dbo.APTran t (nolock) on d.batnbr = t.batnbr and d.refnbr = t.refnbr
where t.acct <> '20000'
and t.Crtd_DateTime between @BgDateRng and @EnDateRng
group by  t.Crtd_user
order by  t.Crtd_user

-------------------------------------------------------------------------------
--  Insert rows where the lupd_datetime is in range
-------------------------------------------------------------------------------

insert into #lupd_audit_log
select  t.LUpd_User, count(distinct(d.invcnbr)), count(t.lineref)
from [$(SolomonApp)].dbo.APDoc d (nolock)
join [$(SolomonApp)].dbo.APTran t (nolock) on d.batnbr = t.batnbr and d.refnbr = t.refnbr
where t.acct <> '20000'
and t.LUpd_DateTime between @BgDateRng and @EnDateRng
group by  t.LUpd_User
order by  t.LUpd_User

-------------------------------------------------------------------------------
--  select data for report
-------------------------------------------------------------------------------

select  crtd_user, crtd_inv_cnt, crtd_line_cnt, lupd_inv_cnt, lupd_line_cnt 
from #crtd_audit_log
left outer join #lupd_audit_log on lupd_user = crtd_user


		SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
END
-------------------------------------------------------------------------------
-- If the procedure gets to here, it is a successful run
-- NOTE: Make sure to capture @RecordsProcessed from your main query
-------------------------------------------------------------------------------
SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'

-------------------------------------------------------------------------------
-- Log the end of the procedure
-------------------------------------------------------------------------------
TheEnd:
SET @EndDate = GETDATE()
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
EXEC [$(CFFDB)].dbo.cfp_PrintTs 'End'
RAISERROR (@Comments, @ProcessStatus, 1)

RETURN @ProcessStatus

-------------------------------------------------------------------------------
-- Error handling
-------------------------------------------------------------------------------
ERR_Common:
    SET @Comments         = 'Error in step: ' + @StepMsg

    SET @ProcessStatus    = 16
    SET @RecordsProcessed = 0
    GOTO TheEnd					

	  







