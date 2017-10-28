 Create Procedure Update_Component_KitStatus @kitid varchar(30), @kitsiteid varchar(10),
					@kitstatus varchar(1), @newkitstatus varchar (1) as
        UPDATE Component SET
		KitStatus = @NewKitStatus
	WHERE kitid = @kitid and
	      KitsiteId = @kitsiteid and
	      Kitstatus = @kitstatus



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_Component_KitStatus] TO [MSDSL]
    AS [dbo];

