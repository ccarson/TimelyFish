CREATE TABLE [dbo].[cft_Form_Ques2] (
    [Question_id] INT           IDENTITY (1, 1) NOT NULL,
    [FormID]      INT           NOT NULL,
    [QuestionNbr] INT           NOT NULL,
    [status]      VARCHAR (1)   NOT NULL,
    [Area]        VARCHAR (50)  NULL,
    [Definition]  VARCHAR (500) NULL,
    [Method]      VARCHAR (20)  NULL
);

