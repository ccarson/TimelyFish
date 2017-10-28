CREATE TABLE [dbo].[cft_Eval_Results] (
    [Eval_id]         INT           NOT NULL,
    [Question_id]     INT           NOT NULL,
    [Option_id]       INT           NULL,
    [Comments]        VARCHAR (255) NULL,
    [FollowUpByDate]  DATE          NULL,
    [FollowUpOwner]   VARCHAR (20)  NULL,
    [CompletedOnDate] DATE          NULL,
    [Answer]          VARCHAR (30)  NULL,
    CONSTRAINT [pk_Eval_Results] PRIMARY KEY CLUSTERED ([Eval_id] ASC, [Question_id] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [fk_cft_Eval_EvalId] FOREIGN KEY ([Eval_id]) REFERENCES [dbo].[cft_Eval] ([Eval_id]),
    CONSTRAINT [fk_cft_form_ques_QuestionID] FOREIGN KEY ([Question_id]) REFERENCES [dbo].[cft_Form_Ques] ([Question_id]),
    CONSTRAINT [FK1_cft_Eval_Results] FOREIGN KEY ([Option_id]) REFERENCES [dbo].[cft_Form_Ans_Opt] ([Option_id])
);

