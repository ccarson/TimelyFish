



-- ======================================================================================
-- Author:	Nick Honetschlager
-- Create date:	4/18/2016
-- Description:	Ulcer Score. Converted to stored procedure from sql in rdl.
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
CREATE PROCEDURE [dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_ULCER_SCORE] 
@pEvalID int

AS


SELECT   
	 fq.Definition as 'Question'
	,fq.QuestionNbr
	,er.answer as 'Score'
	, tot_sum.Cnt_Total as 'Count_Total'
	, cast(er.answer as decimal)/ISNULL( NULLIF( cast(tot_sum.Cnt_Total as decimal), 0 ), 1 ) as 'Pct'
from dbo.cft_Eval_Results er
inner join dbo.cft_Eval ce on ce.Eval_id=er.Eval_id and FormID = 13
inner join dbo.cft_Form_Ques fq on er.Question_id=fq.Question_id 
inner join (SELECT cer.eval_id, 
                              sum(cast(cer.answer as int)) as Cnt_Total
                    from cft_Eval_Results cer 
                    inner join dbo.cft_Eval ce on ce.Eval_id=cer.Eval_id and FormID = 13
                    inner join dbo.cft_Form_Ques fq on cer.Question_id=fq.Question_id 
                    where cer.eval_id=@pEvalID and fq.area = 'Ulcer Score'
	    group by cer.eval_id
                  ) tot_sum on tot_sum.eval_id = ce.eval_id

where ce.Eval_id=@pEvalID
  and fq.Area = 'Ulcer Score'
  

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_ULCER_SCORE] TO [MSDSL]
    AS [dbo];

