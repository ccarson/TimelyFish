 create proc ADG_BookingsBySalesperson
	@cpnyid		varchar(10),
	@DateFrom	smalldatetime,
	@DateTo		smalldatetime,
	@Period		varchar(6),
	@SlsperID	varchar(10)


as
	If @Period = ''
		select	Sum(Book.BookCommCost) BookCommCost, Sum(Book.BookCost) BookCost,
			Sum(Book.BookSls) BookSls, Sum(Book.CommCost) CuryBookCommCost,
			Sum(Book.Cost) CuryBookCost, Sum(Book.SlsPrice) CuryBookSls,
			Book.S4Future01, Book.S4Future02, Sum(Book.S4Future03), Sum(Book.S4Future04),
			Sum(Book.S4Future05), Sum(Book.S4Future06), Book.S4Future07, Book.S4Future08,
			Sum(Book.S4Future09), Sum(Book.S4Future10), Book.S4Future11, Book.S4Future12,
			Book.SlsperID, Salesperson.Name,
			Sum(Book.User5) User5, Sum(Book.User6) User6
		from	Book
		  left join Salesperson
			on Book.SlsperID = Salesperson.SlsperId
		where	Book.CpnyID = @Cpnyid
		  and	Book.EffDate >= @DateFrom and Book.EffDate < DateAdd(Day, 1, @DateTo)
		  and	Book.SlsperID like @SlsperID
		group By Book.SlsperID, Salesperson.Name, Book.S4Future01, Book.S4Future02,
			Book.S4Future07, Book.S4Future08, Book.S4Future11, Book.S4Future12
	else
		select	Sum(Book.BookCommCost) BookCommCost, Sum(Book.BookCost) BookCost,
			Sum(Book.BookSls) BookSls, Sum(Book.CommCost) CuryBookCommCost,
			Sum(Book.Cost) CuryBookCost, Sum(Book.SlsPrice) CuryBookSls,
			Book.S4Future01, Book.S4Future02, Sum(Book.S4Future03), Sum(Book.S4Future04),
			Sum(Book.S4Future05), Sum(Book.S4Future06), Book.S4Future07, Book.S4Future08,
			Sum(Book.S4Future09), Sum(Book.S4Future10), Book.S4Future11, Book.S4Future12,
			Book.SlsperID, Salesperson.Name,
			Sum(Book.User5) User5, Sum(Book.User6) User6
		from	Book
		  left join Salesperson
			on Book.SlsperID = Salesperson.SlsperID
		where	Book.CpnyID = @Cpnyid
		  and	Period = @Period
		  and	Book.SlsperID like @SlsperID
		group By Book.SlsperID, Salesperson.Name, Book.S4Future01, Book.S4Future02,
			Book.S4Future07, Book.S4Future08, Book.S4Future11, Book.S4Future12

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


