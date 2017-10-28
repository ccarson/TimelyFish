/****** Object:  StoredProcedure [dbo].[Fetch_ModulePerNbr]    Script Date: 02/25/2009 14:35:24 ******/
CREATE Proc  [dbo].[Fetch_ModulePerNbr] as

declare @GLPer char(6)
declare @PRPer char(6)
declare @APPer char(6)
declare @PCPer char(6)
declare @ARPer char(6)
declare @INPer char(6)
declare @CAPer char(6)
declare @BMPer char(6)
declare @BRPer char(6)
declare @WOPer char(6)

select @GLPer=PerNbr from GLSetup (NOLOCK)
select @PRPer=PerNbr from PRSetup (NOLOCK)
select @APPer=PerNbr from APSetup (NOLOCK)
select @PCPer=PerNbr from PCSetup (NOLOCK)
select @ARPer=PerNbr from ARSetup (NOLOCK)
select @INPer=PerNbr from INSetup (NOLOCK)
select @CAPer=PerNbr from CASetup (NOLOCK)
select @BMPer=PerNbr from BMSetup (NOLOCK)
select @BRPer=PerNbr from BRSetup (NOLOCK)
select @WOPer=PerNbr from WOSetup (NOLOCK)

Select GLPer=ISNULL(@GLPer,''), PRPer=ISNULL(@PRPer,''), APPer=ISNULL(@APPer,''), PCPer=ISNULL(@PCPer,''), ARPer=ISNULL(@ARPer,''),
       INPer=ISNULL(@INPer,''), CAPer=ISNULL(@CAPer,''), BMPer=ISNULL(@BMPer,''), BRPer=ISNULL(@BRPer,''), WOPer=ISNULL(@WOPer,'')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_ModulePerNbr] TO [MSDSL]
    AS [dbo];

