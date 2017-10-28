
/****** Object:  Stored Procedure dbo.pXF172PfosBinOffset    Script Date: 9/20/2005 12:04:44 PM ******/
Create Procedure [dbo].[pXF172PfosBinOffset] @PigGroupId varchar (10) as

Select bo.*
from cftPfosBinoffset as bo
Where bo.[Statusflg] like 'O'
and bo.PigGroupId like @PigGroupId
Order by bo.PigGroupId, bo.EmptyBinNbr
	
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF172PfosBinOffset] TO [MSDSL]
    AS [dbo];

