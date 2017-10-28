 CREATE Procedure EDContainer_SetBOLNbr @CpnyId varchar (10), @ShipperId varchar(15), @BOLNbr varchar(20) As
Update EDContainer Set BOLNbr = @BOLNbr Where CpnyId = @CpnyId And ShipperId = @ShipperId


