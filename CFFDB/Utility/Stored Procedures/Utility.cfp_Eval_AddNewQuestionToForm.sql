

CREATE PROCEDURE
	[Utility].[cfp_Eval_AddNewQuestionToForm]( 
		@pFormName		varchar (30)
	  , @pQuestionNbr	int
	  , @pArea			varchar (50)	
	  , @pDefinition	varchar (500)	
	  , @pMethod		varchar (20) )
/*
===============================================================================
Purpose:    Loads new question into SolomonApp.dbo.cft_Form_Ques

Abstract:
	1)	Get FormID for incoming @pFormName
	2)	Renumber existing questions
	3)  Insert new question into table

Change Log:
Date        Who         Change
----------- ----------- -------------------------------------------------------
2016-06-29	ccarson		Initial Build
===============================================================================
*/
AS

SET NOCOUNT, XACT_ABORT ON ; 

DECLARE 
	@lFormName		varchar (30)	= @pFormName
  , @lQuestionNbr	int				= @pQuestionNbr	
  , @lArea			varchar (50)	= @pArea			
  , @lDefinition	varchar (500)	= @pDefinition	
  , @lMethod		varchar (20)	= @pMethod ;

DECLARE 
	@FormID int ;


/*
	1)	SELECT FormID based on incoming form name
*/

SELECT @FormID = FormID FROM SolomonApp.dbo.cft_Form WHERE Form_Name = @lFormName ;


/*
	2)	UPDATE SolomonApp.dbo.cft_Form_Ques to renumber existing questions based on incoming QuestionNbr
*/

UPDATE
	SolomonApp.dbo.cft_Form_Ques
SET
	QuestionNbr = QuestionNbr + 1 
WHERE
	FormID = @FormID AND QuestionNbr !< @lQuestionNbr ;


/*
	3)	INSERT new question from incoming parameters into form 
*/

INSERT INTO
	SolomonApp.dbo.cft_Form_Ques(
		FormID, QuestionNbr, status, Area, Definition, Method )
SELECT 
	FormID			= @FormID			 
  , QuestionNbr		= @lQuestionNbr		 
  , [status]		= 'A'
  , Area			= @lArea			 
  , [Definition]	= @lDefinition
  , Method 			= @lMethod 		;