 /****** Object:  Stored Procedure dbo.Slsprc_Slsunit    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Slsprc_Slsunit    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Slsprc_Slsunit @Parm1 VarChar(1), @Parm2 VarChar(6), @Parm3 VarChar(30), @Parm4 VarChar(6) as
select * from inunit where unittype = @Parm1  and Classid = @Parm2 and Invtid = @Parm3 and
fromunit like @Parm4 order by unittype



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Slsprc_Slsunit] TO [MSDSL]
    AS [dbo];

