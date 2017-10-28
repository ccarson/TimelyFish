

/***  View: KSYNCTABLES
*/
create view dbo.KSYNCTABLES
as
    select
        case when o.name is null then k.TABLENAME else o.name end as TABLENAME,
        case when u.name is null then k.OWNER else u.name end as OWNER,
        k.SUBJECT_AREA,
        k.LABEL,
        case when k.TYPE is null then o.type else k.TYPE end as TYPE,
        k.UPDATABLE,
        k.HIDDEN,
        k.DRS_OBJECT,
        k.BASE_TABLES,
        k.REMARKS,
        k.FIELD_INFO
    from dbo.sysobjects o
        join sysusers u on o.uid = u.uid
        full outer join dbo.KSYNCTABLESBASE k on o.name = k.TABLENAME and u.name = k.OWNER
    where k.TYPE = 'obj'
        or o.type = 'U'
        or o.type = 'V'
        or o.type = 'P'
