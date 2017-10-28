
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE pXP215_cftPigGroup
	@ContactID varchar(6),
	@PigGroupID varchar(10)
	AS
	Select * from cftPigGroup 
	Where cftPigGroup.SiteContactId = @ContactID --parm1
	AND PigGroupID LIKE @PigGroupID -- parm2
	Order by PigGroupId

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP215_cftPigGroup] TO [MSDSL]
    AS [dbo];

