use MedCenterDB
go

if OBJECT_ID('dbo.usp_AddCheckConstraint', 'P') is not null
    drop procedure dbo.usp_AddCheckConstraint
go

create proc dbo.usp_AddCheckConstraint(
    @tableName nvarchar(100),
    @condition nvarchar(100),
    @constraintName nvarchar(100)
)
as
begin
    declare @sqlString nvarchar(max)

    set @sqlString =
            '
            if OBJECT_ID(''{constraintName}'', ''C'') is not null
                alter table {tableName}
                    drop constraint {constraintName}

            alter table {tableName}
                add constraint {constraintName}
                    check ({condition})
            '

    set @sqlString = replace(@sqlString, '{tableName}', @tableName)
    set @sqlString = replace(@sqlString, '{condition}', @condition)
    set @sqlString = replace(@sqlString, '{constraintName}', @constraintName)

    exec (@sqlString)
end
go