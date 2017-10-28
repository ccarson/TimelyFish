CREATE TABLE [dbo].[ROIHeader] (
    [Format]       CHAR (30)  NOT NULL,
    [NamedDefault] CHAR (8)   NOT NULL,
    [RI_ID]        SMALLINT   NOT NULL,
    [Comments]     TEXT       NOT NULL,
    [tstamp]       ROWVERSION NOT NULL,
    CONSTRAINT [ROIHeader0] PRIMARY KEY CLUSTERED ([RI_ID] ASC) WITH (FILLFACTOR = 90)
);

