






--*************************   Post Ship query
CREATE VIEW [dbo].[cfv_HAT_VET_PMLoads]
AS
SELECT 
       [SourceContactID]
	  ,SA.State SourceState
	 
	  ,[DestContactID]
	  ,DA.State as DestState
      ,[ID]
      ,[MarketSaleTypeID]
      ,[MovementDate]
      ,[PigTypeID]
      ,[PMID]
      ,[PMLoadID]
      ,[PMSystemID]
      ,[PMTypeID]
      ,[TranSubTypeID]
      
      ,[WalkThrough]
      
  FROM [SolomonApp].[dbo].[cftPM] PM (nolock)
   join [SolomonApp].[dbo].[cftContactAddress] DAID  (nolock) on PM.[DestContactID] = DAID.ContactID and DAID.AddressTypeID = '01'
  join [SolomonApp].[dbo].[cftAddress] DA (nolock)  on DAID.AddressID = DA.AddressID
   join [SolomonApp].[dbo].[cftContactAddress] SAID (nolock)  on PM.[SourceContactID] = SAID.ContactID and SAID.AddressTypeID = '01'
  join [SolomonApp].[dbo].[cftAddress] SA  (nolock) on SAID.AddressID = sA.AddressID
  
  where da.state <> ''
  and sa.state <> ''
  and da.state <> sa.state



