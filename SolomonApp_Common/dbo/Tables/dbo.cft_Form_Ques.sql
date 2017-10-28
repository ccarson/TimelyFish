CREATE TABLE [dbo].[cft_Form_Ques] (
    [Question_id] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FormID]      INT           NOT NULL,
    [QuestionNbr] INT           NOT NULL,
    [status]      VARCHAR (1)   NOT NULL,
    [Area]        VARCHAR (50)  NULL,
    [Definition]  VARCHAR (500) NULL,
    [Method]      VARCHAR (20)  NULL,
    CONSTRAINT [pk_Ques] PRIMARY KEY CLUSTERED ([Question_id] ASC) WITH (FILLFACTOR = 80)
);

