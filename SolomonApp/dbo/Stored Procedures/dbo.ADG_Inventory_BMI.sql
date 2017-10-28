 create proc ADG_Inventory_BMI
as
	declare @BMIEnabled	smallint
	declare @MCActivated	smallint
	declare	@Enabled	smallint

	select	@MCActivated = MCActivated
	from	CMSetup (nolock)

	select	@BMIEnabled = BMIEnabled
	from	INSetup (nolock)

	select	(coalesce(@MCActivated, 0) & coalesce(@BMIEnabled, 0))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_BMI] TO [MSDSL]
    AS [dbo];

