

Create Procedure [dbo].[pXF165SystemSelect] as

SELECT [PigSystemID] 
      ,[Description]
  FROM [SolomonApp].[dbo].[cftPigSystem]
  order by [PigSystemID]
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF165SystemSelect] TO [MSDSL]
    AS [dbo];

