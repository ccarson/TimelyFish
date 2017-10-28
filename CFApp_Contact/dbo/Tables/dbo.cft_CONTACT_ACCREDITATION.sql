CREATE TABLE [dbo].[cft_CONTACT_ACCREDITATION] (
    [AccreditationID]             INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]                   INT          NOT NULL,
    [AccreditationTypeID]         INT          NULL,
    [AccreditationNumber]         VARCHAR (10) NOT NULL,
    [AccreditationState]          VARCHAR (2)  NULL,
    [AccreditationExpirationDate] DATETIME     NULL,
    [CreatedDateTime]             DATETIME     CONSTRAINT [DF_cft_CONTACT_ACCREDIDATION_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                   VARCHAR (50) NOT NULL,
    [UpdatedDateTime]             DATETIME     NULL,
    [UpdatedBy]                   VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTACT_ACCREDIDATION] PRIMARY KEY CLUSTERED ([AccreditationID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [IX_cft_CONTACT_ACCREDITATION_Contact_State_Expiration] UNIQUE NONCLUSTERED ([ContactID] ASC, [AccreditationState] ASC, [AccreditationExpirationDate] ASC) WITH (FILLFACTOR = 90)
);

