CREATE TABLE [dbo].[SegDef] (
    [Active]         SMALLINT      NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Description]    CHAR (30)     NOT NULL,
    [FieldClass]     CHAR (3)      NOT NULL,
    [FieldClassName] CHAR (15)     NOT NULL,
    [ID]             CHAR (24)     NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME NOT NULL,
    [LUpd_Prog]      CHAR (8)      NOT NULL,
    [LUpd_User]      CHAR (10)     NOT NULL,
    [SegNumber]      CHAR (2)      NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [SegDef0] PRIMARY KEY CLUSTERED ([FieldClassName] ASC, [SegNumber] ASC, [ID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [SegDef1]
    ON [dbo].[SegDef]([FieldClass] ASC, [SegNumber] ASC, [ID] ASC) WITH (FILLFACTOR = 90);

