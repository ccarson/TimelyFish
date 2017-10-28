CREATE TABLE [dbo].[cft_Form_Ques_Ans_Opt] (
    [Form_Ques_Ans_Opt_id] INT         IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Question_id]          INT         NOT NULL,
    [Option_id]            INT         NOT NULL,
    [status]               VARCHAR (1) NOT NULL,
    CONSTRAINT [pk_cft_Form_Ques_Ans_Opt] PRIMARY KEY CLUSTERED ([Form_Ques_Ans_Opt_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK1_cft_Form_Ques_Ans_Opt] FOREIGN KEY ([Option_id]) REFERENCES [dbo].[cft_Form_Ans_Opt] ([Option_id]),
    CONSTRAINT [FK2_cft_Form_Ques_Ans_Opt] FOREIGN KEY ([Question_id]) REFERENCES [dbo].[cft_Form_Ques] ([Question_id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [AK_cft_Form_Ques_Ans_Opt]
    ON [dbo].[cft_Form_Ques_Ans_Opt]([Question_id] ASC, [Option_id] ASC) WITH (FILLFACTOR = 90);

