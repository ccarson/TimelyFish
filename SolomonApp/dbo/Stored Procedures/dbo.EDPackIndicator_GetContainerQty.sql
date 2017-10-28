 Create Proc EDPackIndicator_GetContainerQty @InvtId varchar(30), @PackIndicator varchar(1) As
Select ContainerQty From EDPackIndicator Where Invtid In (@InvtId, '*') And PackIndicator =
@PackIndicator Order By IndicatorType Desc


