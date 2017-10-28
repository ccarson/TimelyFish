CREATE TABLE [dbo].[cft_Form_Ans_Opt] (
    [Option_id]  INT           IDENTITY (1, 1) NOT NULL,
    [FormId]     INT           NOT NULL,
    [status]     VARCHAR (1)   NOT NULL,
    [Definition] VARCHAR (255) NOT NULL
);

