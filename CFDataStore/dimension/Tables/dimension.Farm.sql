CREATE TABLE [dimension].[Farm] (
    [FarmKey]      BIGINT           IDENTITY (1, 1) NOT NULL,
    [IsActive]     BIT              NOT NULL,
    [FarmNumber]   NVARCHAR (10)    NOT NULL,
    [FarmName]     NVARCHAR (30)    NOT NULL,
    [TattooLength] TINYINT          NOT NULL,
    [FarmGUID]     UNIQUEIDENTIFIER NOT NULL,
    [MainSiteID]   INT              NULL,
    [CreatedDate]  DATETIME         DEFAULT (getdate()) NOT NULL,
    [CreatedBy]    BIGINT           DEFAULT ((-1)) NOT NULL,
    [UpdatedDate]  DATETIME         NULL,
    [UpdatedBy]    BIGINT           NULL,
    [SourceID]     INT              NOT NULL,
    [SourceGUID]   NVARCHAR (36)    NOT NULL,
    CONSTRAINT PK_Farm PRIMARY KEY CLUSTERED ([FarmKey] ASC)
);
