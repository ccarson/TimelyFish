create view dbo.cfv_FIRST75M_ALL
AS
select * from cfv_FIRST75M_GROUP cfv_FIRST75M_GROUP
where not exists (select * from cfv_FIRST75M_ROOM where PigGroupID = cfv_FIRST75M_GROUP.PigGroupID)
union all
select * from cfv_FIRST75M_ROOM
