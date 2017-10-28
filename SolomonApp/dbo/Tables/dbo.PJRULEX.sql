CREATE TABLE [dbo].[PJRULEX] (
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [line_num]      SMALLINT      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [project]       CHAR (16)     NOT NULL,
    [rx_id01]       CHAR (30)     NOT NULL,
    [rx_id02]       CHAR (16)     NOT NULL,
    [rx_id03]       CHAR (4)      NOT NULL,
    [rx_id04]       CHAR (4)      NOT NULL,
    [rx_id05]       CHAR (4)      NOT NULL,
    [select_item1]  CHAR (40)     NOT NULL,
    [select_item2]  CHAR (40)     NOT NULL,
    [select_item3]  CHAR (40)     NOT NULL,
    [select_value1] CHAR (30)     NOT NULL,
    [select_value2] CHAR (30)     NOT NULL,
    [select_value3] CHAR (30)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [pjrulex0] PRIMARY KEY CLUSTERED ([project] ASC, [line_num] ASC) WITH (FILLFACTOR = 90)
);

