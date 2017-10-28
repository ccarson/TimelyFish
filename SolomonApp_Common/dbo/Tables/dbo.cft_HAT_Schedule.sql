﻿CREATE TABLE [dbo].[cft_HAT_Schedule] (
    [ScheduleID]         INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]      VARCHAR (6)    NOT NULL,
    [VetContactID]       VARCHAR (6)    NULL,
    [DeliveredBy]        VARCHAR (20)   NULL,
    [LabID]              INT            NULL,
    [SPID]               INT            NOT NULL,
    [TestDate]           DATETIME       NOT NULL,
    [LabDate]            DATETIME       NULL,
    [ExpireDate]         DATETIME       NOT NULL,
    [CaseID]             VARCHAR (10)   NULL,
    [ResultsFileURL]     VARCHAR (2083) NULL,
    [ApprovedBy]         VARCHAR (20)   NULL,
    [Status]             SMALLINT       NOT NULL,
    [TestComment]        VARCHAR (255)  NULL,
    [Last_Comm_DateTime] DATETIME       NULL,
    [crtd_DateTime]      DATETIME       DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]          VARCHAR (15)   DEFAULT (substring(host_name(),(1),(15))) NOT NULL,
    [crtd_User]          VARCHAR (50)   DEFAULT (substring(original_login(),(1),(50))) NOT NULL,
    [Lupd_DateTime]      DATETIME       NULL,
    [Lupd_Prog]          VARCHAR (15)   NULL,
    [Lupd_User]          VARCHAR (50)   NULL,
    [Type]               SMALLINT       NULL,
    [Lab]                VARCHAR (50)   NULL,
    CONSTRAINT [PK_cftHATSchedule] PRIMARY KEY CLUSTERED ([ScheduleID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_HAT_Schedule_2_cft_HAT_Results_CaseID] FOREIGN KEY ([CaseID]) REFERENCES [dbo].[cft_HAT_Results] ([CaseID])
);
