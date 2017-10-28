

CREATE FUNCTION [caresystem].[CFF_GetFarrowParity] (@identityId int, @eventDate datetime)
 RETURNS int WITH SCHEMABINDING
AS
BEGIN
  DECLARE @parity int;
  DECLARE @InitialParity int;
  SELECT @parity = Sum(1)
    FROM caredata.bh_events
   WHERE identity_id = @identityId
     and deletion_date IS NULL
     and event_type = 170 
     and eventdate <= @eventDate
  SELECT @InitialParity = sh.[starting_parity]
  FROM [caredata].[HDR_SOWS] sh (NOLOCK)
  WHERE identity_id = @identityId
  RETURN (ISNULL(@parity ,0) + ISNULL(@InitialParity ,0));
END
