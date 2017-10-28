

CREATE FUNCTION [caresystem].[CFF_GetMateNbr] (@identityId int, @eventDate datetime)
 RETURNS int WITH SCHEMABINDING
AS
BEGIN
  DECLARE @mating int;
  SELECT @mating = Sum(1)
    FROM caredata.bh_events ev (NOLOCK)
	left join [caredata].[EV_MATINGS] mate on ev.identity_id = mate.identity_id and ev.[event_id] = mate.[event_id]
   WHERE ev.identity_id = @identityId
     and ev.deletion_date IS NULL
     and ev.event_type = 270 
     and ev.eventdate <= @eventDate
	 group by mate.service_group
  RETURN ISNULL(@mating,1);
END

GO
GRANT EXECUTE
    ON OBJECT::[caresystem].[CFF_GetMateNbr] TO [SSIS_Operator]
    AS [care];

