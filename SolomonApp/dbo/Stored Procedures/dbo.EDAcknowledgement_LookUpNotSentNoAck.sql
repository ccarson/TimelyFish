 Create Proc EDAcknowledgement_LookUpNotSentNoAck @EntityId varchar(20), @EntityType smallint As
Select * From EDAcknowledgement Where EntityId = @EntityId And EntityType = @EntityType And ISANbr = 0 And STNbr = 0


