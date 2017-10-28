CREATE TABLE [dbo].[cft_Eval_Results] (
    [Eval_id]         INT           NOT NULL,
    [Question_id]     INT           NOT NULL,
    [Answer]          BIT           NOT NULL,
    [Option_id]       INT           NULL,
    [Comments]        VARCHAR (255) NULL,
    [FollowUpByDate]  DATE          NULL,
    [FollowUpOwner]   VARCHAR (20)  NULL,
    [CompletedOnDate] DATE          NULL,
    CONSTRAINT [pk_Eval_Results] PRIMARY KEY CLUSTERED ([Eval_id] ASC, [Question_id] ASC) WITH (FILLFACTOR = 90)
);

