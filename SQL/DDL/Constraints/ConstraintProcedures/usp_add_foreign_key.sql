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
