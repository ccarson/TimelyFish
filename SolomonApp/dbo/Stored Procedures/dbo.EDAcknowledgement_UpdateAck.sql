 CREATE Proc EDAcknowledgement_UpdateAck @EntityType smallint, @EntityId varchar(20), @ISANbr int, @STNbr int, @GSRcvId varchar(15) As
Update EDAcknowledgement Set AckStatus = 1, AckDate = GetDate() Where EntityType = @EntityType And EntityId = @EntityId And ISANbr = @ISANbr And STNbr = @STNbr And GSRcvId = @GSRcvId


