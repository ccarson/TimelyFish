 Create Proc pjsubven_upd
	@VendID as char (15),
	@Vend_Name as char (60)

as

update pjsubven set vend_name = @Vend_Name
 where vendid = @VendID and @Vend_Name <> vend_name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjsubven_upd] TO [MSDSL]
    AS [dbo];

