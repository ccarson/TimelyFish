CREATE TABLE [dbo].[EssbaseRemovalUploadTemp] (
    [PICWeek]            CHAR (10)    NULL,
    [FarmID]             VARCHAR (12) NULL,
    [SowID]              VARCHAR (20) NULL,
    [SowParity]          CHAR (10)    NULL,
    [RemovalType]        VARCHAR (20) NULL,
    [RemovalReason]      VARCHAR (30) NULL,
    [Genetics]           CHAR (20)    NULL,
    [FirstService]       INT          NULL,
    [LastService]        INT          NULL,
    [RemovalDate]        INT          NULL,
    [LastWeanDate]       INT          NULL,
    [InitialAge]         SMALLINT     NULL,
    [SowAge]             SMALLINT     NULL,
    [HeadCount]          SMALLINT     NULL,
    [BornAliveQty]       SMALLINT     NULL,
    [MummyQty]           SMALLINT     NULL,
    [StillbornQty]       SMALLINT     NULL,
    [NaturalWeanQty]     SMALLINT     NULL,
    [WeanQty]            SMALLINT     NULL,
    [EntryDate]          INT          NULL,
    [LastParityServices] SMALLINT     NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [FarmID_SowID]
    ON [dbo].[EssbaseRemovalUploadTemp]([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 90);

