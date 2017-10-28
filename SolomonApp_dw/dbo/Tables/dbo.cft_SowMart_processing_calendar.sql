CREATE TABLE [dbo].[cft_SowMart_processing_calendar] (
    [picyear_week] VARCHAR (6)   NOT NULL,
    [daydate]      SMALLDATETIME NOT NULL,
    [siteid]       INT           NOT NULL,
    [identityid]   INT           NOT NULL,
    [gest_flg]     SMALLINT      NULL,
    [lact_flg]     SMALLINT      NULL
);

