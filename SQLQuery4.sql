--CREATE TABLE [dbo].[OrderDB]
--(
--	[Id] INT NOT NULL PRIMARY KEY,
--	customer_name varchar(50) ,
--	order_item varchar(50),
--	date_of_order date,
--	total_price decimal(18,2), 
--	Fooditem int ,
--	FoodId int,
--    CONSTRAINT [FK_OrderDB_FoodcatDB] FOREIGN KEY ([Fooditem]) REFERENCES [dbo].[FoodcatDB]([Fooditem]),
--	CONSTRAINT [FK_OrderDB_MenuDB] FOREIGN KEY ([FoodId]) REFERENCES [dbo].[MenuDB]([Id])
--);

CREATE TABLE [dbo].[FoodcatDB] (
    [Fooditem]  INT          NOT NULL,
    [Fooditems] VARCHAR (50) NULL,
    CONSTRAINT [PK_FoodcatDB] PRIMARY KEY CLUSTERED ([Fooditem] ASC)
);

CREATE TABLE [dbo].[MenuDB] (
    [Id]             INT             IDENTITY (1, 1) NOT NULL,
    [Items]          VARCHAR (50)    NULL,
    [Price_per_unit] DECIMAL (18, 2) NULL,
    [Total_price]    DECIMAL (18, 2) NULL,
    [Quantity]       INT             NULL,
    [Fooditem]       INT             NOT NULL,
    [ImageUrl]       VARCHAR (255)   NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_MenuDB_FoodcatDB] FOREIGN KEY ([Fooditem]) REFERENCES [dbo].[FoodcatDB] ([Fooditem])
);

CREATE TABLE [dbo].[OrderDB]
(
    [Id]             INT          NOT NULL PRIMARY KEY,
    [customer_name]  VARCHAR (50) NULL,
    [order_item]     VARCHAR (50) NULL,
    [date_of_order]  DATE         NULL,
    [total_price]    DECIMAL (18,2) NULL,
    [Fooditem]       INT          NULL,
    [FoodId]         INT          NULL,
    CONSTRAINT [FK_OrderDB_FoodcatDB] FOREIGN KEY ([Fooditem]) REFERENCES [dbo].[FoodcatDB] ([Fooditem]),
    CONSTRAINT [FK_OrderDB_MenuDB] FOREIGN KEY ([FoodId]) REFERENCES [dbo].[MenuDB] ([Id])
);
--CREATE TABLE [dbo].[FoodcatDB] (
--    [Fooditem]  INT          NOT NULL,
--    [Fooditems] VARCHAR (50) NULL,
--    CONSTRAINT [PK_FoodcatDB] PRIMARY KEY CLUSTERED ([Fooditem] ASC)
--);



--select * from OrderDB;

--select * from MenuDB;

--INSERT INTO [dbo].[OrderDB] (Id, customer_name, order_item, date_of_order, total_price)
--VALUES (1, 'John Doe', 'dosa', '2024-02-03', 15.99);

--insert into OrderDB(customer_name),

-- Create FoodcatDB table
CREATE TABLE [dbo].[FoodcatDB] (
    [Fooditem]  INT          NOT NULL,
    [Fooditems] VARCHAR (50) NULL,
    CONSTRAINT [PK_FoodcatDB] PRIMARY KEY CLUSTERED ([Fooditem] ASC)
);

-- Create OrderDB table
CREATE TABLE [dbo].[OrderDB]
(
    [Id]             INT          NOT NULL PRIMARY KEY,
    [customer_name]  VARCHAR (50) NULL,
    [order_item]     VARCHAR (50) NULL,
    [date_of_order]  DATE         NULL,
    [total_price]    DECIMAL (18,2) NULL,
    [Fooditem]       INT          NULL,
    [FoodId]         INT          NULL,
    CONSTRAINT [FK_OrderDB_FoodcatDB] FOREIGN KEY ([Fooditem]) REFERENCES [dbo].[FoodcatDB] ([Fooditem]),
    CONSTRAINT [FK_OrderDB_MenuDB] FOREIGN KEY ([FoodId]) REFERENCES [dbo].[MenuDB] ([Id])
);



-- Insert data into FoodcatDB
INSERT INTO [dbo].[FoodcatDB] ([Fooditem], [Fooditems])
VALUES
(1, 'Appetizer'),
(2, 'Main Course'),
(3, 'Dessert');

-- Insert data into MenuDB
INSERT INTO [dbo].[MenuDB] ([items], [price], [Fooditem])
VALUES
('Salad', 10.99, 1),
('Pasta', 19.99, 2),
('Cake', 8.99, 3);

-- Insert data into OrderDB
INSERT INTO [dbo].[OrderDB] ([Id], [customer_name], [order_item], [date_of_order], [total_price], [Fooditem], [FoodId])
VALUES
(1, 'John Doe', 'Pasta', '2024-02-03', 19.99, 0, 2),
(2, 'Jane Smith', 'Salad', '2024-02-03', 10.99, 0, 1);
