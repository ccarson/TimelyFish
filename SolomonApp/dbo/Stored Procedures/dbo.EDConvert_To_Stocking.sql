 CREATE PROCEDURE EDConvert_To_Stocking @Invtid varchar(30), @EDIUom varchar(6) AS
Declare @StockUnit varchar(6)
declare @MultDiv varchar(1)
declare @CnvFact float
declare @UnitTypeToUnit varchar(6)
declare @ClassId varchar(6)
--Based on the invtid and ClassID passed in this will get the stocking unit
select @StockUnit = stkunit, @ClassId = ClassId from inventory where invtid = @invtid
--This will get the MultDiv and CnvFact fron InUnit table, assuming that the incoming UOM
--is the fromunit and the tounit is the stockingunit
select @MultDiv = MultDiv, @CnvFact = CnvFact, @UnitTypeToUnit = ToUnit from inunit
where (fromunit = @EDIUom) and (tounit = @StockUnit)
And InvtId In (@InvtId,'*') And ClassId In (@ClassId,'*') Order By UnitType
if isnull(@MultDiv, '~') = '~'
   begin
--This will get the MultDiv and CnvFact fron InUnit table, assuming that the incoming UOM
--is the tounit and the fromunit is the stockingunit
    select @MultDiv = MultDiv, @CnvFact = CnvFact, @UnitTypeToUnit = ToUnit from inunit
    where (tounit = @EDIUom) and (fromunit = @StockUnit)
    And InvtId In (@InvtId,'*') And ClassId In (@ClassId,'*') Order By UnitType
   end
-- Slick trick here, if the from UOM is not the same, then the to uom matches, must switch the MultDiv flag to invert the operation
if @UnitTypeToUnit = @EdiUom
  begin
    if @MultDiv = 'M'
      Select @MultDiv = 'D'
    else
      Select @MultDiv = 'M'
  end
select @MultDiv, @CnvFact, @StockUnit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDConvert_To_Stocking] TO [MSDSL]
    AS [dbo];

