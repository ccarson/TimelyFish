CREATE TABLE [dbo].[PJPROJEM] (
    [access_data1]   CHAR (1)      NOT NULL,
    [access_data2]   CHAR (32)     NOT NULL,
    [access_insert]  CHAR (1)      NOT NULL,
    [access_update]  CHAR (1)      NOT NULL,
    [access_view]    CHAR (1)      NOT NULL,
    [crtd_datetime]  SMALLDATETIME NOT NULL,
    [crtd_prog]      CHAR (8)      NOT NULL,
    [crtd_user]      CHAR (10)     NOT NULL,
    [employee]       CHAR (10)     NOT NULL,
    [labor_class_cd] CHAR (4)      NOT NULL,
    [lupd_datetime]  SMALLDATETIME NOT NULL,
    [lupd_prog]      CHAR (8)      NOT NULL,
    [lupd_user]      CHAR (10)     NOT NULL,
    [noteid]         INT           NOT NULL,
    [project]        CHAR (16)     NOT NULL,
    [pv_id01]        CHAR (32)     NOT NULL,
    [pv_id02]        CHAR (32)     NOT NULL,
    [pv_id03]        CHAR (16)     NOT NULL,
    [pv_id04]        CHAR (16)     NOT NULL,
    [pv_id05]        CHAR (4)      NOT NULL,
    [pv_id06]        FLOAT (53)    NOT NULL,
    [pv_id07]        FLOAT (53)    NOT NULL,
    [pv_id08]        SMALLDATETIME NOT NULL,
    [pv_id09]        SMALLDATETIME NOT NULL,
    [pv_id10]        INT           NOT NULL,
    [user1]          CHAR (30)     NOT NULL,
    [user2]          CHAR (30)     NOT NULL,
    [user3]          FLOAT (53)    NOT NULL,
    [user4]          FLOAT (53)    NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [pjprojem0] PRIMARY KEY CLUSTERED ([project] ASC, [employee] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjprojem1]
    ON [dbo].[PJPROJEM]([employee] ASC, [project] ASC) WITH (FILLFACTOR = 90);

