USE [u_kurowski]
GO
/****** Object:  Table [dbo].[IndywidualCustomer]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IndywidualCustomer](
	[CustomerID] [int] NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_IndywidualCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[IndywidualCustomer]  WITH CHECK ADD  CONSTRAINT [FK_IndywidualCustomer_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[IndywidualCustomer] CHECK CONSTRAINT [FK_IndywidualCustomer_Customer]
GO
ALTER TABLE [dbo].[IndywidualCustomer]  WITH CHECK ADD  CONSTRAINT [CK_IndywidualCustomer] CHECK  ((NOT [FirstName] like '%[0-9]%' AND NOT [LastName] like '%[0-9]%'))
GO
ALTER TABLE [dbo].[IndywidualCustomer] CHECK CONSTRAINT [CK_IndywidualCustomer]
GO
