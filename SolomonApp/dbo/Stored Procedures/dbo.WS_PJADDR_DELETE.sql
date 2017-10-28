CREATE PROCEDURE WS_PJADDR_DELETE
@addr_key char(48), @addr_key_cd char(2), @addr_type_cd char(2), @tstamp timestamp
AS
BEGIN
DELETE FROM [PJADDR]
WHERE [addr_key] = @addr_key AND 
[addr_key_cd] = @addr_key_cd AND 
[addr_type_cd] = @addr_type_cd AND 
[tstamp] = @tstamp;
End
