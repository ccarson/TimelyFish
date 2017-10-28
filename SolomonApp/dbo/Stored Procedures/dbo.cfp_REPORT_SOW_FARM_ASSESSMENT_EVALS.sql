


-- ======================================================================================
-- Author:	Nick Honetschlager
-- Create date:	4/18/2016
-- Description:	Evals. Converted to stored procedure from sql in a rdl.
-- Parameters: 	@pEvalID
--
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 

========================================================================================================
*/
CREATE PROCEDURE [dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_EVALS] 
@pEvalID int

AS

SELECT er.Eval_id
	,convert(varchar(12),ce.EvalDate,111) as 'Entered Date'
	,sc.ContactName as 'SiteName'
	,ce.SiteContactID
	,sm.ContactName as 'ServiceManager'
	,fq.Area
	,fq.Definition as 'Question'
	,fq.QuestionNbr
	,case when er.Answer = 0 then 'No' else 'Yes' end as 'Passing/Score'
	,er.Comments as 'Question Comments'
	,ce.comments as 'Form Comments'
	--,case when ce.EntryUserID = 'bdiehl' then '' else ce.EntryUserID end as CreatedBy
	, ce.EntryUserID as CreatedBy
	, ce.EntryUserID2 as Auditor2
from dbo.cft_Eval_Results er
inner join dbo.cft_Eval ce on ce.Eval_id=er.Eval_id and FormID = 13
inner join dbo.cft_Form_Ques fq on er.Question_id=fq.Question_id 
Inner join CentralData.dbo.Contact sc on ce.SiteContactID=sc.ContactID
Inner join CentralData.dbo.Contact sm on ce.SvcMgrContactID =sm.ContactID
where ce.Eval_id=@pEvalID
  and fq.definition not like '% BCS %' and fq.area not like '%Ulcer Score%'
  

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_EVALS] TO [MSDSL]
    AS [dbo];

