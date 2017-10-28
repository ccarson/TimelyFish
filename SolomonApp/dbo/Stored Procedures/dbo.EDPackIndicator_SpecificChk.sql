 Create Proc EDPackIndicator_SpecificChk @InvtId varchar(30) As
Select Count(*) From EDPackIndicator Where IndicatorType = 2 And InvtId = @InvtId


