--Создание Базы Данных для Медицинского центра
create database MedCenterDB
on primary --Первичный файл
	(
		name = N'MedCenterDB', --Логическое имя файла БД
		filename = N'D:\.NET_FullStack\DataBaseTraining\DataBaseFile\MedCenterDB.mdf' --Имя и местоположение файла БД
	)
log on --Явно указываем файлы журналов
   (
        name = N'MedCenterDB_log', --Логическое имя файла журнала
        filename = N'D:\.NET_FullStack\DataBaseTraining\DataBaseFile\MedCenterDB_log.ldf' --Имя и местоположение файла журнала
   )
go
