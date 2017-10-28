 Create Proc EDPackIndicate_GetIndicator @InvtId varchar(30), @Qty float As
	Select PackIndicator
	From EDPackIndicator
	Where InvtId In (@InvtId, '*') And ContainerQty = @Qty
	Order By IndicatorType Desc


