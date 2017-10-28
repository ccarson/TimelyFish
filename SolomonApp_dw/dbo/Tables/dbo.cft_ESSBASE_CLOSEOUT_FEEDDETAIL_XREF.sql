CREATE TABLE [dbo].[cft_ESSBASE_CLOSEOUT_FEEDDETAIL_XREF] (
    [Module]  CHAR (16)    NOT NULL,
    [BatNbr]  CHAR (10)    NOT NULL,
    [RefNbr]  CHAR (15)    NOT NULL,
    [TaskID]  CHAR (32)    NOT NULL,
    [Account] CHAR (32)    NULL,
    [Value]   NUMERIC (18) NULL
);

