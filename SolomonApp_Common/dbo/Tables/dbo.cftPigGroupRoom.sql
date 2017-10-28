CREATE TABLE [dbo].[cftPigGroupRoom] (
    [CF01]            CHAR (30)     NOT NULL,
    [CF02]            CHAR (30)     NOT NULL,
    [CF03]            CHAR (10)     NOT NULL,
    [CF04]            CHAR (10)     NOT NULL,
    [CF05]            SMALLDATETIME NOT NULL,
    [CF06]            SMALLDATETIME NOT NULL,
    [CF07]            INT           NOT NULL,
    [CF08]            INT           NOT NULL,
    [CF09]            SMALLINT      NOT NULL,
    [CF10]            SMALLINT      NOT NULL,
    [CF11]            FLOAT (53)    NOT NULL,
    [CF12]            FLOAT (53)    NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [EstStartWgtAdj]  SMALLINT      NOT NULL,
    [FeedPlanID]      CHAR (4)      NOT NULL,
    [IndPln]          SMALLINT      NOT NULL,
    [Lupd_DateTime]   SMALLDATETIME NOT NULL,
    [Lupd_Prog]       CHAR (8)      NOT NULL,
    [Lupd_User]       CHAR (10)     NOT NULL,
    [PigGenderTypeID] CHAR (6)      NOT NULL,
    [PigGroupID]      CHAR (10)     NOT NULL,
    [PriorFeedQty]    FLOAT (53)    NOT NULL,
    [RoomNbr]         CHAR (10)     NOT NULL,
    [tstamp]          ROWVERSION    NULL,
    CONSTRAINT [PK_cftPigGroupRoom] PRIMARY KEY NONCLUSTERED ([PigGroupID] ASC, [RoomNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE CLUSTERED INDEX [cftPigGroupRoom0]
    ON [dbo].[cftPigGroupRoom]([PigGroupID] ASC, [RoomNbr] ASC) WITH (FILLFACTOR = 100);

