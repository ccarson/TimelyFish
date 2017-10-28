CREATE TABLE [dbo].[cft_DRIVER_INFO] (
    [DriverID]                  INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactID]                 INT           NOT NULL,
    [DriverOrigin]              VARCHAR (50)  NULL,
    [DriverCodeID]              INT           NOT NULL,
    [TrailerNumber]             VARCHAR (50)  NOT NULL,
    [DriverName]                VARCHAR (50)  NULL,
    [DriverStatusID]            INT           NOT NULL,
    [DriverBusinessPhoneNumber] VARCHAR (50)  NULL,
    [DriverCellPhoneNumber]     VARCHAR (50)  NULL,
    [DriverEmail]               VARCHAR (50)  NULL,
    [DriverComments]            VARCHAR (250) NULL,
    [TrailerID]                 VARCHAR (5)   NULL,
    CONSTRAINT [PK_cft_DRIVER_INFO] PRIMARY KEY CLUSTERED ([DriverID] ASC) WITH (FILLFACTOR = 90)
);

