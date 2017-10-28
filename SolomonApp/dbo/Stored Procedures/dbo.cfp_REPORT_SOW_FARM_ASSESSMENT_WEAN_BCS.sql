



-- ======================================================================================
-- Author:	Nick Honetschlager
-- Create date:	4/18/2016
-- Description:	Wean BCS. Converted to stored procedure from sql in rdl.
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
CREATE PROCEDURE [dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_WEAN_BCS] 
@pEvalID int

AS

SELECT LEFT(fq.Definition,charindex('BCS',fq.Definition ) - 2) as Stage
	,Right(fq.Definition,4) as 'Question'
	,fq.QuestionNbr
	,case when er.answer=0 then 0 else er.answer end as 'Score'
	,tot_sum.Total
	,case when tot_sum.Total = 0 then 0.0 else CAST(er.answer as decimal)/CAST(tot_sum.Total as decimal) end as Pct
from dbo.cft_Eval_Results er
inner join dbo.cft_Eval ce on ce.Eval_id=er.Eval_id and FormID = 13
inner join dbo.cft_Form_Ques fq on er.Question_id=fq.Question_id 
inner join (select   err.eval_id
                   , LEFT(fq.Definition,charindex('BCS',fq.Definition ) - 2) as stg
			       , SUM(cast(err.Answer as INT)) as Total
			  from dbo.cft_Eval_Results err
			inner join dbo.cft_Eval ce on ce.Eval_id=err.Eval_id and FormID = 13
			inner join dbo.cft_Form_Ques fq on err.Question_id=fq.Question_id 
			where fq.Area = 'Sow BCS' and fq.Definition like '%BCS%'
			group by err.Eval_id, LEFT(fq.Definition,charindex('BCS',fq.Definition ) - 2)
           ) tot_sum on tot_sum.Eval_id=er.Eval_id and tot_sum.stg=LEFT(fq.Definition,charindex('BCS',fq.Definition ) - 2)
where ce.Eval_id=@pEvalID
  and fq.Area = 'Sow BCS'
  and fq.Definition like '%BCS%'
  

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_WEAN_BCS] TO [MSDSL]
    AS [dbo];

