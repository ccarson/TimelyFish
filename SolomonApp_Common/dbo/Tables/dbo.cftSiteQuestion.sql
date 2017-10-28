CREATE TABLE [dbo].[cftSiteQuestion] (
    [Question_id] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [QuestionNbr] INT           NOT NULL,
    [status]      VARCHAR (1)   NOT NULL,
    [Area]        VARCHAR (30)  NOT NULL,
    [Definition]  VARCHAR (255) NOT NULL,
    CONSTRAINT [pk_Queation] PRIMARY KEY CLUSTERED ([Question_id] ASC) WITH (FILLFACTOR = 80)
);

