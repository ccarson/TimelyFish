CREATE TABLE [dbo].[smServFault] (
    [AssignDate]    SMALLDATETIME NOT NULL,
    [AssignTime]    CHAR (4)      NOT NULL,
    [CallContract]  CHAR (1)      NOT NULL,
    [CallRetainer]  CHAR (1)      NOT NULL,
    [CauseID]       CHAR (10)     NOT NULL,
    [ContractID]    CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Duration]      CHAR (4)      NOT NULL,
    [ElapsedTime]   FLOAT (53)    NOT NULL,
    [Empid]         CHAR (10)     NOT NULL,
    [EmpStatus]     CHAR (2)      NOT NULL,
    [EndDate]       SMALLDATETIME NOT NULL,
    [EndMiles]      FLOAT (53)    NOT NULL,
    [EndTime]       CHAR (4)      NOT NULL,
    [EquipID]       CHAR (10)     NOT NULL,
    [FaultCodeId]   CHAR (10)     NOT NULL,
    [Invtid]        CHAR (30)     NOT NULL,
    [LineId]        SMALLINT      NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [Notes]         CHAR (60)     NOT NULL,
    [PMCode]        CHAR (10)     NOT NULL,
    [PromDate]      SMALLDATETIME NOT NULL,
    [PromTime]      CHAR (4)      NOT NULL,
    [ResolutionID]  CHAR (10)     NOT NULL,
    [RMA]           CHAR (1)      NOT NULL,
    [RMANbr]        CHAR (15)     NOT NULL,
    [RMAType]       CHAR (1)      NOT NULL,
    [SerialNbr]     CHAR (30)     NOT NULL,
    [ServiceCallId] CHAR (10)     NOT NULL,
    [SF_ID01]       CHAR (30)     NOT NULL,
    [SF_ID02]       CHAR (30)     NOT NULL,
    [SF_ID03]       CHAR (20)     NOT NULL,
    [SF_ID04]       CHAR (20)     NOT NULL,
    [SF_ID05]       CHAR (10)     NOT NULL,
    [SF_ID06]       CHAR (10)     NOT NULL,
    [SF_ID07]       CHAR (4)      NOT NULL,
    [SF_ID08]       FLOAT (53)    NOT NULL,
    [SF_ID09]       SMALLDATETIME NOT NULL,
    [SF_ID10]       INT           NOT NULL,
    [SF_ID11]       CHAR (30)     NOT NULL,
    [SF_ID12]       CHAR (30)     NOT NULL,
    [SF_ID13]       CHAR (20)     NOT NULL,
    [SF_ID14]       CHAR (20)     NOT NULL,
    [SF_ID15]       CHAR (10)     NOT NULL,
    [SF_ID16]       CHAR (10)     NOT NULL,
    [SF_ID17]       CHAR (4)      NOT NULL,
    [SF_ID18]       FLOAT (53)    NOT NULL,
    [SF_ID19]       SMALLDATETIME NOT NULL,
    [SF_ID20]       SMALLINT      NOT NULL,
    [StartDate]     SMALLDATETIME NOT NULL,
    [StartMiles]    FLOAT (53)    NOT NULL,
    [StartTime]     CHAR (4)      NOT NULL,
    [TaskStatus]    CHAR (2)      NOT NULL,
    [TechStatusID]  CHAR (10)     NOT NULL,
    [TimeCardID]    CHAR (10)     NOT NULL,
    [ToolID]        CHAR (10)     NOT NULL,
    [TravelTime]    CHAR (4)      NOT NULL,
    [Unit]          CHAR (10)     NOT NULL,
    [user1]         CHAR (30)     NOT NULL,
    [user2]         CHAR (30)     NOT NULL,
    [user3]         FLOAT (53)    NOT NULL,
    [user4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [User9]         SMALLINT      NOT NULL,
    [VehicleId]     CHAR (10)     NOT NULL,
    [VendId]        CHAR (15)     NOT NULL,
    [WarrEnd]       SMALLDATETIME NOT NULL,
    [WarrStart]     SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smServFault0] PRIMARY KEY CLUSTERED ([ServiceCallId] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smServFault1]
    ON [dbo].[smServFault]([TaskStatus] ASC, [StartDate] ASC, [EndDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServFault2]
    ON [dbo].[smServFault]([StartDate] ASC, [EndDate] ASC, [TaskStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServFault3]
    ON [dbo].[smServFault]([ServiceCallId] ASC, [TaskStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smServFault_GDB1]
    ON [dbo].[smServFault]([Empid] ASC, [StartDate] DESC, [EndDate] ASC) WITH (FILLFACTOR = 90);

