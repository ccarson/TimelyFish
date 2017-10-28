CREATE TABLE [dbo].[FieldOperator] (
    [FieldID]   INT          NOT NULL,
    [ContactID] INT          NOT NULL,
    [Comment]   VARCHAR (60) NULL,
    CONSTRAINT [PK_FieldOperator] PRIMARY KEY CLUSTERED ([FieldID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FieldOperator_Field] FOREIGN KEY ([FieldID]) REFERENCES [dbo].[Field] ([FieldID]) ON DELETE CASCADE
);

