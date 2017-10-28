CREATE TABLE [dbo].[PCNetFosterPWM] (
    [FarmID]           VARCHAR (8)   NOT NULL,
    [WeekOfDate]       SMALLDATETIME NOT NULL,
    [NetFoster]        SMALLINT      NULL,
    [PreWeanMortality] FLOAT (53)    NULL,
    CONSTRAINT [PK_PCNetFosterPWM] PRIMARY KEY CLUSTERED ([FarmID] ASC, [WeekOfDate] ASC) WITH (FILLFACTOR = 90)
);

