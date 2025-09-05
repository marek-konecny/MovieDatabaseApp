IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MovieDatabaseDb')
BEGIN
  CREATE DATABASE [MovieDatabaseDb];
END;
GO

USE [MovieDatabaseDb];
GO

SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO


IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [RegistrationTime] datetime2 NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);

CREATE TABLE [Images] (
    [Id] int NOT NULL IDENTITY,
    [Url] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Images] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Actors] (
    [Id] int NOT NULL IDENTITY,
    [FullName] nvarchar(max) NOT NULL,
    [BirthDate] date NOT NULL,
    [PosterImageId] int NULL,
    CONSTRAINT [PK_Actors] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Actors_Images_PosterImageId] FOREIGN KEY ([PosterImageId]) REFERENCES [Images] ([Id])
);

CREATE TABLE [Movies] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NOT NULL,
    [ReleaseDate] date NULL,
    [PosterImageId] int NULL,
    CONSTRAINT [PK_Movies] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Movies_Images_PosterImageId] FOREIGN KEY ([PosterImageId]) REFERENCES [Images] ([Id])
);

CREATE TABLE [UserProfiles] (
    [UserId] nvarchar(450) NOT NULL,
    [ProfileImageId] int NULL,
    CONSTRAINT [PK_UserProfiles] PRIMARY KEY ([UserId]),
    CONSTRAINT [FK_UserProfiles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_UserProfiles_Images_ProfileImageId] FOREIGN KEY ([ProfileImageId]) REFERENCES [Images] ([Id])
);

CREATE TABLE [MovieActors] (
    [MovieId] int NOT NULL,
    [ActorId] int NOT NULL,
    CONSTRAINT [PK_MovieActors] PRIMARY KEY ([MovieId], [ActorId]),
    CONSTRAINT [FK_MovieActors_Actors_ActorId] FOREIGN KEY ([ActorId]) REFERENCES [Actors] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_MovieActors_Movies_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movies] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Ratings] (
    [UserId] nvarchar(450) NOT NULL,
    [MovieId] int NOT NULL,
    [Points] tinyint NOT NULL,
    [Text] nvarchar(max) NULL,
    [TimestampCreated] datetime2 NOT NULL,
    [TimestampEdited] datetime2 NULL,
    CONSTRAINT [PK_Ratings] PRIMARY KEY ([MovieId], [UserId]),
    CONSTRAINT [FK_Ratings_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Ratings_Movies_MovieId] FOREIGN KEY ([MovieId]) REFERENCES [Movies] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_Actors_PosterImageId] ON [Actors] ([PosterImageId]);

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;

CREATE INDEX [IX_MovieActors_ActorId] ON [MovieActors] ([ActorId]);

CREATE INDEX [IX_Movies_PosterImageId] ON [Movies] ([PosterImageId]);

CREATE INDEX [IX_Ratings_UserId] ON [Ratings] ([UserId]);

CREATE INDEX [IX_UserProfiles_ProfileImageId] ON [UserProfiles] ([ProfileImageId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250904175054_InitSchema', N'9.0.8');

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] ON;
INSERT INTO [AspNetRoles] ([Id], [ConcurrencyStamp], [Name], [NormalizedName])
VALUES (N'1', NULL, N'Admin', N'ADMIN'),
(N'2', NULL, N'User', N'USER');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'ConcurrencyStamp', N'Name', N'NormalizedName') AND [object_id] = OBJECT_ID(N'[AspNetRoles]'))
    SET IDENTITY_INSERT [AspNetRoles] OFF;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250904175115_InitUserRoles', N'9.0.8');

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Url') AND [object_id] = OBJECT_ID(N'[Images]'))
    SET IDENTITY_INSERT [Images] ON;
INSERT INTO [Images] ([Id], [Url])
VALUES (1, N'https://image.pmgstatic.com/cache/resized/w280/files/images/film/posters/000/049/49177_031300.jpg'),
(2, N'https://image.pmgstatic.com/cache/resized/w280/files/images/film/posters/159/533/159533397_612bbf.jpg'),
(3, N'https://image.pmgstatic.com/cache/resized/w200h264crop/files/images/creator/photos/164/419/164419363_52de27.jpg'),
(4, N'https://image.pmgstatic.com/cache/resized/w200h264crop/files/images/creator/photos/166/522/166522538_102f8e.jpg');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Url') AND [object_id] = OBJECT_ID(N'[Images]'))
    SET IDENTITY_INSERT [Images] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'BirthDate', N'FullName', N'PosterImageId') AND [object_id] = OBJECT_ID(N'[Actors]'))
    SET IDENTITY_INSERT [Actors] ON;
INSERT INTO [Actors] ([Id], [BirthDate], [FullName], [PosterImageId])
VALUES (1, '1965-04-04', N'Robert Downey Jr.', 3),
(2, '1981-06-13', N'Chris Evans', 4);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'BirthDate', N'FullName', N'PosterImageId') AND [object_id] = OBJECT_ID(N'[Actors]'))
    SET IDENTITY_INSERT [Actors] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'PosterImageId', N'ReleaseDate', N'Title') AND [object_id] = OBJECT_ID(N'[Movies]'))
    SET IDENTITY_INSERT [Movies] ON;
INSERT INTO [Movies] ([Id], [PosterImageId], [ReleaseDate], [Title])
VALUES (1, 1, '2008-05-02', N'Iron Man'),
(2, 2, '2011-07-22', N'Captain America: The First Avenger');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'PosterImageId', N'ReleaseDate', N'Title') AND [object_id] = OBJECT_ID(N'[Movies]'))
    SET IDENTITY_INSERT [Movies] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ActorId', N'MovieId') AND [object_id] = OBJECT_ID(N'[MovieActors]'))
    SET IDENTITY_INSERT [MovieActors] ON;
INSERT INTO [MovieActors] ([ActorId], [MovieId])
VALUES (1, 1),
(2, 2);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'ActorId', N'MovieId') AND [object_id] = OBJECT_ID(N'[MovieActors]'))
    SET IDENTITY_INSERT [MovieActors] OFF;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250904175126_InitTestData', N'9.0.8');

COMMIT;
GO


