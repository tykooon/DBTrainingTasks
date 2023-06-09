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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_AddForeignKey', 'P') is not null
    drop procedure dbo.usp_AddForeignKey
go

create proc dbo.usp_AddForeignKey(
    @targetTableName nvarchar(100),
    @targetFields nvarchar(100),
    @parentTableName nvarchar(100),
    @parentFields nvarchar(100),
    @constraintName nvarchar(100)
)
as
begin
    declare @sqlString nvarchar(max)

    set @sqlString =
            '
            if OBJECT_ID(''{constraintName}'', ''F'') is not null
                alter table {targetTableName}
                    drop constraint {constraintName}

            alter table {targetTableName}
                add constraint {constraintName}
                    foreign key ({targetFields})
                    references {parentTableName} ({parentFields})
            '

    set @sqlString = replace(@sqlString, '{targetTableName}', @targetTableName)
    set @sqlString = replace(@sqlString, '{targetFields}', @targetFields)
    set @sqlString = replace(@sqlString, '{parentTableName}', @parentTableName)
    set @sqlString = replace(@sqlString, '{parentFields}', @parentFields)
    set @sqlString = replace(@sqlString, '{constraintName}', @constraintName)

    exec (@sqlString)
end
go
