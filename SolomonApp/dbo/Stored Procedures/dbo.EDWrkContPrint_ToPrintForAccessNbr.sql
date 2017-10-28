 CREATE PROCEDURE EDWrkContPrint_ToPrintForAccessNbr
	@AccessNbr Integer
AS
Select CpnyId, ShipperId from EDWrkContPrint
where AccessNbr = @AccessNbr and Selected = 1
order by ShipperId


