 Create Procedure EDWrkContPrint_DelForAccessNbr
	@AccessNbr Integer
As
Delete From EDWrkContPrint Where AccessNbr = @AccessNbr


