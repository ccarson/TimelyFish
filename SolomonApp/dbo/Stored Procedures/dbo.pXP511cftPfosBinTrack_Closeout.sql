Create Procedure [dbo].[pXP511cftPfosBinTrack_Closeout] @PigGroupID varchar (10) as

select bt.* 
FROM [SolomonApp].[dbo].[cftPfosBinTrack] bt (nolock)
join (SELECT [PigGroupID], [BinNbr], max([IDPfosBinTrack]) idpfosbintrack
FROM [SolomonApp].[dbo].[cftPfosBinTrack] (nolock)
group by [PigGroupID], [BinNbr]) max
on max.piggroupid = bt.piggroupid and max.binnbr = bt.binnbr and max.idpfosbintrack = bt.idpfosbintrack
Where bt.PigGroupID like @PigGroupId 
Order by bt.BinNbr

