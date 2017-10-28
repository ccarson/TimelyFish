 Create Proc EDWrkPOToSO_Clear @AccessNbr smallint As
Delete From EDWrkPOToSO Where AccessNbr = @AccessNbr


