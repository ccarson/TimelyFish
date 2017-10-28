
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE Procedure pXF135_cftPigGroup_PigGroupId @parm1 varchar (6), @parm2 varchar (10) as 
    Select * from cftPigGroup Where SiteContactId = @parm1 and PigGroupId Like @parm2
	and Exists (Select * from cftPGStatus Where cftPigGroup.PGStatusId = PGStatusId and
	Status_PA = 'A' and Status_IN = 'A')
	Order by PigGroupId

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF135_cftPigGroup_PigGroupId] TO [MSDSL]
    AS [dbo];

