 Create Proc EDCheck_UOM2 @UOM varchar(6), @InvtId varchar(30), @ClassId varchar(6) As
Declare @RetVal smallint
Declare @UomCount int
Select @UomCount = Count(*) From InUnit Where (FromUnit = @UOM Or ToUnit = @UOM) And InvtId In (@InvtId,'*') And ClassId In (@ClassId,'*')
If @UomCount > 0
  Begin
  Select @Retval = 0
  End
Else
  Begin
  Select @Retval = 9
End
Select @Retval



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCheck_UOM2] TO [MSDSL]
    AS [dbo];

