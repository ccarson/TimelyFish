CREATE TABLE [dbo].[SiteDivDept] (
    [ContactID]       INT           NOT NULL,
    [Div]             CHAR (2)      NOT NULL,
    [Dept]            CHAR (2)      NOT NULL,
    [SiteID]          VARCHAR (4)   NOT NULL,
    [EffectiveDate]   SMALLDATETIME NOT NULL,
    [EffectivePeriod] CHAR (6)      NOT NULL,
    CONSTRAINT [PK_SiteDivDept] PRIMARY KEY CLUSTERED ([ContactID] ASC, [EffectiveDate] ASC) WITH (FILLFACTOR = 90)
);
