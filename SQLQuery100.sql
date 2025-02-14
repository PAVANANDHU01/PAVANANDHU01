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

CREATE TABLE [dbo].[OrderDB] (
    [OId]           INT             IDENTITY (1, 1) NOT NULL,
    [customer_name] VARCHAR (50)    NULL,
    [Quantity]      INT             NULL,
    [date_of_order] VARCHAR (50)    NULL,
    [total_price]   DECIMAL (18, 2) NULL,
    [Fooditem]      INT             NOT NULL,
    [FoodName]      INT             NOT NULL,
    PRIMARY KEY CLUSTERED ([OId] ASC),
    CONSTRAINT [FK_OrderDB_FoodcatDB] FOREIGN KEY ([Fooditem]) REFERENCES [dbo].[FoodcatDB] ([Fooditem]),
    CONSTRAINT [FK_OrderDB_MenuDB] FOREIGN KEY ([FoodName]) REFERENCES [dbo].[MenuDB] ([Id])
);

CREATE TABLE [dbo].[RoleDB] (
    [Rid]  INT          NOT NULL,
    [Role] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Rid] ASC)
);

CREATE TABLE [dbo].[UserDB] (
    [Id]              INT          IDENTITY (1, 1) NOT NULL,
    [Username]        VARCHAR (50) NOT NULL,
    [Password]        VARCHAR (50) NOT NULL,
    [Confirmpassword] VARCHAR (50) NOT NULL,
    [Phoneno]         VARCHAR (50) NULL,
    [Email]           VARCHAR (50) NULL,
    [Rid]             INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UserDB_RoleDB] FOREIGN KEY ([Rid]) REFERENCES [dbo].[RoleDB] ([Rid])
);

