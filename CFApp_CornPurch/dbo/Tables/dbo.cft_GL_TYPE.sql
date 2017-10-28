CREATE TABLE [dbo].[cft_GL_TYPE] (
    [GlTypeID]        INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            VARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_GL_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_GL_TYPE] PRIMARY KEY CLUSTERED ([GlTypeID] ASC) WITH (FILLFACTOR = 90)
);

