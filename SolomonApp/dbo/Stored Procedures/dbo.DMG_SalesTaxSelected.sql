 create procedure DMG_SalesTaxSelected
	@TaxID		varchar(10),
	@CatExcept00	varchar(10) OUTPUT,
	@CatExcept01	varchar(10) OUTPUT,
	@CatExcept02	varchar(10) OUTPUT,
	@CatExcept03	varchar(10) OUTPUT,
	@CatExcept04	varchar(10) OUTPUT,
	@CatExcept05	varchar(10) OUTPUT,
	@CatFlg		varchar(1) OUTPUT,
	@Descr		varchar(30) OUTPUT,
	@InclFrt	varchar(1) OUTPUT,
	@InclInDocTot	varchar(1) OUTPUT,
	@InclMisc	varchar(1) OUTPUT,
	@Lvl2Exmpt	integer OUTPUT,
	@SlsTaxAcct	varchar(10) OUTPUT,
	@SlsTaxSub	varchar(30) OUTPUT,
	@TaxBasis	varchar(1) OUTPUT,
	@TaxCalcLvl	varchar(1) OUTPUT,
	@TaxCalcType	varchar(1) OUTPUT,
	@TaxRate	decimal(25,9) OUTPUT,
	@TaxType	varchar(1) OUTPUT,
	@TxblMax	decimal(25,9) OUTPUT,
	@TxblMin	decimal(25,9) OUTPUT,
	@TxblMinMaxCuryID varchar(4) OUTPUT
as
	select	@CatExcept00 = ltrim(rtrim(CatExcept00)),
		@CatExcept01 = ltrim(rtrim(CatExcept01)),
		@CatExcept02 = ltrim(rtrim(CatExcept02)),
		@CatExcept03 = ltrim(rtrim(CatExcept03)),
		@CatExcept04 = ltrim(rtrim(CatExcept04)),
		@CatExcept05 = ltrim(rtrim(CatExcept05)),
		@CatFlg = ltrim(rtrim(CatFlg)),
		@Descr = ltrim(rtrim(Descr)),
		@InclFrt = ltrim(rtrim(InclFrt)),
		@InclInDocTot = ltrim(rtrim(InclInDocTot)),
		@InclMisc = ltrim(rtrim(InclMisc)),
		@Lvl2Exmpt = Lvl2Exmpt,
		@SlsTaxAcct = ltrim(rtrim(SlsTaxAcct)),
		@SlsTaxSub = ltrim(rtrim(SlsTaxSub)),
		@TaxBasis = ltrim(rtrim(TaxBasis)),
		@TaxCalcLvl = ltrim(rtrim(TaxCalcLvl)),
		@TaxCalcType = ltrim(rtrim(TaxCalcType)),
		@TaxRate = TaxRate,
		@TaxType = ltrim(rtrim(TaxType)),
		@TxblMax = TxblMax,
		@TxblMin = TxblMin,
		@TxblMinMaxCuryID = ltrim(rtrim(TxblMinMaxCuryID))
	from	SalesTax (NOLOCK)
	where	TaxID = @TaxID
	and	TaxType in ('G','T')

	if @@ROWCOUNT = 0 begin
		set @CatExcept00 = ''
		set @CatExcept01 = ''
		set @CatExcept02 = ''
		set @CatExcept03 = ''
		set @CatExcept04 = ''
		set @CatExcept05 = ''
		set @CatFlg = ''
		set @Descr = ''
		set @InclFrt = ''
		set @InclMisc = ''
		set @InclInDocTot = ''
		set @Lvl2Exmpt = 0
		set @SlsTaxAcct = ''
		set @SlsTaxSub = ''
		set @TaxBasis = ''
		set @TaxCalcLvl = ''
		set @TaxCalcType = ''
		set @TaxRate = 0
		set @TaxType = ''
		set @TxblMin = 0
		set @TxblMax = 0
		set @TxblMinMaxCuryID = ''
		return 0	--Failure
	end
	else
		--select @CatExcept00,@CatExcept01,@CatExcept02,@CatExcept03,@CatExcept04,@CatExcept05,
		--	@CatFlg,@Descr,@InclFrt,@InclInDocTot,@InclMisc,@Lvl2Exmpt,@SlsTaxAcct,
		--	@SlsTaxSub,@TaxBasis,@TaxCalcLvl,@TaxCalcType,@TaxRate,@TaxType,@TxblMin,
		--	@TxblMax,@TxblMinMaxCuryID
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SalesTaxSelected] TO [MSDSL]
    AS [dbo];

