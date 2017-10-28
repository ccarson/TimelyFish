:CONNECT CFSE-SQL06T
GO

Use CFDataStore
GO

truncate table   [dimension].[Animal]
truncate table   [dimension].[AnimalTag]
truncate table   [dimension].[Drug]
--truncate table   [dimension].[Farm]
truncate table   [dimension].[FarmAnimal]
--truncate table   [dimension].[Genetics]
--truncate table   [dimension].[Location]
truncate table   [dimension].[MatingGroup]
--truncate table   [dimension].[Observer]
--truncate table   [dimension].[Origin]
truncate table   [fact].[ArrivalEvent]
truncate table   [fact].[FalloutEvent]
truncate table   [fact].[FarrowEvent]
truncate table   [fact].[FosterEvent]
truncate table   [fact].[MatingEvent]
truncate table   [fact].[NurseEvent]
truncate table   [fact].[ObservedHeatEvent]
truncate table   [fact].[ParityEvent]
truncate table   [fact].[PregnancyExamEvent]
truncate table   [fact].[PreWeanDeathEvent]
truncate table   [fact].[RemovalEvent]
truncate table   [fact].[RetagEvent]
truncate table   [fact].[SalesEvent]
truncate table   [fact].[TransferEvent]


truncate table   [fact].[WeanEvent]
truncate table   [stage].[BH_EVENTS]
truncate table   [stage].[BH_IDENTITIES]
truncate table   [stage].[BH_IDENTITY_HISTORY]
truncate table   [stage].[BH_DELETED_IDENTITY_HISTORY]
truncate table   [stage].[BH_DELETED_EVENTS]