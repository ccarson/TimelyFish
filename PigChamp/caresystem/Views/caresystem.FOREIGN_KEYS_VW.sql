CREATE VIEW [caresystem].[FOREIGN_KEYS_VW]
AS
SELECT f.name constraint_name
     , sq.name primary_schema_name
     , oq.name primary_table_name
     , cq.name primary_col_name
     , sp.name detail_schema_name
     , op.name detail_table_name
     , cp.name detail_col_name
     , CASE WHEN cd.name IS NULL THEN 0 ELSE 1 END is_deletion
     , f.update_referential_action
  FROM sys.foreign_key_columns c inner join sys.foreign_keys f on f.object_id = c.constraint_object_id
                                 inner join sys.objects op on c.parent_object_id = op.object_id
                                 inner join sys.schemas sp on op.schema_id = sp.schema_id
                                 inner join sys.columns cp on c.parent_column_id = cp.column_id and c.parent_object_id = cp.object_id
                                 left outer join sys.columns cd on Lower(cd.name) = 'deletion_date' and op.object_id = cd.object_id
                                 inner join sys.objects oq on c.referenced_object_id = oq.object_id
                                 inner join sys.schemas sq on op.schema_id = sq.schema_id
                                 inner join sys.columns cq on c.referenced_column_id = cq.column_id and c.referenced_object_id = cq.object_id;
