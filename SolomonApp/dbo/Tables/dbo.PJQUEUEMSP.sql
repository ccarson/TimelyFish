CREATE TABLE [dbo].[PJQUEUEMSP] (
    [PjqueueMsp_PK] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CpnyID]        NVARCHAR (10)    NOT NULL,
    [Crtd_DateTime] SMALLDATETIME    NOT NULL,
    [Crtd_Prog]     NVARCHAR (8)     NOT NULL,
    [Crtd_User]     NVARCHAR (47)    NOT NULL,
    [JobUID]        UNIQUEIDENTIFIER NULL,
    [LUpd_DateTime] SMALLDATETIME    NOT NULL,
    [LUpd_Prog]     CHAR (8)         NOT NULL,
    [Lupd_User]     NVARCHAR (47)    NOT NULL,
    [KeyUID]        UNIQUEIDENTIFIER NULL,
    [SLKeyValue]    NVARCHAR (16)    NOT NULL,
    [Status]        CHAR (1)         NOT NULL,
    [Type]          NVARCHAR (10)    NOT NULL,
    [Message]       NVARCHAR (MAX)   NOT NULL,
    [TStamp]        ROWVERSION       NOT NULL,
    CONSTRAINT [PJQUEUEMSP0] PRIMARY KEY NONCLUSTERED ([PjqueueMsp_PK] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PJQUEUEMSP1]
    ON [dbo].[PJQUEUEMSP]([SLKeyValue] ASC, [PjqueueMsp_PK] ASC) WITH (FILLFACTOR = 90);

