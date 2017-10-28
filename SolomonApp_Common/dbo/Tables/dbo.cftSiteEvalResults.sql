CREATE TABLE [dbo].[cftSiteEvalResults] (
    [Eval_id]     INT NOT NULL,
    [Question_id] INT NOT NULL,
    [Answer]      BIT NOT NULL,
    CONSTRAINT [pk_EvalResults] PRIMARY KEY CLUSTERED ([Eval_id] ASC, [Question_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [fk_EvalId] FOREIGN KEY ([Eval_id]) REFERENCES [dbo].[cftSiteEval] ([Eval_id]),
    CONSTRAINT [fk_QuestionID] FOREIGN KEY ([Question_id]) REFERENCES [dbo].[cftSiteQuestion] ([Question_id])
);

