CREATE TABLE [dbo].[xfuturepricing] (
    [Mon]       CHAR (10)  NOT NULL,
    [Yr]        CHAR (10)  NOT NULL,
    [Price]     FLOAT (53) NOT NULL,
    [PricingID] CHAR (10)  NOT NULL,
    [tstamp]    ROWVERSION NULL,
    CONSTRAINT [xfuturepricing0] PRIMARY KEY CLUSTERED ([PricingID] ASC) WITH (FILLFACTOR = 90)
);

