CREATE TABLE [dbo].[FieldOwner] (
    [FieldID]            INT          NOT NULL,
    [ContactID]          INT          NOT NULL,
    [PercentOwnership]   FLOAT (53)   NULL,
    [PrimaryContactFlag] SMALLINT     CONSTRAINT [DF_FieldOwner_PrimaryContactFlag] DEFAULT (0) NULL,
    [Comment]            VARCHAR (60) NULL,
    CONSTRAINT [PK_FieldOwner] PRIMARY KEY CLUSTERED ([FieldID] ASC, [ContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_FieldOwner_Field] FOREIGN KEY ([FieldID]) REFERENCES [dbo].[Field] ([FieldID]) ON DELETE CASCADE
);

