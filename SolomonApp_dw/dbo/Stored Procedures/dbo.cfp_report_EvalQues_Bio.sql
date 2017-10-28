


-- =============================================
-- Author:		Amy Schimmelpfennig
-- Create date: 12/2/2013
-- Description:	Returns results from the BioSecurity Audit Questions
-- =============================================
CREATE PROCEDURE [dbo].[cfp_report_EvalQues_Bio] 
	@begin_date datetime,
	@end_date datetime
AS

-- =============================================
	--Report Data-- Shows Question results between a specific period of time
-- =============================================

Select distinct
	 q.Question_id as 'Q id'
	,q.Definition as 'Question'
	,q.Area as 'Category'
	,isnull(er.Answer,0) as 'Yes'
	,erall.Answer as 'Total'
	,(round(100 *(isnull(er.answer,0))/(erall.answer),1)) as 'Percent'

FROM [$(SolomonApp)].dbo.cft_Form_Ques q
	LEFT JOIN (Select q1.Question_id, q1.Area, q1.Definition,count(er1.Answer) answer from [$(SolomonApp)].dbo.cft_Form_Ques q1
	LEFT JOIN [$(SolomonApp)].dbo.cft_Eval_Results er1 (NOLOCK) on er1.Question_id = q1.Question_id
		LEFT JOIN [$(SolomonApp)].dbo.cft_Eval ev (NOLOCK) on ev.Eval_id = er1.Eval_id
		WHERE q1.FormID = 7 AND q1.status = 'A' AND er1.Answer = 1
		AND ev.EntryDate between @begin_date and @end_date
		GROUP BY q1.Question_id, q1.Area, q1.Definition) er on er.question_id = q.question_id

	LEFT JOIN (Select q1.Question_id, q1.Area, q1.Definition,count(er1.Answer) answer from [$(SolomonApp)].dbo.cft_Form_Ques q1
	LEFT JOIN [$(SolomonApp)].dbo.cft_Eval_Results er1 (NOLOCK) on er1.Question_id = q1.Question_id
	LEFT JOIN [$(SolomonApp)].dbo.cft_Eval ev (NOLOCK) on ev.Eval_id = er1.Eval_id
		WHERE q1.FormID = 7 AND q1.status = 'A'
		AND ev.EntryDate between @begin_date and @end_date
		GROUP BY q1.Question_id, q1.Area, q1.Definition) erall on erall.question_id = q.question_id
	
	LEFT JOIN [$(SolomonApp)].dbo.cft_Eval_Results evalr (NOLOCK) on evalr.Question_id = q.Question_id
	LEFT JOIN [$(SolomonApp)].dbo.cft_Eval ev (NOLOCK) on ev.Eval_id = evalr.Eval_id
	
WHERE q.FormID = 7
	AND q.status = 'A'
	AND ev.EntryDate between @begin_date and @end_date
ORDER BY 'Percent'





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_EvalQues_Bio] TO [db_sp_exec]
    AS [dbo];

