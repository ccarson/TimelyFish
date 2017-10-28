CREATE TABLE [dbo].[LogShipping_Validation] (
    [Insert_time] DATETIME     NOT NULL,
    [comment]     VARCHAR (30) NULL,
    CONSTRAINT [pk_insert_time] PRIMARY KEY CLUSTERED ([Insert_time] ASC) WITH (FILLFACTOR = 90)
);

