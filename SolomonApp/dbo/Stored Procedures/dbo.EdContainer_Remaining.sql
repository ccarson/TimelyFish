 Create Procedure EdContainer_Remaining @CpnyId varchar(10), @ShipperId varchar(15) As
Select Count(*) From EDContainer Where CpnyId = @CpnyId And ShipperId = @ShipperId And LabelLastPrinted = '1900-01-01'


