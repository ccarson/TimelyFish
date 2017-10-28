
CREATE PROCEDURE [dbo].[PJINDSRC_update_insert]
    @prog varchar (8),
    @user varchar (10),
    @period varchar (6),
    @project varchar (16),
    @pjt_entity varchar (32),
    @alloc_method_cd varchar (4),
    @step_number smallint,
    @src_acct varchar (16),
    @src_CpnyId varchar (10),
    @src_gl_subacct varchar (24),
    @emp_CpnyId varchar (10),
    @emp_gl_subacct varchar (24),
    @amount float,
    @precision integer AS

SET NOCOUNT ON
DECLARE @fsyear_num varchar(4) = LEFT(@period, 4)
DECLARE @period_num varchar(2) = RIGHT(@period, 2)

IF EXISTS(select *
           from PJINDSRC
           where fsyear_num        = @fsyear_num
             and project           = @project
             and pjt_entity        = @pjt_entity
             and alloc_method_cd   = @alloc_method_cd
             and step_number       = @step_number
             and src_acct          = @src_acct
             and src_CpnyId        = @src_CpnyId
             and src_gl_subacct    = @src_gl_subacct
             and emp_CpnyId        = @emp_CpnyId
             and emp_gl_subacct    = @emp_gl_subacct)
    UPDATE PJINDSRC
      SET lupd_datetime = GETDATE(),
          lupd_prog = @prog,
          lupd_user = @user,
          amount_01 = CASE WHEN @period_num = '01' THEN ROUND(CONVERT(DEC(28, 3), amount_01) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_01 END,
          amount_02 = CASE WHEN @period_num = '02' THEN ROUND(CONVERT(DEC(28, 3), amount_02) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_02 END,
          amount_03 = CASE WHEN @period_num = '03' THEN ROUND(CONVERT(DEC(28, 3), amount_03) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_03 END,
          amount_04 = CASE WHEN @period_num = '04' THEN ROUND(CONVERT(DEC(28, 3), amount_04) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_04 END,
          amount_05 = CASE WHEN @period_num = '05' THEN ROUND(CONVERT(DEC(28, 3), amount_05) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_05 END,
          amount_06 = CASE WHEN @period_num = '06' THEN ROUND(CONVERT(DEC(28, 3), amount_06) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_06 END,
          amount_07 = CASE WHEN @period_num = '07' THEN ROUND(CONVERT(DEC(28, 3), amount_07) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_07 END,
          amount_08 = CASE WHEN @period_num = '08' THEN ROUND(CONVERT(DEC(28, 3), amount_08) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_08 END,
          amount_09 = CASE WHEN @period_num = '09' THEN ROUND(CONVERT(DEC(28, 3), amount_09) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_09 END,
          amount_10 = CASE WHEN @period_num = '10' THEN ROUND(CONVERT(DEC(28, 3), amount_10) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_10 END,
          amount_11 = CASE WHEN @period_num = '11' THEN ROUND(CONVERT(DEC(28, 3), amount_11) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_11 END,
          amount_12 = CASE WHEN @period_num = '12' THEN ROUND(CONVERT(DEC(28, 3), amount_12) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_12 END,
          amount_13 = CASE WHEN @period_num = '13' THEN ROUND(CONVERT(DEC(28, 3), amount_13) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_13 END,
          amount_14 = CASE WHEN @period_num = '14' THEN ROUND(CONVERT(DEC(28, 3), amount_14) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_14 END,
          amount_15 = CASE WHEN @period_num = '15' THEN ROUND(CONVERT(DEC(28, 3), amount_15) + CONVERT(DEC(28, 3), @amount), @precision) ELSE amount_15 END
      WHERE @amount <> 0
        AND fsyear_num        = @fsyear_num
        AND project           = @project
        AND pjt_entity        = @pjt_entity
        AND alloc_method_cd   = @alloc_method_cd
        AND step_number       = @step_number
        AND src_acct          = @src_acct
        AND src_CpnyId        = @src_CpnyId
        AND src_gl_subacct    = @src_gl_subacct
        AND emp_CpnyId        = @emp_CpnyId
        AND emp_gl_subacct    = @emp_gl_subacct
ELSE
    INSERT PJINDSRC (alloc_method_cd, amount_01, amount_02, amount_03, amount_04, amount_05, amount_06, amount_07,
                     amount_08, amount_09, amount_10, amount_11, amount_12, amount_13, amount_14, amount_15,
                     crtd_datetime, crtd_prog, crtd_user, emp_CpnyId, emp_gl_subacct, fsyear_num, lupd_datetime,
                     lupd_prog, lupd_user, pjt_entity, project, src_acct, src_CpnyId, src_gl_subacct, step_number)
        VALUES (@alloc_method_cd,
                CASE WHEN @period_num = '01' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '02' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '03' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '04' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '05' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '06' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '07' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '08' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '09' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '10' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '11' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '12' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '13' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '14' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                CASE WHEN @period_num = '15' THEN ROUND(CONVERT(DEC(28, 3), @amount), @precision) ELSE 0 END,
                GETDATE(), @prog, @user, @emp_CpnyId, @emp_gl_subacct, @fsyear_num, GETDATE(), @prog, @user,
                @pjt_entity, @project, @src_acct, @src_CpnyId, @src_gl_subacct, @step_number)

