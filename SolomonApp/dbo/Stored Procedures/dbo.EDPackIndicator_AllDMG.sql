 CREATE Proc EDPackIndicator_AllDMG @IndicatorTypeMin smallint, @IndicatorTypeMax smallint, @InvtId varchar(30), @PackIndicator varchar(1) As
Select * From EDPackIndicator Where IndicatorType Between @IndicatorTypeMin And @IndicatorTypeMax
And InvtId Like @InvtId And PackIndicator Like @PackIndicator
Order By IndicatorType, InvtId, PackIndicator


