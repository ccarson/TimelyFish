CREATE TABLE [dbo].[PJCODE] (
    [code_type]       CHAR (4)      NOT NULL,
    [code_value]      CHAR (30)     NOT NULL,
    [code_value_desc] CHAR (30)     NOT NULL,
    [crtd_datetime]   SMALLDATETIME NOT NULL,
    [crtd_prog]       CHAR (8)      NOT NULL,
    [crtd_user]       CHAR (10)     NOT NULL,
    [data1]           CHAR (30)     NOT NULL,
    [data2]           CHAR (16)     NOT NULL,
    [data3]           SMALLDATETIME NOT NULL,
    [data4]           FLOAT (53)    NOT NULL,
    [lupd_datetime]   SMALLDATETIME NOT NULL,
    [lupd_prog]       CHAR (8)      NOT NULL,
    [lupd_user]       CHAR (10)     NOT NULL,
    [noteid]          INT           NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [pjcode0] PRIMARY KEY CLUSTERED ([code_type] ASC, [code_value] ASC) WITH (FILLFACTOR = 90)
);

