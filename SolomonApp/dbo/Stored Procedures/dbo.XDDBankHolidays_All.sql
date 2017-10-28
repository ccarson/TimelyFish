CREATE PROCEDURE XDDBankHolidays_All @parm1beg smalldatetime, @parm1end smalldatetime as
  Select * from XDDBankHolidays where
  Holiday Between @parm1beg and @parm1end
  Order by Holiday
