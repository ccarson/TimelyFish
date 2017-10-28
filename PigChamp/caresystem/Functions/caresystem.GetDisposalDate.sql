CREATE FUNCTION [caresystem].[GetDisposalDate] (@identityId int)
 RETURNS datetime WITH SCHEMABINDING
AS
BEGIN
  DECLARE @disposaldate datetime;
  SELECT @disposaldate = eventdate
    FROM caredata.bh_events
   WHERE identity_id = @identityId
     and deletion_date IS NULL
     and event_type IN (298, 299, 300, 301)
  RETURN @disposaldate;
END
