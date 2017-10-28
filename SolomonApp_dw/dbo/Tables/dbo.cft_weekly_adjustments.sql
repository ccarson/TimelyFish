CREATE TABLE [dbo].[cft_weekly_adjustments] (
    [PICWeek]             SMALLINT   NOT NULL,
    [AdjWgt_Gain]         FLOAT (53) NOT NULL,
    [AdjFeed_Consumption] FLOAT (53) NOT NULL,
    CONSTRAINT [pk_cft_weekly_adjustments] PRIMARY KEY CLUSTERED ([PICWeek] ASC) WITH (FILLFACTOR = 80)
);

