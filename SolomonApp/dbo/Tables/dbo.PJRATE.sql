CREATE TABLE [dbo].[PJRATE] (
    [crtd_datetime]   SMALLDATETIME NOT NULL,
    [crtd_prog]       CHAR (8)      NOT NULL,
    [crtd_user]       CHAR (10)     NOT NULL,
    [curyid]          CHAR (4)      NOT NULL,
    [data1]           CHAR (16)     NOT NULL,
    [data2]           FLOAT (53)    NOT NULL,
    [effect_date]     SMALLDATETIME NOT NULL,
    [lupd_datetime]   SMALLDATETIME NOT NULL,
    [lupd_prog]       CHAR (8)      NOT NULL,
    [lupd_user]       CHAR (10)     NOT NULL,
    [noteid]          INT           NOT NULL,
    [rate]            FLOAT (53)    NOT NULL,
    [rate_key_value1] CHAR (32)     NOT NULL,
    [rate_key_value2] CHAR (32)     NOT NULL,
    [rate_key_value3] CHAR (32)     NOT NULL,
    [rate_level]      CHAR (1)      NOT NULL,
    [rate_table_id]   CHAR (4)      NOT NULL,
    [rate_type_cd]    CHAR (2)      NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [pjrate0] PRIMARY KEY CLUSTERED ([rate_table_id] ASC, [rate_type_cd] ASC, [rate_level] ASC, [rate_key_value1] ASC, [rate_key_value2] ASC, [rate_key_value3] ASC, [effect_date] ASC) WITH (FILLFACTOR = 90)
);

