 CREATE Proc EDGetItemXRefs @InvtId varchar(30), @EntityId varchar(15) As

Declare @CustPart varchar(30)
Declare @EAN varchar(30)
Declare @ISBN varchar(30)
Declare @SKU varchar(30)
Declare @UCC varchar(30)
Declare @MfgPart varchar(30)
Declare @MilitarySpec varchar(30)
Declare @NDC varchar(30)
Declare @PDN varchar(30)
Declare @UPC varchar(30)
Declare @PDC varchar(30)
Declare @AlternateId varchar(30)
Declare @AltIdType varchar(1)
Declare csr_ItemXRef Cursor For

Select AlternateId, AltIdType From EDItemXRefOneEntityRef Where InvtId = @InvtId And EntityId = @EntityId
Union
Select AlternateId, AltIdType From EDItemXRef_MaxGlobal A Where InvtId = @InvtId And Not Exists (Select* From EDItemXRefOneEntityRef B Where A.InvtId = B.InvtId And A.AltIdType = B.AltIdType And B.EntityId = @EntityId)

-- initialize
Set @CustPart = ' '
Set @EAN = ' '
Set @ISBN = ' '
Set @SKU = ' '
Set @UCC = ' '
Set @MfgPart = ' '
Set @MilitarySpec = ' '
Set @NDC = ' '
Set @PDN = ' '
Set @UPC = ' '
Set @PDC = ' '
Open csr_ItemXref
Fetch Next From csr_ItemXRef Into @AlternateId, @AltIdType

-- loop through records
While @@Fetch_Status <> -1
  Begin
    If @AltIdType = 'C'  Set @CustPart = @AlternateId
      Else
       If @AltIdType = 'E'  Set @EAN = @AlternateId
         Else
           If @AltIdType = 'B' Set @ISBN = @AlternateId
             Else
               If @AltIdType = 'K' Set @SKU = @AlternateId
                 Else
                   If @AltIdType = 'U' Set @UPC = @AlternateId
                     Else
                       If @AltIdType = 'X' Set @UCC = @AlternateId -- need to replace 'X' when real value once DMG adds it to Item X Ref screen
                         Else
                           If @AltIdType =  'I' Set @MilitarySpec = @AlternateId
                             Else
                               If @AltIdType =  'D' Set @NDC = @AlternateId
                                 Else
                                   If @AltIdType =  'P' Set @PDC = @AlternateId
                                     Else
                                       If @AltIdType =  'M' Set @MfgPart = @AlternateId
    Fetch Next From csr_ItemXRef Into @AlternateId, @AltIdType
  End
Close csr_ItemXRef
Deallocate csr_ItemXRef

Select @InvtId, @EntityId, @CustPart, @EAN, @ISBN, @SKU, @UPC, @UCC, @MilitarySpec, @NDC, @PDC, @MfgPart



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDGetItemXRefs] TO [MSDSL]
    AS [dbo];

