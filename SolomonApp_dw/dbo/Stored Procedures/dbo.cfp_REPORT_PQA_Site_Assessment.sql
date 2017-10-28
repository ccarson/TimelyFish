--:SETVAR SolomonApp SolomonApp
--:SETVAR CentralData CentralData 

--DECLARE @pEvalID int = ;

CREATE PROCEDURE
    dbo.cfp_REPORT_PQA_Site_Assessment( 
        @pEvalID int )
AS
/*
***********************************************************************************************************************************

  Procedure:    dbo.cfp_REPORT_PQA_Site_Assessment
     Author:    Chris Carson
    Purpose:    Build PQA Assessment based on results from either Site Yearly Assessment or Random Welfare Audit

    revisor         date                description
    ---------       -----------         ----------------------------
    ccarson         2016-08-15          created

    Logic Summary:


    Notes:

***********************************************************************************************************************************
*/

SET NOCOUNT, XACT_ABORT ON ;

DECLARE
    --  local variables to hold proc parameters
    @lEvalID        int			= @pEvalID
  , @lEvalIDString	varchar(10)	= CONVERT( varchar(10), @pEvalID )  


  , @PQAEvalID      int
  , @PQAFormID      int
  , @CFFFormID      int
  , @PQAFormName    varchar(30) = 'PQA Site Assessment' ;


/*  1)  validate incoming eval, must be Site Yearly Assessment or Random Welfare Audit	*/

SELECT 
    @PQAFormID = FormID 
FROM 
    [$(SolomonApp)].dbo.cft_Form WHERE Form_Name = @PQAFormName ;

SELECT
    @CFFFormID = FormID
FROM
    [$(SolomonApp)].dbo.cft_Eval
WHERE
    Eval_id= @lEvalID
        AND FormID IN( SELECT FormID FROM [$(SolomonApp)].dbo.cft_Form WHERE Form_Name IN ( 'Site Yearly Audit', 'Random Welfare Audit' ) ) ;

IF @CFFFormID IS NULL
BEGIN
    RAISERROR( 'Error: The eval selected must be either a Site Yearly Audit or a Random Welfare Audit', 16, 1 ) ;
    RETURN 55555 ;
END


/*  2)  If the PQA Eval already exists for the incoming Eval, delete it	*/
SELECT @PQAEvalID = Eval_id FROM [$(SolomonApp)].dbo.cft_Eval WHERE CONVERT( varchar(max), Comments ) = @lEvalIDString ; 

IF	@PQAEvalID IS NOT NULL
BEGIN 
	DELETE [$(SolomonApp)].dbo.cft_Eval_Results WHERE Eval_id = @PQAEvalID ; 
	DELETE [$(SolomonApp)].dbo.cft_Eval WHERE Eval_id = @PQAEvalID ; 
END


/*  3)  INSERT PQA eval header based on existing data from incoming eval */

INSERT INTO
    [$(SolomonApp)].dbo.cft_Eval( SiteContactID, SvcMgrContactID, EntryDate, EntryUserID, FormID, EvalContactID, Comments, EvalDate, EntryUserID2 )
SELECT
    SiteContactID, SvcMgrContactID, EntryDate, EntryUserID, @PQAFormID, EvalContactID, CONVERT( varchar(10), @lEvalID ), EvalDate, EntryUserID2
FROM
    [$(SolomonApp)].dbo.cft_Eval
WHERE
    Eval_id = @lEvalID ;

SELECT @PQAEvalID = SCOPE_IDENTITY() ;


/*  4)  Map out PQA questions to corresponding CFF Audit questions.
        NOTE:   Not all questions are mapped
        NOTE:   If Site Audit questions are re-numbered, mapping must be adjusted here  */

DECLARE
    @PQASiteAssessmentMapping AS TABLE( PQAQuestionNbr      int
                                      , AuditQuestionNbr    int ) ;

INSERT INTO
    @PQASiteAssessmentMapping( PQAQuestionNbr, AuditQuestionNbr )
