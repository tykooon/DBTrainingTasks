use MedCenterDB
go

if OBJECT_ID('dbo.usp_AddAlternateKey', 'P') is not null
    drop procedure dbo.usp_AddAlternateKey
go

create proc dbo.usp_AddAlternateKey(
    @tableName nvarchar(100),
    @constraintName nvarchar(100),
    @fields nvarchar(100)
)
as
begin
    declare @sqlString nvarchar(max)

    set @sqlString =
            '
            if OBJECT_ID(''{constraintName}'', ''UQ'') is not null
                alter table {tableName}
                    drop constraint {constraintName}

            alter table {tableName}
                add constraint {constraintName}
                    unique ({fields})
            '

    set @sqlString = replace(@sqlString, '{tableName}', @tableName)
    set @sqlString = replace(@sqlString, '{fields}', @fields)
    set @sqlString = replace(@sqlString, '{constraintName}', @constraintName)

    exec (@sqlString)
end
go
