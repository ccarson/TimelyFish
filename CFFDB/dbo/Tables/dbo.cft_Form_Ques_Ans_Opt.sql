CREATE TABLE [dbo].[cft_Form_Ques_Ans_Opt] (
    [Form_Ques_Ans_Opt_id] INT         IDENTITY (1, 1) NOT NULL,
    [Question_id]          INT         NOT NULL,
    [Option_id]            INT         NOT NULL,
    [status]               VARCHAR (1) NOT NULL
);

