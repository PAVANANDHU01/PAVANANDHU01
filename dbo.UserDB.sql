CREATE TABLE [dbo].[UserDB] (
    [Id]              INT          NOT NULL,
    [Username]        VARCHAR (50) NOT NULL,
    [Password]        VARCHAR (50) NOT NULL,
    [Confirmpassword] VARCHAR (50) NULL,
    [Phoneno]         VARCHAR (50) NULL,
    [Email]           VARCHAR (50) NULL,
    [Rid]             INT    NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC), 
    CONSTRAINT [FK_UserDB_RoleDB] FOREIGN KEY ([Rid]) REFERENCES [RoleDB]([Rid])
);

