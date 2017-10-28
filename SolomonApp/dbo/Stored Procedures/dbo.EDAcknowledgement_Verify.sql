 CREATE Proc EDAcknowledgement_Verify @EntityType smallint, @IsaNbr int, @StNbr int, @GSRcvId varchar(15) As
Select Count(*), Max(EntityId) From EDAcknowledgement Where EntityType = @EntityType And IsaNbr = @IsaNbr And StNbr = @StNbr And GSRcvId = @GSRcvId


