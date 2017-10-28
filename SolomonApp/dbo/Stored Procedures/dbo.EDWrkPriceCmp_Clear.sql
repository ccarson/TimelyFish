 Create Proc EDWrkPriceCmp_Clear @ComputerName VarChar(21) As
Delete From EDWrkPriceCmp Where ComputerId = @ComputerName


