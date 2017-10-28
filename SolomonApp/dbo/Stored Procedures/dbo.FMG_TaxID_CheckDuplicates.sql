 create procedure FMG_TaxID_CheckDuplicates
	@TaxID	varchar(10),
	@TaxID1	varchar(10),
	@TaxID2	varchar(10),
	@TaxID3	varchar(10)
as
	declare @Count smallint
	declare @GroupTaxID bit

	-- returns
	-- 0 if no duplicates are found
	-- 1 if the first tax id is duplicated directly by one of the others
	-- 2 if the first tax id is duplicated as a group member of one of the others
	-- 3 if the first tax id is a group and one of its members is directly duplicated by one of the others
	-- 4 if the first tax id is a group and one of its members is duplicated as a group member of one of the others
	-- of its members is duplicated as a member of a group
	-- tax id

	if (select TaxType from SalesTax (NOLOCK) where TaxID = @TaxID) = 'G'
		set @GroupTaxID = 1
	else
		set @GroupTaxID = 0

	-- The first tax id is duplicated directly by one of the others
	if @TaxID = @TaxID1 or @TaxID = @TaxID2 or @TaxID = @TaxID3
		--select 1
		return 1

	-- The first tax id is duplicated as a group member of one of the others
	select @Count = count(*)
	from SalesTax s1 (NOLOCK)
	join SlsTaxGrp s2 (NOLOCK) on s1.TaxID = s2.TaxID
	where s1.TaxID = @TaxID
	and (s2.GroupID = @TaxID1 or s2.GroupID = @TaxID2 or s2.GroupID = @TaxID3)

	if @Count > 0
		--select 2
		return 2

	if @GroupTaxID = 1
	begin

		-- The first tax id is a group and one of its members is directly duplicated by one of the others
		select @Count = count(*)
		from SlsTaxGrp s1 (NOLOCK)
		where s1.GroupID = @TaxID
		and (s1.TaxID = @TaxID1 or s1.TaxID = @TaxID2 or s1.TaxID = @TaxID3)

		if @Count > 0
			--select 3
			return 3

		-- The first tax id is a group and one of its members is duplicated as a group member of one of the others
		select @Count = count(*)
		from SlsTaxGrp s1 (NOLOCK)
		inner join SlsTaxGrp s2 (NOLOCK) on s2.TaxID = s1.TaxID and s2.GroupID <> s1.GroupID
		where s1.GroupID = @TaxID
		and (s2.GroupID = @TaxID1 or s2.GroupID = @TaxID2 or s2.GroupID = @TaxID3)

		if @Count > 0
			--select 4
			return 4
	end

	-- No duplicates were found
	--select 0
	return 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_TaxID_CheckDuplicates] TO [MSDSL]
    AS [dbo];

