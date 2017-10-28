CREATE TABLE [dbo].[PJACCT] (
    [acct]          CHAR (16)     NOT NULL,
    [acct_desc]     CHAR (30)     NOT NULL,
    [acct_group_cd] CHAR (2)      NOT NULL,
    [acct_status]   CHAR (1)      NOT NULL,
    [acct_type]     CHAR (2)      NOT NULL,
    [ca_id01]       CHAR (30)     NOT NULL,
    [ca_id02]       CHAR (30)     NOT NULL,
    [ca_id03]       CHAR (16)     NOT NULL,
    [ca_id04]       CHAR (16)     NOT NULL,
    [ca_id05]       CHAR (4)      NOT NULL,
    [ca_id06]       FLOAT (53)    NOT NULL,
    [ca_id07]       FLOAT (53)    NOT NULL,
    [ca_id08]       SMALLDATETIME NOT NULL,
    [ca_id09]       SMALLDATETIME NOT NULL,
    [ca_id10]       INT           NOT NULL,
    [ca_id16]       CHAR (30)     NOT NULL,
    [ca_id17]       CHAR (16)     NOT NULL,
    [ca_id18]       CHAR (4)      NOT NULL,
    [ca_id19]       CHAR (1)      NOT NULL,
    [ca_id20]       CHAR (1)      NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [id1_sw]        CHAR (1)      NOT NULL,
    [id2_sw]        CHAR (1)      NOT NULL,
    [id3_sw]        CHAR (1)      NOT NULL,
    [id4_sw]        CHAR (1)      NOT NULL,
    [id5_sw]        CHAR (1)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [noteid]        INT           NOT NULL,
    [sort_num]      SMALLINT      NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjacct0] PRIMARY KEY CLUSTERED ([acct] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjacct1]
    ON [dbo].[PJACCT]([sort_num] ASC, [acct] ASC) WITH (FILLFACTOR = 90);