VALUES
    ( 01, 03 )
  , ( 02, 04 )
  , ( 03, 08 )
  , ( 04, 08 )
  , ( 05, 08 )
  , ( 06, 08 )
  , ( 07, 08 )
  , ( 08, 08 )
  , ( 09, 08 )
  , ( 10, 08 )
  , ( 11, 08 )
  , ( 12, 71 )
  , ( 13, 02 )
  , ( 14, 03 )
  , ( 15, 61 )
  , ( 16, 13 )
  , ( 17, 01 )
  , ( 18, 21 )
  , ( 19, 15 )
  , ( 20, 14 )
  , ( 21, 16 )
  , ( 22, 06 )
  , ( 23, 14 )
  , ( 24, 14 )
  , ( 25, 14 )
  , ( 26, 18 )
  , ( 27, 13 )
  , ( 28, 52 )
  , ( 29, 21 )
  , ( 30, 23 )
  , ( 31, 61 )
  , ( 32, 11 )
  , ( 33, 07 )
  , ( 34, 07 )
  , ( 35, 06 )
  , ( 37, 32 )
  , ( 38, 33 )
  , ( 39, 30 )
  , ( 40, 31 )
  , ( 41, 28 )
  , ( 42, 55 )
  , ( 47, 24 )
  , ( 48, 25 )
  , ( 49, 27 )
  , ( 50, 27 )
  , ( 51, 43 )
  , ( 52, 48 )
  , ( 53, 56 )
  , ( 54, 46 )
  , ( 55, 40 )
  , ( 56, 41 )
  , ( 57, 42 )
  , ( 58, 62 )
  , ( 59, 19 )
  , ( 60, 63 )
  , ( 61, 19 )
  , ( 62, 64 )
  , ( 63, 19 )
  , ( 64, 65 )
  , ( 65, 19 )
  , ( 66, 66 )
  , ( 67, 19 )
  , ( 68, 67 )
  , ( 69, 19 )
  , ( 70, 68 )
  , ( 71, 19 )
  , ( 72, 69 )
  , ( 73, 19 )
  , ( 74, 70 )
  , ( 75, 57 )
  , ( 76, 57 )
  , ( 77, 57 )
  , ( 78, 60 )
  , ( 79, 57 )
  , ( 80, 49 )
  , ( 81, 47 )
  , ( 82, 04 )
  , ( 83, 59 )
  , ( 84, 72 )
  , ( 85, 73 )
  , ( 86, 75 )
  , ( 87, 80 )
  , ( 88, 76 )
  , ( 89, 74 )
  , ( 90, 78 )
  , ( 91, 79 )
  , ( 92, 77 ) ;


/*  5)  INSERT results for mapped questions to cft_Eval_Results */

WITH mappedResults AS(
    SELECT
        CFFQuestionID   = cff.Question_id
      , CFFQuestionNbr  = cff.QuestionNbr
      , PQAQuestionID   = pqa.Question_id
      , PQAQuestionNbr  = pqa.QuestionNbr
    FROM
        @PQASiteAssessmentMapping AS map
    INNER JOIN
        [$(SolomonApp)].dbo.cft_Form_Ques AS cff ON cff.QuestionNbr = map.AuditQuestionNbr
    INNER JOIN
        [$(SolomonApp)].dbo.cft_Form_Ques AS pqa ON pqa.QuestionNbr = map.PQAQuestionNbr AND pqa.status = cff.status
    WHERE
        cff.FormID = @CFFFormID AND pqa.FormID = @PQAFormID AND cff.status = 'A' )

INSERT INTO
    [$(SolomonApp)].dbo.cft_Eval_Results( Eval_id, Question_id, Option_id, Comments, FollowUpByDate, FollowUpOwner, CompletedOnDate, Answer )
SELECT
    Eval_id             = @PQAEvalID
  , Question_id         = map.PQAQuestionID
  , Option_id           = res.Option_id
  , Comments            = res.Comments
  , FollowUpByDate      = res.FollowUpByDate
  , FollowUpOwner       = res.FollowUpOwner
  , CompletedOnDate     = res.CompletedOnDate
  , Answer              = res.Answer
FROM
    [$(SolomonApp)].dbo.cft_Eval_Results AS res
INNER JOIN
    [$(SolomonApp)].dbo.cft_Form_Ques AS qst ON qst.Question_id = res.Question_id
INNER JOIN
    mappedResults AS map ON map.CFFQuestionNbr = qst.QuestionNbr
WHERE
    res.Eval_id = @lEvalID AND qst.status = 'A' AND qst.FormID = @CFFFormID ;


/*  6)  INSERT results for questions with business rules

    General rule:   PQA answer is combination of two answers from audit
                        if both audit answers are yes, PQA answer is yet
                        if either audit answer is no, PQA answer is no
                        Use CA from the audit answer that was no
                        Concatentate CAs if both audit answers are no.  */

DECLARE
    @CFFAnswer              tinyint         = 0
  , @CFFCorrectiveAction    varchar(255)    = NULL
  , @CFFFollowUpDate        date            = NULL
  , @CFFFollowUpOwner       varchar(20)     = NULL ;


/*      Question #36    use audit answers for questions 35 and 36   */
SELECT
    @CFFAnswer              = CAST( res.Answer AS tinyint )
  , @CFFCorrectiveAction    = NULLIF( res.Comments, '' )
  , @CFFFollowUpDate        = res.FollowUpByDate
  , @CFFFollowUpOwner       = NULLIF( res.FollowUpOwner, '' )
FROM
    [$(SolomonApp)].dbo.cft_Eval_Results AS res
INNER JOIN
    [$(SolomonApp)].dbo.cft_Form_Ques AS qst
        ON qst.Question_id = res.Question_id
WHERE
    res.Eval_id = @lEvalID AND qst.QuestionNbr = 35 ;


SELECT
    @CFFAnswer              =   @CFFAnswer + CAST( res.Answer AS tinyint )
  , @CFFCorrectiveAction    =   CASE
                                    WHEN @CFFCorrectiveAction IS NULL THEN NULLIF( res.Comments, '' )
                                    ELSE @CFFCorrectiveAction + ' ' + res.Comments
                                END
  , @CFFFollowUpDate        =   COALESCE( @CFFFollowUpDate, res.FollowUpByDate )
  , @CFFFollowUpOwner       =   COALESCE( @CFFFollowUpOwner, NULLIF( res.FollowUpOwner, '' ) )
