USE [Championship]
GO
/****** Object:  Table [dbo].[Match]    Script Date: 15.01.2020 22:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Match](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[time] [datetime] NOT NULL,
	[comment] [varchar](100) NULL,
 CONSTRAINT [PK_Match_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MatchParticipant]    Script Date: 15.01.2020 22:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchParticipant](
	[player] [int] NOT NULL,
	[matchID] [int] NOT NULL,
	[result] [float] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Players]    Script Date: 15.01.2020 22:59:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Players](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[profile] [varchar](50) NOT NULL,
	[alias] [varchar](50) NOT NULL,
	[pass] [varchar](50) NOT NULL,
	[rating] [int] NOT NULL,
 CONSTRAINT [PK_Players] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[MatchParticipant]  WITH NOCHECK ADD  CONSTRAINT [FK_MatchParticipant_Match] FOREIGN KEY([matchID])
REFERENCES [dbo].[Match] ([id])
GO
ALTER TABLE [dbo].[MatchParticipant] CHECK CONSTRAINT [FK_MatchParticipant_Match]
GO
ALTER TABLE [dbo].[MatchParticipant]  WITH CHECK ADD  CONSTRAINT [FK_MatchParticipant_Players1] FOREIGN KEY([player])
REFERENCES [dbo].[Players] ([id])
GO
ALTER TABLE [dbo].[MatchParticipant] CHECK CONSTRAINT [FK_MatchParticipant_Players1]
GO
