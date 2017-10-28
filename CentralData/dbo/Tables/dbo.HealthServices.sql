CREATE TABLE [dbo].[HealthServices] (
    [ContactID]    INT           NOT NULL,
    [VetVisit]     SMALLDATETIME NULL,
    [Tattoo]       VARCHAR (100) NULL,
    [Age]          VARCHAR (15)  NULL,
    [VetContactID] INT           NULL,
    CONSTRAINT [PK_HealthServices] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

