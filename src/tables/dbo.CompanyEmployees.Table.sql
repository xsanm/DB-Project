USE [u_kurowski]
GO
/****** Object:  Table [dbo].[CompanyEmployees]    Script Date: 27.02.2021 12:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyEmployees](
	[CompanyID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_CompanyEmployees] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC,
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompanyEmployees]  WITH CHECK ADD  CONSTRAINT [FK_CompanyEmployees_CompanyCustomer1] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[CompanyCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[CompanyEmployees] CHECK CONSTRAINT [FK_CompanyEmployees_CompanyCustomer1]
GO
ALTER TABLE [dbo].[CompanyEmployees]  WITH CHECK ADD  CONSTRAINT [FK_CompanyEmployees_IndywidualCustomer] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[IndywidualCustomer] ([CustomerID])
GO
ALTER TABLE [dbo].[CompanyEmployees] CHECK CONSTRAINT [FK_CompanyEmployees_IndywidualCustomer]
GO
