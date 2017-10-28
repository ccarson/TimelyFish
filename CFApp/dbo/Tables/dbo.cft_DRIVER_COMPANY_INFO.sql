CREATE TABLE [dbo].[cft_DRIVER_COMPANY_INFO] (
    [ContactID]            INT           NOT NULL,
    [SelectedStatus]       INT           CONSTRAINT [DF_cft_DRIVER_COMPANY_INFO_SelectedStatus] DEFAULT (1) NOT NULL,
    [TruckCompanyComments] VARCHAR (500) NULL,
    CONSTRAINT [PK_cft_DRIVER_COMPANY_INFO] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);

