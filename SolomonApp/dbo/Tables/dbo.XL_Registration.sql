CREATE TABLE [dbo].[XL_Registration] (
    [UnlockCode] VARCHAR (20) NOT NULL,
    [tstamp]     ROWVERSION   NOT NULL,
    CONSTRAINT [XL_Registration0] PRIMARY KEY CLUSTERED ([UnlockCode] ASC) WITH (FILLFACTOR = 90)
);

