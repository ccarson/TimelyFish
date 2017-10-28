CREATE TABLE [dbo].[cft_Form_Ans_Opt] (
    [Option_id]  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FormId]     INT           NOT NULL,
    [status]     VARCHAR (1)   NOT NULL,
    [Definition] VARCHAR (255) NOT NULL,
    CONSTRAINT [pk_cft_Form_Ans_Opt] PRIMARY KEY CLUSTERED ([Option_id] ASC) WITH (FILLFACTOR = 80),
    CONSTRAINT [FK1_cft_Form_Ans_Opt] FOREIGN KEY ([FormId]) REFERENCES [dbo].[cft_Form] ([FormID])
);

