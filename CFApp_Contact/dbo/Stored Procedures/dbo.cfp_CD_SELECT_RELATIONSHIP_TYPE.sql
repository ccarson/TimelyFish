
-- ==================================================================
-- Author:		Doran Dahle
-- Create date: 06/03/2015
-- Description:	CENTRAL DATA - Returns all Relationships by type 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_SELECT_RELATIONSHIP_TYPE]
(
	@RelationshipType	varchar(20)
)
AS
BEGIN
	SET NOCOUNT ON;

SELECT [cftRelationshipID]
      ,[Relationship]
      ,[Relationship_Type]
  FROM [$(CentralData)].[dbo].[cftRelationship]
  WHere [ActiveFlag] like 'Y'
  and [Relationship_Type] like @RelationshipType
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_SELECT_RELATIONSHIP_TYPE] TO [db_sp_exec]
    AS [dbo];

