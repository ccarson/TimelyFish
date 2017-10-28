CREATE TABLE [dbo].[AP03730_Wrk] (
    [RI_ID]      SMALLINT   NOT NULL,
    [VendId]     CHAR (15)  NULL,
    [GL_SetupId] CHAR (2)   NULL,
    [AP_SetupId] CHAR (2)   NULL,
    [tstamp]     ROWVERSION NOT NULL
);