FROM
    [$(SolomonApp)].dbo.cft_Eval_Results AS res
INNER JOIN
    [$(SolomonApp)].dbo.cft_Form_Ques AS qst ON qst.Question_id = res.Question_id
WHERE
    res.Eval_id = @lEvalID AND qst.QuestionNbr = 36 ;

INSERT INTO
    [$(SolomonApp)].dbo.cft_Eval_Results( Eval_id, Question_id, Comments, FollowUpByDate, FollowUpOwner, Answer )
SELECT
    Eval_id             = @PQAEvalID
  , Question_id         = CAST( 36 AS int )
  , Comments            = ISNULL( @CFFCorrectiveAction, '' )
  , FollowUpByDate      = @CFFFollowUpDate
  , FollowUpOwner       = ISNULL( @CFFFollowUpOwner, '' )
  , Answer              = CASE @CFFAnswer WHEN 2 THEN 1 ELSE 0 END ;


/*      Question #46    use audit answers for questions 21 and 23   */

SELECT
    @CFFAnswer              = CAST( res.Answer AS tinyint )
  , @CFFCorrectiveAction    = NULLIF( res.Comments, '' )
  , @CFFFollowUpDate        = res.FollowUpByDate
  , @CFFFollowUpOwner       = NULLIF( res.FollowUpOwner, '' )
FROM
    [$(SolomonApp)].dbo.cft_Eval_Results AS res
INNER JOIN
    [$(SolomonApp)].dbo.cft_Form_Ques AS qst ON qst.Question_id = res.Question_id
WHERE
    res.Eval_id = @lEvalID AND qst.QuestionNbr = 21 ;

SELECT
    @CFFAnswer              =   @CFFAnswer + CAST( res.Answer AS tinyint )
  , @CFFCorrectiveAction    =   CASE
                                    WHEN @CFFCorrectiveAction IS NULL THEN NULLIF( res.Comments, '' )
                                    ELSE @CFFCorrectiveAction + ' ' + res.Comments
                                END
  , @CFFFollowUpDate        =   COALESCE( @CFFFollowUpDate, res.FollowUpByDate )
  , @CFFFollowUpOwner       =   COALESCE( @CFFFollowUpOwner, NULLIF( res.FollowUpOwner, '' ) )
FROM
    [$(SolomonApp)].dbo.cft_Eval_Results AS res
INNER JOIN
    [$(SolomonApp)].dbo.cft_Form_Ques AS qst ON qst.Question_id = res.Question_id
WHERE
    res.Eval_id = @lEvalID AND qst.QuestionNbr = 23 ;

INSERT INTO
    [$(SolomonApp)].dbo.cft_Eval_Results( Eval_id, Question_id, Comments, FollowUpByDate, FollowUpOwner, Answer )
SELECT
    Eval_id             = @PQAEvalID
  , Question_id         = CAST( 46 AS int )
  , Comments            = ISNULL( @CFFCorrectiveAction, '' )
  , FollowUpByDate      = @CFFFollowUpDate
  , FollowUpOwner       = ISNULL( @CFFFollowUpOwner, '' )
  , Answer              = CASE @CFFAnswer WHEN 2 THEN 1 ELSE 0 END ;


/*  7)  SELECT formatted results for PQA report	*/
SELECT 
    SiteState		  = a.State
  , SiteName		  = c.ContactName 
  , AssessmentDate 	  = e.EvalDate 
  , q.Area
  , QuestionNbr		  = CONVERT( varchar(08), q.QuestionNbr	) + '.'
  , Question		  =	q.Definition
  , Acceptable		  =	CASE 
							WHEN r.Answer IS NULL then 'N/A' 
							WHEN r.Answer = 0 THEN 'No'
							ELSE 'Yes' 
						END 
	
  , ActionPlan 		  = p.Definition
  , r.Comments
FROM 
	[$(SolomonApp)].dbo.cft_Eval AS e
INNER JOIN 
	[CentralData].dbo.Contact AS c 
		on c.ContactID = e.SiteContactID 
INNER JOIN 
	[CentralData].dbo.ContactAddress AS ca 
		ON ca.ContactID = e.SiteContactID 
LEFT JOIN 
	[CentralData].dbo.Address AS a
		ON a.AddressID = ca.AddressID 
INNER JOIN 
	[$(SolomonApp)].dbo.cft_Form_Ques AS q 
		ON q.FormID = e.FormID AND q.status = 'A'
LEFT JOIN
	[$(SolomonApp)].dbo.cft_Eval_Results AS r
		ON r.Question_id = q.Question_id 
			AND r.Eval_id = e.Eval_id
LEFT JOIN 
	[$(SolomonApp)].dbo.cft_Form_Ans_Opt AS p 
		ON p.Option_id= r.Option_id
			AND p.FormId = e.FormID 
			AND p.status = 'A'
WHERE
	e.Eval_id = @PQAEvalID
		AND ca.AddressTypeID = 1
ORDER BY q.QuestionNbr ;

RETURN 0 ;
