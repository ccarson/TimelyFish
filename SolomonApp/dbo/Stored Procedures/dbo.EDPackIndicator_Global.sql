 Create Proc EDPackIndicator_Global @PackIndicator varchar(1) As
Select * From EDPackIndicator Where IndicatorType = 1 And PackIndicator Like @PackIndicator Order By IndicatorType, InvtId, PackIndicator


