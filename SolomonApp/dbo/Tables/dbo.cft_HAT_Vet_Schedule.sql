CREATE TABLE [dbo].[cft_HAT_Vet_Schedule] (
    [ScheduleID]     INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]  VARCHAR (6)  NOT NULL,
    [VetContactID]   VARCHAR (6)  NULL,
    [TargetDate]     DATETIME     NOT NULL,
    [ActualTestDate] DATETIME     NULL,
    [ExpireDate]     DATETIME     NOT NULL,
    [Status]         SMALLINT     NOT NULL,
    [crtd_DateTime]  DATETIME     DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]      VARCHAR (15) DEFAULT (substring(host_name(),(1),(15))) NOT NULL,
    [crtd_User]      VARCHAR (50) DEFAULT (substring(original_login(),(1),(50))) NOT NULL,
    [Lupd_DateTime]  DATETIME     NULL,
    [Lupd_Prog]      VARCHAR (15) NULL,
    [Lupd_User]      VARCHAR (50) NULL,
    CONSTRAINT [PK_cftHATVetSchedule] PRIMARY KEY CLUSTERED ([ScheduleID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IX_cft_HAT_VetSchedule_1]
    ON [dbo].[cft_HAT_Vet_Schedule]([ActualTestDate] ASC)
    INCLUDE([SiteContactID]);

