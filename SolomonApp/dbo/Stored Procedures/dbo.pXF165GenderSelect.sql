

Create Procedure [dbo].[pXF165GenderSelect] as

SELECT [PigGenderTypeID]
      ,[Description]
      
  FROM [SolomonApp].[dbo].[cftPigGenderType]
  order by [Description]
	
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF165GenderSelect] TO [MSDSL]
    AS [dbo];

