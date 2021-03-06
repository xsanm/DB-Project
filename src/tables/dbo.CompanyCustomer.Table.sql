USE [u_kurowski]
GO
/****** Object:  Table [dbo].[CompanyCustomer]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyCustomer](
	[CustomerID] [int] NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[NIP] [varchar](50) NOT NULL,
	[Adress] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CompanyCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Unique_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [Unique_NIP] UNIQUE NONCLUSTERED 
(
	[NIP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyCustomer]  WITH CHECK ADD  CONSTRAINT [FK_CompanyCustomer_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[CompanyCustomer] CHECK CONSTRAINT [FK_CompanyCustomer_Customer]
GO
ALTER TABLE [dbo].[CompanyCustomer]  WITH CHECK ADD  CONSTRAINT [CK_Adress] CHECK  (([Adress] like '%[0-9][0-9]-[0-9][0-9][0-9]%'))
GO
ALTER TABLE [dbo].[CompanyCustomer] CHECK CONSTRAINT [CK_Adress]
GO
ALTER TABLE [dbo].[CompanyCustomer]  WITH CHECK ADD  CONSTRAINT [CK_Email] CHECK  (([Email] like '%@%.%'))
GO
ALTER TABLE [dbo].[CompanyCustomer] CHECK CONSTRAINT [CK_Email]
GO
ALTER TABLE [dbo].[CompanyCustomer]  WITH CHECK ADD  CONSTRAINT [NIP_10_Numbers] CHECK  (([NIP] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[CompanyCustomer] CHECK CONSTRAINT [NIP_10_Numbers]
GO
