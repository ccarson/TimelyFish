
CREATE PROCEDURE Pjemppjt_ep_id05 @parm1 VARCHAR (10),
                                  @parm2 VARCHAR (16),
                                  @parm3 SMALLDATETIME
AS
    SELECT ep_id05
    FROM   PJEMPPJT
    WHERE  employee = @parm1
           AND project = @parm2
           AND effect_date <= @parm3
    ORDER  BY employee,
              project,
              effect_date DESC


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Pjemppjt_ep_id05] TO [MSDSL]
    AS [dbo];

