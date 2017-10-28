


create Procedure [dbo].[pXF165PigGroupCheck] 
@FlowID varchar(3)
as 
SELECT Count(PG.[PigGroupID]) as cbt
  FROM [SolomonApp].[dbo].[cftPigGroup] PG With (NOLOCK)
  where PG.[PGStatusID] in ('A','F') 
  and PG.[PigProdPhaseID] in ('WTF','NUR','FIN') 
  and PG.CF08 = @FlowID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF165PigGroupCheck] TO [MSDSL]
    AS [dbo];

