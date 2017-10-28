CREATE TABLE [dbo].[cftRewardType] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Description]   CHAR (30)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [ReqSizeSelect] SMALLINT      NOT NULL,
    [RewardNbr]     CHAR (2)      NOT NULL,
    [RewardVal]     FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL
);

