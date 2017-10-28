

Create Procedure [dbo].[pXF165MillSelect] as

SELECT [MillId]
      ,[ContactName]  as Name
  FROM [SolomonApp].[dbo].[cfvMills]
  order by [ContactName]
	
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF165MillSelect] TO [MSDSL]
    AS [dbo];

