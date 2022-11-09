with
fk as (
    select i.rdb$relation_name as table_name,
           s.rdb$field_name as field_name,
           i2.rdb$relation_name as references_table,
           s2.rdb$field_name as references_field
    from rdb$index_segments s
    left join rdb$indices i on
    i.rdb$index_name = s.rdb$index_name
    left join rdb$relation_constraints rc on
    rc.rdb$index_name = s.rdb$index_name
    left join rdb$ref_constraints refc on
    rc.rdb$constraint_name = refc.rdb$constraint_name
    left join rdb$relation_constraints rc2 on
    rc2.rdb$constraint_name = refc.rdb$const_name_uq
    left join rdb$indices i2 on
    i2.rdb$index_name = rc2.rdb$index_name
    left join rdb$index_segments s2 on
    i2.rdb$index_name = s2.rdb$index_name
    where rc.rdb$constraint_type = 'FOREIGN KEY'
    order by s.rdb$field_position  
)
select rf.rdb$relation_name as table_name,
       rf.rdb$field_name as field_name,
       case f.rdb$field_type
           when 7 then 'SMALLINT'
           when 8 then 'INTEGER'
           when 10 then 'FLOAT'
           when 12 then 'DATE'
           when 13 then 'TIME'
           when 14 then 'CHAR'
           when 16 then 'BIGINT'
           when 27 then 'DOUBLE PRECISION'
           when 35 then 'TIMESTAMP'
           when 37 then 'VARCHAR'
           when 261 then 'BLOB' || iif(f.rdb$field_sub_type = 0, ' BINARY', 'TEXT')
           else ''
       end as field_type,
       iif(f.rdb$field_type in (14, 37), (trunc(f.rdb$field_length / ch.rdb$bytes_per_character)), 0) as field_length,
       iif(ix.rdb$index_name <> '', 'S', '') as field_is_pk,
       iif(fk.table_name is null, '', 'S') as field_is_fk,
       fk.references_table
from rdb$relation_fields rf 
inner join rdb$fields f on
f.rdb$field_name = rf.rdb$field_source
left join rdb$indices ix on
ix.rdb$relation_name = rf.rdb$relation_name and
ix.rdb$index_id = rf.rdb$field_position +1 and
ix.rdb$foreign_key is null                
left outer join rdb$character_sets ch on
ch.rdb$character_set_id = f.rdb$character_set_id
left join fk on
fk.table_name = rf.rdb$relation_name and
fk.field_name = rf.rdb$field_name
where rf.rdb$relation_name = Upper(:table_name)
order by rf.rdb$field_position