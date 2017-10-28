CREATE TABLE [dbo].[PJRULES] (
    [acct]          CHAR (16)     NOT NULL,
    [bill_type_cd]  CHAR (4)      NOT NULL,
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [li_type]       CHAR (1)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [noteid]        INT           NOT NULL,
    [ru_id01]       CHAR (30)     NOT NULL,
    [ru_id02]       CHAR (16)     NOT NULL,
    [ru_id03]       CHAR (4)      NOT NULL,
    [ru_id04]       CHAR (4)      NOT NULL,
    [ru_id05]       CHAR (4)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjrules0] PRIMARY KEY CLUSTERED ([bill_type_cd] ASC, [acct] ASC) WITH (FILLFACTOR = 90)
);

