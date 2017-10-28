 /****** Object:  Stored Procedure dbo.SNote_All    Script Date: 4/17/98 12:50:25 PM ******/
Create Proc SNote_All @lMin int, @lMax int as
    SELECT * FROM SNote WHERE nID BETWEEN @lMin and @lMax



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SNote_All] TO [MSDSL]
    AS [dbo];

