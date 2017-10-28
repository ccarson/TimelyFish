
-- =============================================
-- Author:		Amy Schimmelpfennig
-- Create date: 12/2/2013
-- Description:	Returns results from the BioSecurity Audit Questions
-- =============================================
CREATE PROCEDURE [dbo].[cfp_report_EvalScore_Bio] 
	@begin_date datetime,
	@end_date datetime
AS

-- =============================================
	--Report Data
-- =============================================

SELECT SiteName, ServiceMgr, avg(EvalScore) as 'AvgEvalScore', count(entrydate) as '#ofEvals'
FROM ( SELECT
		  ct.contactid,
		  ct.contactname as 'SiteName',
		  rTrim(svc.contactname) as 'ServiceMGR',
		  se.entrydate,
		  sum(answer+0) as 'EvalScore'
		  --convert(varchar,Year(entrydate)) +  replicate('0', 2 - datalength(convert(varchar,MONTH(entrydate)))) + convert(varchar,MONTH(entrydate))  as Period
				FROM [$(CentralData)].dbo.Site s 
						INNER JOIN [$(CentralData)].dbo.Contact ct on ct.contactid=s.contactid and ct.statustypeid=1 and s.facilitytypeid in (2,5,6)
						LEFT JOIN [$(SolomonApp)].dbo.cft_Eval se on se.sitecontactid=ct.contactid
						LEFT JOIN [$(SolomonApp)].dbo.cft_Eval_Results ser on se.eval_id=ser.eval_id
						LEFT JOIN [$(SolomonApp)].dbo.cftContact svc on se.SvcMgrContactID = svc.ContactID and svc.ContactID not in (85, 67, 3721) -- Harris, Gifford, Ebert
				WHERE ct.contactname is not null
				AND se.EntryDate between @begin_date and @end_date 
				--AND entrydate >= getdate()-90 
				AND se.FormID = 7 
				AND s.pigsystemid<>1-- Ignore Multiplication PigSystems
				GROUP BY ct.contactid, ct.contactname, rTrim(svc.contactname),se.entrydate,
							   convert(varchar,Year(entrydate)) +  replicate('0', 2 - datalength(convert(varchar,MONTH(entrydate)))) + convert(varchar,MONTH(entrydate))) a
GROUP BY SiteName, ServiceMgr
ORDER BY SiteName, ServiceMgr



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_EvalScore_Bio] TO [db_sp_exec]
    AS [dbo];

