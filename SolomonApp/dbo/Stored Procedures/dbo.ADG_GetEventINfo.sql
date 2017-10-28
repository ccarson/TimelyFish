 create proc ADG_GetEventINfo
	@cpnyid			varchar (10),
	@sotypeid		varchar (4)
as

	Select FunctionID, FunctionClass from SOStep where CpnyId = @cpnyid
						 and SOTypeId = @sotypeid
                                        	 and EventType = 'PINV'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_GetEventINfo] TO [MSDSL]
    AS [dbo];

