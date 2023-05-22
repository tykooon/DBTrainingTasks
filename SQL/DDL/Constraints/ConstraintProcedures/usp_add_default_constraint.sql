use MedCenterDB
go

if OBJECT_ID('dbo.usp_AddDefaultConstraint', 'P') is not null
    drop procedure dbo.usp_AddDefaultConstraint
go

create proc dbo.usp_AddDefaultConstraint(
    @tableName nvarchar(100),
    @field nvarchar(100),
    @value nvarchar(100),
    @constraintName nvarchar(100)
)
as
begin
    declare @sqlString nvarchar(max)

    set @sqlString =
            '
            if OBJECT_ID(''{constraintName}'', ''D'') is not null
                alter table {tableName}
                    drop constraint {constraintName}

            alter table {tableName}
                add constraint {constraintName}
                    default {value}
                    for {field}
            '

    set @sqlString = replace(@sqlString, '{tableName}', @tableName)
    set @sqlString = replace(@sqlString, '{field}', @field)
    set @sqlString = replace(@sqlString, '{value}', @value)
    set @sqlString = replace(@sqlString, '{constraintName}', @constraintName)

    exec (@sqlString)
end
go
