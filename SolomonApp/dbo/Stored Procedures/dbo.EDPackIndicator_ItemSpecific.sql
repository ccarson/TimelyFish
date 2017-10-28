 CREATE Proc EDPackIndicator_ItemSpecific @InvtId varchar(30), @PackIndicator varchar(1) As
Select * From EDPackIndicator Where IndicatorType = 2 And InvtId Like @InvtId And PackIndicator Like @PackIndicator Order By IndicatorType, InvtId, PackIndicator


