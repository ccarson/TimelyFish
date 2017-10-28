 create proc DMG_Plan_SOPlan_Insert
	@compleadtime		smallint,
	@cpnyid			varchar(10),
	@displayseq		varchar(36),
	@fixedalloc		smallint,
	@hold			smallint,
	@invtid			varchar(30),
	@plandate		smalldatetime,
	@planref		varchar(10),
	@plantype		varchar(2),
	@poallocref		varchar(5),
	@polineref		varchar(5),
	@ponbr			varchar(10),
	@priority		smallint,
	@prioritydate		smalldatetime,
	@priorityseq		integer,
	@prioritytime		smalldatetime,
	@promdate		smalldatetime,
	@promshipdate		smalldatetime,
	@qty			decimal(25,9),
	@qtyship		decimal(25,9),
	@s4future08		smalldatetime,
	@s4future09		integer,
	@s4future10		integer,
	@shipcmplt		smallint,
	@siteid			varchar(10),
	@soetadate		smalldatetime,
	@solineref		varchar(5),
	@soordnbr		varchar(15),
	@soreqdate		smalldatetime,
	@soreqshipdate		smalldatetime,
	@soschedref		varchar(5),
	@soshipperid		varchar(15),
	@soshipperlineref	varchar(5),
	@soshipviaid		varchar(15),
	@sotransittime		smallint,
	@soweekenddelivery	smallint
as
	insert soplan (	compleadtime,cpnyid,crtd_datetime,crtd_prog,crtd_user,displayseq,fixedalloc,hold,
			invtid,plandate,planref,plantype,poallocref,
			polineref,ponbr,priority,prioritydate,priorityseq,
			prioritytime,promdate,promshipdate,qty,qtyship,
			s4future08,s4future09,s4future10,shipcmplt,siteid,
			soetadate,solineref,soordnbr,soreqdate,soreqshipdate,
			soschedref,soshipperid,soshipperlineref,soshipviaid,sotransittime,
			soweekenddelivery)
	values (	@compleadtime,@cpnyid,getdate(),'SQL','SQL',@displayseq,@fixedalloc,@hold,
			@invtid,@plandate,@planref,@plantype,@poallocref,
			@polineref,@ponbr,@priority,@prioritydate,@priorityseq,
			@prioritytime,@promdate,@promshipdate,@qty,@qtyship,
			@s4future08,@s4future09,@s4future10,@shipcmplt,@siteid,
			@soetadate,@solineref,@soordnbr,@soreqdate,@soreqshipdate,
			@soschedref,@soshipperid,@soshipperlineref,@soshipviaid,@sotransittime,
			@soweekenddelivery)

	if @@ROWCOUNT = 0
		return 0
	else
		return 1


