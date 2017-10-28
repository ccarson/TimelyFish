 Create Procedure AltIDCount
	@EntityID varchar (10),
	@AlternateID varchar(30)

As
SELECT Count(AlternateID)
  FROM ItemXRef
 WHERE EntityID = @EntityID and AlternateID = @AlternateID


