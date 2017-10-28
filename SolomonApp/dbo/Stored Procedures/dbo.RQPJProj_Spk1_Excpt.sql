 /****** Object:  Stored Procedure dbo.RQPJProj_Spk1_Excpt    Script Date: 7/16/2004 10:05:46 AM ******/

CREATE Procedure RQPJProj_Spk1_Excpt @Parm1 Varchar(16), @Parm2 varchar(16) as
select * from PJPROJ where Project <> @parm1 and project like @parm2 and status_pa = 'A' and status_po = 'A' order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQPJProj_Spk1_Excpt] TO [MSDSL]
    AS [dbo];

