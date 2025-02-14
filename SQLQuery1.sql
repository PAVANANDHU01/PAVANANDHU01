ALTER TABLE [dbo].[MenuDB]
ADD [ImageUrl] VARCHAR(255) NULL;

insert into MenuDb(ImageUrl) values ('~/Content/images/Chicken kababs.jpg'),('~/Content/images/Chicken kababs.jpg'),('~/Content/images/Chicken kababs.jpg'),('~/Content/images/Chicken kababs.jpg'),('~/Content/images/Chicken kababs.jpg'),('~/Content/images/Chicken kababs.jpg');

update MenuDB
set ImageUrl='~/Content/images/curd_rice.jpg'
where Items='Curd rice';

select * from Menudb;
delete from MenuDB;

 MenuDB;

Cabab chickens
Thanthuri chicken
Idli
Curd rice
chapathi
Chicken biriyani

