 CREATE PROCEDURE pp_CleanWrkRelease_PO  @UserAddress char(21)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	DELETE WrkRelease_PO where UserAddress = @UserAddress



