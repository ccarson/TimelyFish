--drop procedure dbo.cfp_PROCESS_LOG_INSERT

CREATE PROCEDURE [dbo].[cfp_PROCESS_LOG_INSERT]
(	@ProcessName varchar(200)
,	@StepName varchar(200)
,	@ProcessExecutedBy varchar(50)
,	@ProcessLogID bigint OUTPUT)
AS

insert into  dbo.cft_PROCESS_LOG (ProcessName, StepName, ProcessExecutedBy, ProcessStart, ProcessEnd)
values (@ProcessName, @StepName, @ProcessExecutedBy, GETDATE(), NULL)

select @ProcessLogID = max(ProcessLogID) from dbo.cft_PROCESS_LOG