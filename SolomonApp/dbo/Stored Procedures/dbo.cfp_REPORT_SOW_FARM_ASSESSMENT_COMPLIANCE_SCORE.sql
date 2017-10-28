



-- ======================================================================================
-- Author:	Nick Honetschlager
-- Create date:	4/18/2016
-- Description:	Compliance. Converted to stored procedure from sql in rdl.
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
CREATE PROCEDURE [dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_COMPLIANCE_SCORE] 
@pEvalID int

AS

SELECT er.Eval_id
	,SUM(CAST(er.answer as decimal(6,3)))/COUNT(CAST(er.answer as decimal(6,3))) as '% Compliant'
FROM dbo.cft_Eval_Results er
INNER JOIN dbo.cft_Eval ce ON ce.Eval_id=er.Eval_id AND FormID = 13
INNER JOIN dbo.cft_Form_Ques fq ON er.Question_id=fq.Question_id 
INNER JOIN CentralData.dbo.Contact sc ON ce.SiteContactID=sc.ContactID
INNER JOIN CentralData.dbo.Contact sm ON ce.SvcMgrContactID =sm.ContactID
WHERE ce.Eval_id=@pEvalID
  AND fq.definition NOT LIKE '% BCS %' AND fq.area NOT LIKE '%Ulcer Score%'
GROUP BY er.Eval_id
  

 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_SOW_FARM_ASSESSMENT_COMPLIANCE_SCORE] TO [MSDSL]
    AS [dbo];

