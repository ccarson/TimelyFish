﻿
create procedure PJTRANWK_irecalc @parm1 varchar (16) , @parm2 smalldatetime , @parm3 smalldatetime, @parm4 varchar (10), @parm5 varchar (6), @parm6 varchar (6) as
insert into pjtranwk
    (acct,
    alloc_flag,
    amount,
    BaseCuryId,
    batch_id,
    batch_type,
    bill_batch_id,
    CpnyId,
    crtd_datetime,
    crtd_prog,
    crtd_user,
    CuryEffDate,
    CuryId,
    CuryMultDiv,
    CuryRate,
    CuryRateType,
    CuryTranAmt,
    data1,
    detail_num,
    employee,
    fiscalno,
    gl_acct,
    gl_subacct,
    lupd_datetime,
    lupd_prog,
    lupd_user,
    noteId,
    pjt_entity,
    post_date,
    ProjCury_amount,
    ProjCuryEffDate,
    ProjCuryId,
    ProjCuryMultiDiv,
    ProjCuryRate,
    ProjCuryRateType,
    project,
    Subcontract,
    subtask_name,
    system_cd,
    TranProjCuryEffDate,
    TranProjCuryId,
    TranProjCuryMultiDiv,
    TranProjCuryRate,
    TranProjCuryRateType,
    trans_date,
    tr_comment,
    tr_id01,
    tr_id02,
    tr_id03,
    tr_id04,
    tr_id05,
    tr_id06,
    tr_id07,
    tr_id08,
    tr_id09,
    tr_id10,
    tr_id23,
    tr_id24,
    tr_id25,
    tr_id26,
    tr_id27,
    tr_id28,
    tr_id29,
    tr_id30,
    tr_id31,
    tr_id32,
    tr_status,
    unit_of_measure,
    units,
    user1,
    user2,
    user3,
    user4,
    vendor_num,
    voucher_line,
    voucher_num,
    alloc_batch)
select
    acct,
    alloc_flag,
    amount,
    BaseCuryId,
    batch_id,
    batch_type,
    bill_batch_id,
    CpnyId,
    crtd_datetime,
    crtd_prog,
    crtd_user,
    CuryEffDate,
    CuryId,
    CuryMultDiv,
    CuryRate,
    CuryRateType,
    CuryTranAmt,
    data1,
    detail_num,
    employee,
    fiscalno,
    gl_acct,
    gl_subacct,
    lupd_datetime,
    lupd_prog,
    lupd_user,
    noteId,
    pjt_entity,
    post_date,
    ProjCury_amount,
    ProjCuryEffDate,
    ProjCuryId,
    ProjCuryMultiDiv,
    ProjCuryRate,
    ProjCuryRateType,
    project,
    Subcontract,
    subtask_name,
    system_cd,
    TranProjCuryEffDate,
    TranProjCuryId,
    TranProjCuryMultiDiv,
    TranProjCuryRate,
    TranProjCuryRateType,
    trans_date,
    tr_comment,
    tr_id01,
    tr_id02,
    tr_id03,
    tr_id04,
    tr_id05,
    tr_id06,
    tr_id07,
    tr_id08,
    tr_id09,
    tr_id10,
    tr_id23,
    tr_id24,
    tr_id25,
    tr_id26,
    tr_id27,
    tr_id28,
    tr_id29,
    tr_id30,
    tr_id31,
    tr_id32,
    tr_status,
    unit_of_measure,
    units,
    user1,
    user2,
    user3,
    user4,
    vendor_num,
    voucher_line,
    voucher_num,
    @parm4
from pjtran
where
    project = @parm1 and
    alloc_flag <> 'X' and
    trans_date >= @parm2 and
    trans_date <= @parm3 and
    fiscalno >= @parm5 and
    fiscalno <= @parm6
