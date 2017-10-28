CREATE TABLE [dbo].[GLCodes] (
    [Company]             INT         NOT NULL,
    [SiteOwnershipTypeID] INT         NOT NULL,
    [FacilityTypeID]      INT         NOT NULL,
    [DepartmentCode]      INT         NULL,
    [OtherGLCode]         VARCHAR (4) NULL,
    [PigRelatedGLCode]    VARCHAR (4) NULL,
    CONSTRAINT [PK_GLCodes] PRIMARY KEY CLUSTERED ([Company] ASC, [SiteOwnershipTypeID] ASC, [FacilityTypeID] ASC) WITH (FILLFACTOR = 90)
);

