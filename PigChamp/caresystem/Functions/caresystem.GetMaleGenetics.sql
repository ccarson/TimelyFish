CREATE FUNCTION [caresystem].[GetMaleGenetics] (@identityId int)
  RETURNS INT WITH SCHEMABINDING
AS
BEGIN
  DECLARE @geneticsId INT;
  SET @geneticsId = NULL;
  IF @geneticsId IS NULL
  BEGIN
  SELECT @geneticsId = genetics_id
    FROM caredata.hdr_boars
   WHERE identity_id = @identityId
  END
  IF @geneticsId IS NULL
  BEGIN
    SELECT @geneticsId = b.genetics_id
      FROM caredata.ev_semen_collections c 
               INNER JOIN caredata.hdr_boars b ON c.identity_id = b.identity_id
     WHERE c.batch_identity_id = @identityId
  END
  IF @geneticsId IS NULL
  BEGIN
  SELECT @geneticsId = genetics_id
    FROM caredata.ev_semen_deliveries
   WHERE identity_id = @identityId
  END 
  RETURN @geneticsId;
END
