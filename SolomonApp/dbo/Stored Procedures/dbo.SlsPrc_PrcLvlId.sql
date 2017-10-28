 /****** Object:  Stored Procedure dbo.SlsPrc_PrcLvlId    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.SlsPrc_PrcLvlId    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc SlsPrc_PrcLvlId @Parm1 varchar(10) as
   Select * from slsprc where prclvlid like @parm1 and ltrim(prclvlid) <> ''
      Order by prclvlid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrc_PrcLvlId] TO [MSDSL]
    AS [dbo];

