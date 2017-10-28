CREATE TABLE [dbo].[PJ_INVEN] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [prim_key]      CHAR (30)     NOT NULL,
    [project]       CHAR (16)     NOT NULL,
    [pjt_entity]    CHAR (32)     NOT NULL,
    [status_pa]     CHAR (1)      NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pj_inven0] PRIMARY KEY CLUSTERED ([prim_key] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pj_inven1]
    ON [dbo].[PJ_INVEN]([status_pa] ASC) WITH (FILLFACTOR = 90);

