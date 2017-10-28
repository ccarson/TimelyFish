 	Create Procedure Update_component_stepnbr @kitid varchar(30), @kitsiteid varchar(10),
		@kitstatus varchar(1), @rtgstep smallint, @updtrtgstep smallint as
        	UPDATE component
		SET rtgstep = @updtrtgstep
		WHERE kitid = @kitid and
	      	KitsiteId = @kitsiteid and
	      	Kitstatus = @kitstatus and
	      	rtgstep = @rtgstep



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Update_component_stepnbr] TO [MSDSL]
    AS [dbo];

