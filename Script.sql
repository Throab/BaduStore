USE [BaduStore]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[value] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[display_name] [nvarchar](255) NULL,
	[alias] [varchar](255) NOT NULL,
	[image] [nvarchar](max) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[name] [nvarchar](255) NULL,
	[display_name] [nvarchar](255) NULL,
	[alias] [varchar](255) NOT NULL,
	[image] [nvarchar](max) NULL,
	[is_active] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Images]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Images](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[url] [varchar](max) NULL,
	[is_thumb] [bit] NULL,
	[key] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](18, 2) NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[order_total] [decimal](18, 0) NOT NULL,
	[status] [varchar](50) NULL,
	[payment_method] [varchar](50) NULL,
	[address] [nvarchar](255) NULL,
	[phone_number] [varchar](50) NULL,
	[created_at] [datetime] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethods](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[method_name] [nvarchar](255) NULL,
	[display_name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductAttributes]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttributes](
	[product_id] [int] NOT NULL,
	[attribute_id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NULL,
	[brand_id] [int] NULL,
	[product_name] [nvarchar](255) NULL,
	[alias] [varchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 0) NULL,
	[is_active] [bit] NULL,
	[is_hot] [bit] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[product_id] [int] NULL,
	[rating_value] [int] NOT NULL,
	[comment] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](255) NULL,
	[phone_number] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[role] [nvarchar](255) NULL,
	[is_active] [bit] NULL,
	[full_name] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[date_of_birth] [datetime] NULL,
	[gender] [tinyint] NULL,
	[google_id] [varchar](255) NULL,
	[login_type] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wishlists]    Script Date: 8/4/2026 2:29:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlists](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[product_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Attributes] ON 
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (7, N'Bộ nhớ trong', N'16GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (8, N'RAM', N'8GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (9, N'RAM', N'16GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (10, N'RAM', N'32GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (11, N'Bộ nhớ trong', N'64GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (12, N'Bộ nhớ trong', N'128GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (13, N'Bộ nhớ trong', N'256GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (14, N'Bộ nhớ trong', N'512GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (15, N'Bộ nhớ trong', N'1TB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (16, N'Màu sắc', N'Titan Đen')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (17, N'Màu sắc', N'Titan Tự nhiên')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (18, N'Màu sắc', N'Titan Trắng')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (19, N'Màu sắc', N'Titan Sa Mạc')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (20, N'Kích thước màn hình', N'6.9 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (21, N'Công nghệ màn hình', N'Super Retina XDR OLED')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (22, N'Chipset', N'Apple A18 Pro')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (23, N'Hệ điều hành', N'IOS 18')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (24, N'Độ phân giải màn hình', N'2868 x 1320 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (25, N'Độ phân giải màn hình', N'2340 x 1080 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (26, N'Công nghệ màn hình', N'Dynamic AMOLED 2X')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (27, N'Kích thước màn hình', N'6.2 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (28, N'Chipset', N'Snapdragon 8 Elite dành cho Galaxy (3nm)')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (29, N'Pin', N'4000 mAh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (30, N'Kích thước màn hình', N'6.1 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (31, N'Chipset', N'Apple A18')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (32, N'Tính năng màn hình', N'Dynamic Island')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (33, N'Tính năng màn hình', N'Màn hình HDR')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (34, N'Tính năng màn hình', N'True Tone')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (35, N'Tính năng màn hình', N'Haptic Touch')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (36, N'Độ phân giải', N'2556 x 1179 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (37, N'Kích thước màn hình', N'7.6 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (38, N'Chipset', N'Apple A16')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (39, N'Hệ điều hành', N'IOS 17')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (40, N'Pin', N'3349 mAh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (41, N'Tần số quét', N'60 Hz')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (42, N'Tần số quét', N'120 Hz')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (43, N'Kích thước màn hình', N'6.3 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (44, N'Độ phân giải', N'2622 x 1206 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (45, N'Kích thước màn hình', N'6.7 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (46, N'Độ phân giải', N'2796 x 1290 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (47, N'Pin', N'4422 mAh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (48, N'Chipset', N'Apple A17 Pro')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (49, N'Độ phân giải', N'3120 x 1440 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (50, N'Pin', N'4900 mAh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (51, N'Công nghệ sạc', N'Sạc nhanh 45W')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (52, N'Cảm biến vân tay', N'Cảm biến vân tay trong màn hình')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (53, N'Pin', N'5000 mAh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (54, N'Độ phân giải', N'1080 x 2340 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (55, N'Chipset', N'Exynos 2400')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (56, N'Công nghệ sạc', N'Sạc nhanh 25W')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (57, N'Kích thước màn hình', N'6.8 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (58, N'Độ phân giải', N'1440 x 3120 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (59, N'Chipset', N'Snapdragon 8 Gen 3 For Galaxy')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (60, N'Loại card đồ họa', N'NVIDIA GeForce RTX 4050')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (61, N'CPU', N'Intel Core i5-13420H')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (62, N'Kích thước màn hình', N'15.6 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (63, N'Tần số quét', N'144 Hz')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (64, N'Ổ cứng', N'512 GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (65, N'Tấm nền', N'IPS')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (66, N'Chất liệu', N'Vỏ nhựa')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (67, N'Trọng lượng', N'2.1 kg')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (68, N'Pin', N'4 Cell, 57 Whr')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (69, N'Hệ điều hành', N'Windows 11')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (70, N'Độ phân giải', N'1920 x 1080 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (71, N'Độ phân giải', N'2880 x 1800 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (72, N'Pin', N'Pin Li-ion 3 cell 65 Wh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (73, N'Trọng lượng', N'1.26 kg')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (74, N'Tấm nền', N'OLED')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (75, N'Ổ cứng', N'1 TB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (76, N'Kích thước màn hình', N'14 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (77, N'CPU', N'Intel Core Ultra 7')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (78, N'Loại card đồ họa', N'Intel Arc Graphics')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (79, N'Tần số quét', N'90 Hz')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (80, N'Loại card đồ họa', N'NVIDIA GeForce RTX 3050')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (81, N'CPU', N'Intel Core i7-13620H')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (82, N'Kích thước màn hình', N'16 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (83, N'Độ phân giải', N'1920 x 1200 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (84, N'Trọng lượng', N'1.95 kg')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (85, N'Pin', N'Pin Li-ion 3 cell 53 Wh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (86, N'Tần số quét', N'165 Hz')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (87, N'CPU', N'Intel Core Ultra 5')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (88, N'Kích thước màn hình', N'13.4 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (89, N'Độ phân giải', N'2560 x 1600 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (90, N'Tấm nền', N'WVA')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (91, N'Chất liệu', N'Vỏ kim loại')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (92, N'Trọng lượng', N'1.18 kg')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (93, N'Pin', N'Pin Li-ion 3 cell 55 Wh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (94, N'Pin', N'Pin Li-ion 4 cell 54 Wh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (95, N'Trọng lượng', N'1.65 kg')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (96, N'Độ phân giải', N'2240 x 1400 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (97, N'CPU', N'Intel Core 5 120U')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (98, N'Loại card đồ họa', N'NVIDIA GeForce MX570A')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (99, N'Loại card đồ họa', N'Intel Iris Xe Graphics')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (100, N'CPU', N'Intel Core i7-1355U')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (101, N'Trọng lượng', N'1.5 kg')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (102, N'Pin', N'Pin Li-ion 4 cell 75 Wh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (103, N'Độ phân giải', N'3200 x 2000 pixels')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (104, N'CPU', N'Intel Core i5-12500H')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (105, N'Loại card đồ họa', N'NVIDIA GeForce RTX 5060')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (106, N'CPU', N'Intel Core 7 240H')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (107, N'CPU', N'Intel Core Ultra 9')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (108, N'CPU', N'Intel Core i5-13450HX')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (109, N'Pin', N'Pin Li-ion 4 cell 90 Wh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (110, N'Pin', N'Pin Li-ion 3 cell 41 Wh')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (111, N'CPU', N'Intel Core i7-1355U')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (112, N'Chất liệu', N'Vỏ carbon')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (114, N'CPU', N'Intel Core i5-1235U')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (115, N'CPU', N'Intel Core i7-12650H')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (116, N'CPU', N'Intel Core i7-13650HX')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (117, N'Trọng lượng', N'2.38 kg')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (118, N'RAM', N'24GB')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (119, N'Kích thước màn hình', N'15.1 inches')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (120, N'Loại card đồ họa', N'AMD Radeon 680M Graphics')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (121, N'CPU', N'AMD Ryzen 7 7735HS')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (122, N'CPU', N'Intel Core i5-13420H')
GO
INSERT [dbo].[Attributes] ([id], [name], [value]) VALUES (123, N'Loại card đồ họa', N'Intel UHD Graphics')
GO
SET IDENTITY_INSERT [dbo].[Attributes] OFF
GO
SET IDENTITY_INSERT [dbo].[Brands] ON 
GO
INSERT [dbo].[Brands] ([id], [name], [display_name], [alias], [image], [is_active]) VALUES (1, N'acer', N'Acer', N'acer', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618206/bgklkmtbrazlhezqoums.png', 1)
GO
INSERT [dbo].[Brands] ([id], [name], [display_name], [alias], [image], [is_active]) VALUES (2, N'apple', N'Apple', N'apple', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618223/gt1fiuigcvby5tj36jie.png', 1)
GO
INSERT [dbo].[Brands] ([id], [name], [display_name], [alias], [image], [is_active]) VALUES (3, N'samsung', N'Samsung', N'samsung', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618242/ogf5olkfnpuqdtrmm0x3.png', 1)
GO
INSERT [dbo].[Brands] ([id], [name], [display_name], [alias], [image], [is_active]) VALUES (4, N'dell', N'Dell', N'dell', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618258/ic4vzvppm3rponrrj4pa.png', 1)
GO
INSERT [dbo].[Brands] ([id], [name], [display_name], [alias], [image], [is_active]) VALUES (5, N'asus', N'Asus', N'asus', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618276/merprlcmhav6x47fckvk.png', 1)
GO
INSERT [dbo].[Brands] ([id], [name], [display_name], [alias], [image], [is_active]) VALUES (6, N'sony', N'Sony', N'sony', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618292/fizpjgme0jephkda9i8j.png', 1)
GO
INSERT [dbo].[Brands] ([id], [name], [display_name], [alias], [image], [is_active]) VALUES (7, N'lenovo', N'Lenovo', N'lenovo', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841189/ht3u84uea6wwupht7cqr.png', 1)
GO
SET IDENTITY_INSERT [dbo].[Brands] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([id], [parent_id], [name], [display_name], [alias], [image], [is_active]) VALUES (1, NULL, N'phone', N'Điện thoại', N'dien-thoai', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618013/jkuhlfrwgywkhqqqrnl8.png', 1)
GO
INSERT [dbo].[Categories] ([id], [parent_id], [name], [display_name], [alias], [image], [is_active]) VALUES (2, NULL, N'laptop', N'Laptop', N'laptop', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618041/hbqv8gqvlr3vgahlpxf3.png', 1)
GO
INSERT [dbo].[Categories] ([id], [parent_id], [name], [display_name], [alias], [image], [is_active]) VALUES (3, NULL, N'tablet', N'Máy tính bảng', N'may-tinh-bang', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618061/qncohuiiikrlr1zhvbiq.png', 1)
GO
INSERT [dbo].[Categories] ([id], [parent_id], [name], [display_name], [alias], [image], [is_active]) VALUES (4, NULL, N'smart_watch', N'Đồng hồ thông minh', N'dong-ho-thong-minh', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618101/gc4i0qgkg8lt2va5vws2.png', 1)
GO
INSERT [dbo].[Categories] ([id], [parent_id], [name], [display_name], [alias], [image], [is_active]) VALUES (5, NULL, N'camera', N'Máy ảnh', N'may-anh', N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749618118/idmip7xjb4x6ueoqwc2v.png', 1)
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Images] ON 
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1, 1, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749619622/md5lneg9waidduiqfc6z.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (2, 1, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749619624/lsebby9ui1zetg0mky9g.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (3, 1, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749619625/impxu1n6fijnge954s0j.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (4, 1, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749619626/akcknsrjqfrhwmqsqxgf.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (5, 2, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749620318/qogyllezducatnlfg0lr.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (6, 2, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749620320/ckr5heebl20gmupeavfz.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (7, 2, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749620321/hmuq4z7qdblljrcdu0cl.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (8, 2, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749620322/pnus6cterioedndizru4.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (13, 4, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749640433/jbuxzxac5s7ajzevvyyq.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (14, 4, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749640435/e1xjapd9mgyz59fzpxh4.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (15, 4, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749640437/fo6zyx4dicgjo43vhbaa.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (16, 4, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749640438/ti5s4pwfnpm5gauzdpjc.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (21, 7, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749652081/oaluversr5mjdag91khc.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (22, 7, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749652083/thyswmfc5xfhnuam9c4b.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (23, 7, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749652084/dbdyvctmqtexbkifdf4s.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (24, 7, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749652085/dwfeb10kywebplf9mqbf.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (25, 8, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749653566/fyhwowqstnglpn3tevnl.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (26, 8, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749653568/p3a55u608abr35g3763m.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (27, 8, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749653569/slnjnsbvf5qv1sx4ah0t.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (28, 8, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749653570/almgrklqjtg8ukul1sua.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (29, 8, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749653572/r4mvzjodvgpbxzcdw94e.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (30, 9, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749654343/wnz9qbqxuibzemifvnkx.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (31, 9, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749654344/me8vd6pt86yktxhydsio.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (32, 9, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749654346/tpedascrtv4ruvpl9oog.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (33, 9, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749654347/kvbzsh8qicm2wip4u1vh.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (34, 9, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749654348/decuhe22dg7gsthpbvzb.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (35, 10, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749655810/ytoqosaqekk7aisu5t6w.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (36, 10, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749655812/ehcebq5y715zo7nawbeu.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (37, 10, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749655814/t3x8eduiu2tmwffzmmxn.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (38, 10, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749655815/jkkxklzh93khnqlr413d.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (39, 10, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749655817/npcepron0mo2goypai6q.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (40, 10, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749655819/c6hhb4xjue7dhtvaze4e.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (41, 11, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749794901/wbqotgls9hiujrddoj7h.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (42, 11, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749794903/fh0yufl4omzyxszxdvaw.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (43, 11, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749794904/wfempogvvvjh28aiceif.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (44, 11, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749794905/epetw80porzhmyosi6cs.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (45, 11, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749794907/rd6qpnqanrklx4ila6dc.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (46, 12, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802299/bwhdv4nrdiirvktehzdb.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (47, 12, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802301/kg05sijran6qkcni9k8w.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (48, 12, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802302/mrua1fqxrmsky5ccmjhr.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (49, 12, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802304/uc0y19t6cpfnqhnqgnpl.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (50, 12, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802305/mu3plwfpq5qlsmjwhfhz.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (51, 13, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802751/kpstxooamr1gicmbcugm.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (52, 13, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802753/bbjyvoj31ftpetmbkgyx.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (53, 13, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802755/tqb1gki4mohdcwqjf5e3.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (54, 13, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802756/ufbeksigsj83n5qs1q4m.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (55, 13, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749802758/jdtj3cmdbploh6xqpmco.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (56, 14, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749814076/ynqbcsrayfwhnvzvmfpe.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (57, 14, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749814077/miwxgeioscuvieu6pdkb.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (58, 14, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749814079/f3xn14dr3gx3ixplcffy.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (59, 14, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749814080/as9pb5bjitqmb078wcqa.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (60, 14, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749814081/g4fj6mkljaygf4atkuyz.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (61, 14, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749814083/uyum8x8pg8m0whmufvrm.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (68, 17, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815119/ods27vxsfrf1atop4wy7.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (69, 17, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815120/grfqfsdt8ybf7zv1eqwb.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (70, 17, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815121/mwd94rdj0ohqqlhpojld.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (71, 17, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815124/stlpuoapgfsm6jyku8wm.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (72, 17, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815125/goj7d4ghx5lfkpxndzun.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (73, 18, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815915/oebxxhxmv2fuhs7ioh6u.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (74, 18, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815916/dxvm7rhtinqq5niqhtdf.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (75, 18, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815918/qhkmzwd0ols4tzoq9ouj.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (76, 18, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815919/eewnztjpkbhvvvpvgezd.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (77, 18, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815921/l0knvmoo4lfhwwpynbgy.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (78, 18, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749815923/rfv4xcxylflhpxmlnrjg.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (79, 19, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835062/h05hja8qpo0ryyyeiimb.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (80, 19, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835064/fxjspkqkscmqwruztvyq.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (81, 19, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835069/w50drxrfmiyhktuhtvn6.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (82, 19, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835079/mouottmmfmgei1e9wwgy.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (83, 19, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835083/fn4mkodhjj9j0jwltcvn.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (84, 19, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835085/vdzfvoyedqimwxauqxog.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (85, 20, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835697/rbpgn9prwg1pohl36fnt.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (86, 20, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835698/qcgdtgxov8noccfdzvoh.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (87, 20, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835700/owbsctcxjt1viahqdibj.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (88, 20, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749835701/kxpt69z6w9vuk1nwhrbx.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (89, 21, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836154/iy06hmtpda8r2xdipl0p.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (90, 21, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836156/or2qasqij5jiryjihebp.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (91, 21, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836159/kyylu6bmaw9rklnbne8q.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (92, 21, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836161/wsqdwl4b9l2wh2wpdaxu.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (93, 21, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836162/rlxnviux51bbpf4q4mzv.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (94, 22, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836712/nfuxtmoma9dytj275kyk.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (95, 22, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836714/zdlzjtikg2mmo8bo3nmu.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (96, 22, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836716/fbj9ra5rnqmydhn8to3m.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (97, 22, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836717/sucia5tfxldcn52kkth5.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (98, 22, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836718/byxha8gc1evmrzmmhsls.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (99, 22, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749836720/ekpgiyp6nexsajaf1wcb.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (100, 23, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837138/anxbimxzmm5tu0u5nuyy.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (101, 23, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837140/l4nndivgrzvb0k1iiihk.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (102, 23, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837141/gyrjqgkibp7ae2h0iyx9.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (103, 23, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837142/cdozhfbe3anflwjioc1a.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (104, 23, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837144/za2pxoaqvr9bfqbjtgb6.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (105, 23, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837145/mcdoafdilyjfbux8hegm.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (106, 24, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837676/hkro3iyb4jsktzg7pnm6.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (107, 24, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837678/kchu6bsj8qgpd2j2kydw.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (108, 24, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837679/sywwqvmh6fvo2gczplvv.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (109, 24, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837680/x817yp3nfbysix8n4s7k.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (110, 24, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749837682/bl5ibcv4jvc6598lu5fi.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (115, 26, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749838413/ldhldyyhoxjj51b86guc.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (116, 26, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749838414/vkdym7y5tkko53cosp8p.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (117, 26, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749838416/yj3ljnyxf4miuvf4sql5.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (118, 26, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749838418/xtj1c4gyqnhze2xrpku6.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (119, 26, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749838419/ioq1br6akjturngfzmmu.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (120, 26, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749838421/adqgchc3fjatoscnvpgj.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (121, 26, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749838423/gbts6oz2spixlflgfieb.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (122, 27, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839144/duzhwhqc0q2lwx7jvfts.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (123, 27, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839147/nxpba7yohxbsxrxk8req.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (124, 27, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839148/lzniyem67trxmipqzlw7.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (125, 27, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839149/jtdljfrknxjiq8leik3u.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (126, 27, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839152/psoqf2rmpgjbhd1qrjt8.png', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (127, 27, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839153/egjfv3ngbgmly3mcrg66.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (128, 28, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839735/xibboutjjjz7fsrnoe75.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (129, 28, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839737/v4cop5uq9y3g4nioriep.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (130, 28, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839738/ooyrfdcwa4qiykv2enum.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (131, 28, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839740/qozaubngn9bmnjqjgvtw.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (132, 28, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749839741/ebjxh3ovas3fvxenjgph.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (133, 29, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840228/vopter4yc1bxoth7rh8g.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (134, 29, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840229/ip3jnhxunxqr8wbqlo0e.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (135, 29, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840230/fjdxr1d6zlf7ax3jh8si.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (136, 29, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840232/bq0yfnniz84kyy1jlphb.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (137, 29, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840233/laiiq7dtvnwtkfxrue1v.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (138, 30, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840570/unyydpny1web8xxsswvx.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (139, 30, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840571/bxb4fvsp9zogojowdenu.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (140, 30, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840572/gf1af4rz8oktzpd3lvda.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (141, 30, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840574/pslyhcg4fuuwdilsvrce.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (142, 30, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749840575/b6dnimtw5chckkzkn64p.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (143, 31, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841002/zrstgzkda25sa5255til.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (144, 31, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841004/qwxirrxcoezp4z5dsyb0.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (145, 31, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841006/m1qp1fs5zihyuv4h2kva.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (146, 31, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841009/efrbwthycusulrwbipdj.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (147, 31, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841010/wevy4qzdxzxnkrohfgmn.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (148, 34, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841625/slcm6h725bipmnrxqral.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (149, 34, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841627/f5cfo8rbdqvdd6e08wzs.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (150, 34, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841628/nerul0y2coqsuiro1krg.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (151, 34, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841630/klxuhmq9folvco3mznvj.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (152, 34, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749841632/ungizcnbzvgznyenzvta.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (153, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842251/qbcvzt5cwp2fshuzf71o.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (154, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842253/pgz0gogleuoojdnbjfj9.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (155, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842258/jcrl9sdxbhorydkpqfw7.png', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (156, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842260/vxbffdrp2nccbqqfvz9i.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (157, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842262/tgwqszupx0s6u8ildjvc.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (158, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842263/mwh0z4hkxckmoiovtjfi.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (159, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842266/rq2c3jvau04f9fyyprdx.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (160, 35, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842268/cwhqshccgfuuyov1kvkp.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (161, 36, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842745/opfnffexhhkfwmmuecwc.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (162, 36, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842747/sexogwhyckrxhicibw2y.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (163, 36, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842749/xsccwnfierhfsfflhyys.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (164, 36, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842750/flt4vkqqmsuxzkhxde4k.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (165, 36, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749842752/uig5anpzz88h2sodyawi.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (166, 37, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843178/vo8athpey25pj5vma7eo.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (167, 37, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843180/yojpca578vx6g8tmvtla.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (168, 37, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843182/fmqq4b6neei4bswtxcsb.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (169, 37, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843183/j9fg3apldh5nptnplvll.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (170, 37, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843185/lyfxsiixjqqrxykx9ihk.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (171, 38, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843457/svs4vo9s4uxzfm9okgh2.webp', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (172, 38, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843458/pghemumokdluu6ybpw5s.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (173, 38, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843460/i6ygymml2r2iug1kdx4i.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (174, 38, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843461/wya9pb7xbcfl4qf0cqsy.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (175, 38, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1749843462/xfrkg9qiuzljfy3lve4a.webp', 0, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1001, 1003, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785426938/products/agoo2dx9thggp6bkmllg.png', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1002, 1004, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785427451/products/jogqliuzb9z4iybzhxky.png', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1003, 1005, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785429219/products/pgenfpdlokkukytc93zk.jpg', 1, NULL)
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1004, 1006, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785429987/products/wrd8glqnesu5pee3pv7x.jpg', 1, N'products/wrd8glqnesu5pee3pv7x')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1005, 1007, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785430300/products/naq5w35ib1rcd23umhaa.png', 1, N'products/naq5w35ib1rcd23umhaa')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1006, NULL, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785431315/products/kjrpikcsu1v7dc40q694.jpg', 1, N'products/kjrpikcsu1v7dc40q694')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1007, NULL, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785431318/products/pv6ebuvobgyjaw8a8w4s.jpg', 0, N'products/pv6ebuvobgyjaw8a8w4s')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1008, NULL, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785431331/products/oapvnohq3x7dyu15npp5.jpg', 0, N'products/oapvnohq3x7dyu15npp5')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1009, 1009, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785431777/products/muc1ykk60vkwxmwcw9h3.png', 1, N'products/muc1ykk60vkwxmwcw9h3')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1010, 1009, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785431800/products/n1dihpile4e83npwcbkd.png', 0, N'products/n1dihpile4e83npwcbkd')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1011, 1009, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785431821/products/abjvitblisqlaanfpgy3.png', 0, N'products/abjvitblisqlaanfpgy3')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1012, 1010, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785511114/products/sd5eose9fzhtsillcjtm.jpg', 1, N'products/sd5eose9fzhtsillcjtm')
GO
INSERT [dbo].[Images] ([id], [product_id], [url], [is_thumb], [key]) VALUES (1013, 1010, N'https://res.cloudinary.com/dale7wvyi/image/upload/v1785511116/products/zadbknps1kseu8noopof.jpg', 0, N'products/zadbknps1kseu8noopof')
GO
SET IDENTITY_INSERT [dbo].[Images] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItems] ON 
GO
INSERT [dbo].[OrderItems] ([id], [order_id], [product_id], [quantity], [price], [total]) VALUES (1, 2, 37, 1, CAST(20490000.00 AS Decimal(18, 2)), CAST(20490000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[OrderItems] ([id], [order_id], [product_id], [quantity], [price], [total]) VALUES (2, 3, 1010, 1, CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[OrderItems] ([id], [order_id], [product_id], [quantity], [price], [total]) VALUES (3, 4, 35, 1, CAST(24990000.00 AS Decimal(18, 2)), CAST(24990000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[OrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([id], [user_id], [order_total], [status], [payment_method], [address], [phone_number], [created_at]) VALUES (2, 0, CAST(20490000 AS Decimal(18, 0)), N'Pending', N'COD', N'11 Bàu Bàng', N'141241', CAST(N'2026-08-04T01:54:40.020' AS DateTime))
GO
INSERT [dbo].[Orders] ([id], [user_id], [order_total], [status], [payment_method], [address], [phone_number], [created_at]) VALUES (3, 3004, CAST(10000 AS Decimal(18, 0)), N'Pending', N'COD', N'11 Bàu Bàng', N'141241', CAST(N'2026-08-04T01:56:46.360' AS DateTime))
GO
INSERT [dbo].[Orders] ([id], [user_id], [order_total], [status], [payment_method], [address], [phone_number], [created_at]) VALUES (4, 3004, CAST(24990000 AS Decimal(18, 0)), N'Pending', N'COD', N'11 Bàu Bàng', N'141241', CAST(N'2026-08-04T03:25:02.173' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentMethods] ON 
GO
INSERT [dbo].[PaymentMethods] ([id], [method_name], [display_name]) VALUES (1, N'COD', N'Thanh toán khi nhận hàng')
GO
INSERT [dbo].[PaymentMethods] ([id], [method_name], [display_name]) VALUES (2, N'VNPAY', N'VNPay')
GO
INSERT [dbo].[PaymentMethods] ([id], [method_name], [display_name]) VALUES (3, N'MOMO', N'Ví MoMo')
GO
INSERT [dbo].[PaymentMethods] ([id], [method_name], [display_name]) VALUES (4, N'PAYPAL', N'PayPal')
GO
SET IDENTITY_INSERT [dbo].[PaymentMethods] OFF
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 20)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 22)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 23)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 24)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 25)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 27)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 28)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 29)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 23)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 30)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 31)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 36)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 30)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 38)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 39)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 40)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 22)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 23)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 43)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 44)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 39)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 45)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 46)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 47)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 48)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 28)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 45)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 49)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 50)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 51)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 20)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 28)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 49)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 51)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 53)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 27)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 29)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 54)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 55)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 56)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 51)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 53)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 57)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 58)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 59)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 60)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 61)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 67)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 68)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 71)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 73)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 77)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 79)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 80)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 81)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 85)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 86)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 87)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 88)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 89)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 90)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 92)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 93)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 94)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 96)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 97)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 98)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 90)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 94)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 99)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 100)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 77)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 102)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 103)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 67)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 68)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 80)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 104)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 105)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 106)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 71)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 73)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 102)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 107)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 60)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 67)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 86)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 108)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 109)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 99)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 110)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 111)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 112)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 99)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 110)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 114)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 71)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 73)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 77)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 80)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 93)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 115)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 87)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 60)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 116)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 117)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 118)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 86)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 89)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 119)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 120)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 121)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 110)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 122)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 123)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 102)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 122)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 123)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 22)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 23)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (1, 24)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 25)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 27)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 28)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (2, 29)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 23)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 30)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 31)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (4, 36)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 30)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 38)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 39)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (7, 40)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 22)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 23)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 43)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (8, 44)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 21)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 32)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 33)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 34)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 35)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 39)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 45)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 46)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 47)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (9, 48)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 28)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 45)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 49)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 50)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 51)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (10, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 20)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 28)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 49)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 51)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (11, 53)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 27)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 29)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 54)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 55)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (12, 56)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 26)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 51)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 52)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 53)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 57)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 58)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (13, 59)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 60)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 61)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 67)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 68)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (14, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 71)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 73)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 77)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (17, 79)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 80)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 81)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 85)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (18, 86)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 87)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 88)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 89)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 90)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 92)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (19, 93)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 94)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 96)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 97)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (20, 98)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 90)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 94)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 99)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (21, 100)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 77)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 102)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (22, 103)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 67)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 68)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 80)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (23, 104)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 105)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (24, 106)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 71)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 73)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 102)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (26, 107)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 60)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 67)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 86)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 108)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (27, 109)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 99)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 110)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 111)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (28, 112)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 99)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 110)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (29, 114)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 42)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 71)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 73)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 77)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (30, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 80)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 84)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 93)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (31, 115)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 75)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 78)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 87)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (34, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 60)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 62)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 63)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 70)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 116)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 117)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (35, 118)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 10)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 72)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 74)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 86)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 89)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 91)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 119)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 120)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (36, 121)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 76)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 101)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 110)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 122)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (37, 123)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 9)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 41)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 64)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 65)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 66)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 69)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 82)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 83)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 95)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 102)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 122)
GO
INSERT [dbo].[ProductAttributes] ([product_id], [attribute_id]) VALUES (38, 123)
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1, 1, 2, N'iPhone 16 Pro Max', N'iphone-16-pro-max-1', N'iPhone 16 series với 4 phiên bản: iPhone 16, iPhone 16 Plus, iPhone 16 Pro và iPhone 16 Pro Max đều có sự nâng cấp đáng kể, trong đó đáng chú ý là nút điều khiển camera mới, hệ thống camera tiên tiến, hiệu suất và thời lượng pin vượt trội. Trong đó iPhone 16 là dòng tiêu chuẩn với thiết kế trẻ trung và thời thượng cùng cấu hình mượt mà, giá bán phải chăng nhất. iPhone 16 Plus sở hữu ngoài màn hình lớn và thời lượng sử dụng pin dài hơn bản iPhone 16 thường. Trong đó, đánh dấu bước nhảy vọt về thời lượng pin và sở hữu chip A18 Pro xuất sắc, iPhone 16 Pro Max là siêu phẩm đem lại trải nghiệm vượt trội trên mọi khía cạnh. Sản phẩm gây ấn tượng với viền màn hình siêu mỏng, được trang bị nút Điều Khiển Camera mới và có bộ tính năng Apple Intelligence cực kỳ tiện dụng. 

', 100, CAST(30590000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-11T12:26:56.317' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (2, 1, 3, N'Samsung Galaxy S25 5G', N'samsung-galaxy-s25-5g-2', N'Samsung Galaxy S25 là siêu phẩm cao cấp với thiết kế nhỏ gọn và hiệu năng vượt trội bởi Snapdragon 8 Elite for Galaxy tiến trình 3nm đầu tiên. Kết hợp đó là sức mạnh AI tiên tiến, giúp người dùng có những trải nghiệm công nghệ hiện đại và tiện lợi hơn.', 100, CAST(19690000 AS Decimal(18, 0)), 1, 0, CAST(N'2025-06-11T12:38:31.783' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (4, 1, 2, N'iPhone 16', N'iphone-16-4', N'iPhone 16 bản thường 128GB sở hữu thiết kế khung nhôm, mặt lưng kính pha màu cùng với 5 màu sắc bắt mắt để lựa chọn. Máy với trọng lượng 170g cùng kích thước màn hình 6.1 inch Super Retina XDR, dải màu P3. Với cấu hình từ chip A18 Bionic mới, điện thoại iPhone mới này mang lại hiệu năng ổn định, đáp ứng nhiều nhu cầu dùng.', 100, CAST(18790000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-11T18:13:46.227' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (7, 1, 2, N'iPhone 15', N'iphone-15-7', N'iPhone 15 128GB được trang bị màn hình Dynamic Island kích thước 6.1 inch với công nghệ hiển thị Super Retina XDR màn lại trải nghiệm hình ảnh vượt trội. Điện thoại với mặt lưng kính nhám chống bám mồ hôi cùng 5 phiên bản màu sắc lựa chọn: Hồng, Vàng, Xanh lá, Xanh dương và đen. Camera trên iPhone 15 series cũng được nâng cấp lên cảm biến 48MP cùng tính năng chụp zoom quang học tới 2x. Cùng với thiết kế cổng sạc thay đổi từ lightning sang USB-C vô cùng ấn tượng.', 100, CAST(15990000 AS Decimal(18, 0)), 1, 0, CAST(N'2025-06-11T21:27:59.867' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (8, 1, 2, N'iPhone 16 Pro', N'iphone-16-pro-8', N'Điện thoại iPhone 16 Pro phiên bản 512GB sở hữu không gian lưu trữ lớn giúp người dùng có thể thoải mái lưu trữ hình ảnh và video chất lượng cao. Kết hợp với đó là phần cứng từ con chip A18 Pro mạnh mẽ cùng với màn hình 6,3 inch chuẩn Retina hiển thị rõ nét.

Máy iP 16 Pro 512GB cũng được trang bị cụm camera với độ phân giải cao cùng khả năng chụp Zoom chất lượng. Nhờ đó quá trình quay chụp diến ra dễ dàng với chất lượng hình ảnh, video rõ nét. Bên cạnh đó, thời lượng pin của chiếc iP16 mới này cũng được cải thiện đáng kể so với thế hệ trước.', 100, CAST(34690000 AS Decimal(18, 0)), 1, 0, CAST(N'2025-06-11T21:52:45.190' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (9, 1, 2, N'iPhone 15 Pro Max', N'iphone-15-pro-max-9', N'iPhone 15 Pro Max sở hữu màn hình Super Retina XDR OLED 6.7 inch tần số quét cao 120Hz sắc nét và mượt mà. Với chipset A17 Pro sản xuất trên tiến trình 3nm, thế hệ iPhone 15 bản Pro Max đảm bảo hiệu năng mạnh mẽ và khả năng tiết kiệm pin tối ưu. Đặc biệt, máy còn sở hữu camera chính 48MP cùng khả năng zoom quang học 5x, giúp iP 15 Pro Max trở thành lựa chọn tuyệt vời cho người đam mê nhiếp ảnh và quay phim chuyên nghiệp.', 100, CAST(27990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-11T22:05:42.313' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (10, 1, 3, N'Samsung Galaxy S25 Plus', N'samsung-galaxy-s25-plus-10', N'Samsung S25 Plus được đánh giá cao về mặt hiệu năng nhờ sở hữu chip Snapdragon 8 Elite mạnh mẽ, mang lại khả năng xử lý vượt trội. Màn hình hiển thị Dynamic AMOLED của máy lớn 6.7 inch với độ phân giải QHD+, đảm bảo trải nghiệm hình ảnh sắc nét và sống động. Kèm theo đó là bộ nhớ RAM 12GB cùng tùy chọn lưu trữ 256GB giúp người dùng thoải mái lưu trữ dữ liệu và chạy nhiều ứng dụng mượt mà.', 100, CAST(23190000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-11T22:30:08.080' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (11, 1, 3, N'Samsung Galaxy S25 Ultra', N'samsung-galaxy-s25-ultra-11', N'Samsung Galaxy S25 Ultra là chiếc điện thoại cao cấp nhất của nhà Samsung với những tính năng tiên phong dẫn đầu. Smartphone sở hữu thiết kế sang trọng, bền bỉ bởi khung Titan đẳng cấp kết hợp đó là trọn bộ công cụ AI thế hệ mới và Snapdragon 8 Elite for Galaxy mạnh mẽ, đảm bảo hiệu suất vượt trội, khả năng xử lý thông minh và trải nghiệm người dùng đỉnh cao.', 100, CAST(28490000 AS Decimal(18, 0)), 1, 0, CAST(N'2025-06-13T13:08:04.593' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (12, 1, 3, N'Samsung Galaxy S24', N'samsung-galaxy-s24-12', N'Samsung Galaxy S24 mở ra kỷ nguyên AI thông minh cao cấp, giúp bạn khai phá tiềm năng sáng tạo toàn diện chỉ với chiếc điện thoại S24 nhỏ gọn trên tay.', 100, CAST(20190000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-13T15:11:38.053' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (13, 1, 3, N'Samsung Galaxy S24 Ultra', N'samsung-galaxy-s24-ultra-13', N'Samsung S24 Ultra sở hữu AI thông minh, hiệu năng cực đỉnh cũng đa tính năng cao cấp nhất. Đi kèm với đó là những cải tiến tích cực vượt trội hơn về camera, vi xử lý, và tích hợp AI toàn diện, đây là sản phẩm không thể bỏ qua cho người yêu công nghệ. Cùng xem giá bán và đánh giá chi tiết nhất dòng điện thoại này xem có nên mua không ngay nhé!', 100, CAST(23990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-13T15:19:10.320' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (14, 2, 1, N'Laptop Gaming Acer Nitro V', N'laptop-gaming-acer-nitro-v-14', N'Laptop Gaming Acer Nitro V ANV15-51-57B2 mạnh mẽ ấn tượng với CPU Intel® Core™ i5 thế hệ 13 kết hợp cùng với card đồ họa NVIDIA® GeForce RTX™ 40 Series. Bên cạnh đó, màn hình 15.6" FHD IPS 144Hz chất lượng chuẩn gaming và tản nhiệt mát lạnh. Đặc biệt, khả năng kết nối đa dạng, siêu tốc độ ấn tượng,... Tất cả sẽ giúp bạn có trải nghiệm mạnh mẽ, ấn tượng bất chấp mọi công việc.', 100, CAST(23390000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-13T18:27:54.583' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (17, 2, 1, N'Laptop Acer Swift 14 AI', N'laptop-acer-swift-14-ai-17', N'Laptop Acer Swift 14 AI SF14-51-75VP tích hợp con chip Intel Core U7-258V cùng thanh RAM 32GB và ổ cứng SSD PCIe dung lượng đến 1TB. Màn hình của laptop trang bị kích thước 14 inch, tấm nền OLED 3K. Ngoài ra, viên pin bên trong mẫu laptop Acer AI này còn có dung lượng 65Wh và cạnh bên có các cổng HDMI 2.1, USB-C, USB-A và jack 3.5mm. ', 100, CAST(38490000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-13T18:45:17.993' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (18, 2, 1, N'Laptop Acer Gaming Nitro Lite 16', N'laptop-acer-gaming-nitro-lite-16-18', N'Laptop Acer Gaming Nitro Lite 16 NL16-71G-71UJ sở hữu CPU Intel Core i7-13620H mạnh mẽ, hỗ trợ xử lý nhanh mọi tác vụ từ chơi game đến thiết kế đồ họa. RAM DDR5 tốc độ cao nâng khả năng đa nhiệm, giúp khách hàng chuyển đổi mượt mà giữa các ứng dụng. Mẫu laptop Acer Nitro này còn được tích hợp VGA RTX 3050 để mang đến chất lượng hình ảnh sống động, sắc nét.', 100, CAST(23490000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-13T18:58:34.393' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (19, 2, 4, N'Laptop Dell XPS 13 9350', N'laptop-dell-xps-13-9350-19', N'Laptop Dell XPS 13 9350 71058714 là có thiết kế mỏng nhẹ, tinh tế, sở hữu màn hình cảm ứng 13.4 inch QHD+ 120Hz cùng vi xử lý Intel Core Ultra 5 226V. Máy có 16GB RAM cùng ổ cứng SSD 1TB, mang lại khả năng đa nhiệm mượt mà. Pin 55Wh và các tính năng bảo mật như vân tay, nhận diện khuôn mặt giúp đáp ứng tốt nhu cầu sử dụng.', 100, CAST(54990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T00:17:39.110' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (20, 2, 4, N'Laptop Dell Inspiron 14 5440', N'laptop-dell-inspiron-14-5440-20', N'Laptop Dell Inspiron 14 5440 N5440-C5U165W11IBD2 giúp nâng cấp hiệu năng xử lý với CPU Intel Core 5 120U, 10 nhân 12 luồng cùng tốc độ lên tới 5.0GHz. Kèm theo đó là 16GB RAM DDR5 và ổ cứng SSD 512GB tốc độ cao giúp mẫu laptop Dell này có thể đa nhiệm hiệu quả và khởi động nhanh chóng. Đặc biệt, mẫu laptop Dell Inspiron này còn sở hữu màn hình 14 inch độ phân giải 2.2K cho chất lượng hình ảnh sắc nét, hỗ trợ tối ưu cho công việc và giải trí.', 100, CAST(23990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T00:28:15.557' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (21, 2, 4, N'Laptop Dell Inspiron 15 3530', N'laptop-dell-inspiron-15-3530-21', N'Laptop Dell Inspiron 15 3530 P16WD siêu mỏng nhẹ với ngoại hình màu bạc tối giản cùng trọng lượng 1.716kg và được hoàn thiện siêu bền với chất liệu cao cấp. Máy có RAM 16GB, được trang bị ổ cứng SSD 1TB lưu trữ khổng lồ, truy cập nhanh chóng. Laptop sở hữu CPU từ nhà Intel, con chip thế hệ 13 Core i7-1355U đi kèm đồ họa tích hợp GPU Intel Xe Graphics xử lý mạnh mẽ từ hiệu năng đến đồ họa. Ngoài ra laptop cũng có nhiều cổng giao tiếp, màn hình 15.6 FHD sắc nét. ', 100, CAST(22490000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T00:35:53.040' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (22, 2, 5, N'Laptop ASUS VivoBook S 16 OLED', N'laptop-asus-vivobook-s-16-oled-22', N'Laptop Asus Vivobook S 16 OLED S5606MA-MX051W cung cấp hiệu suất mạnh mẽ với con chip Intel Core Ultra 7 155H, cùng card đồ họa Intel Arc Graphics. Tận hưởng trải nghiệm choáng ngợp với màn hình 16 inch 3.2K 120Hz. Bên cạnh đó, sản phẩm laptop Aus Vivobook có thiết kế mỏng nhẹ kết hợp bàn phím tích hợp đèn nền tối ưu hiệu suất làm việc. ', 100, CAST(22990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T00:45:11.260' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (23, 2, 5, N'Laptop ASUS TUF Gaming F15', N'laptop-asus-tuf-gaming-f15-23', N'Laptop Asus TUF Gaming F15 FX507ZC4-HN095W có ổ cứng SSD 512GB, với dung lượng RAM 16GB, giúp mang đến tốc độ truy cập thông tin ổn định và mượt mà hơn. Máy có màu sắc hiện đại, kích thước chỉ 35.4 x 25.1 x 2.24 ~ 2.49 cm không lo cồng kềnh khi mang theo. Bên cạnh đó, card đồ họa NVIDIA® GeForce RTX™ 3050, giúp nâng cao đồ họa sắc nét khi sử dụng. Bộ xử lý Intel® Core™ i5-12500H thế hệ 12, đáp ứng nhu cầu khác nhau của người dùng.', 100, CAST(19390000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T00:52:17.130' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (24, 2, 5, N'Laptop ASUS Gaming V16', N'laptop-asus-gaming-v16-24', N'Laptop Asus Gaming V16 V3607VM-RP044W nổi bật với CPU Intel Core 7-240H và GPU NVIDIA® GeForce RTX™ 5060 giúp xử lý các tác vụ nặng một cách hiệu quả. Thiết bị sử dụng màn hình WUXGA 16 inch với tần số 144Hz mang đến trải nghiệm thị giác cực mượt. Ngoài ra, máy có trọng lượng chỉ 1.95kg, phù hợp cho người dùng cần di chuyển thường xuyên.', 100, CAST(34990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T01:01:14.633' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (26, 2, 5, N'Laptop ASUS Zenbook 14', N'laptop-asus-zenbook-14-26', N'Laptop ASUS Zenbook 14 UX3405CA-PZ204WS sở hữu vi xử lý Intel Core Ultra 9 285H mạnh mẽ, RAM 32GB và SSD 1TB đảm bảo hiệu suất mạnh mẽ, vượt trội. Máy trang bị màn hình OLED 14 inch 3K, tần số quét 120Hz, hỗ trợ cảm ứng với bút stylus. Với trọng lượng chỉ 1.28 kg, pin 75Wh và Wi-Fi 7, đây là lựa chọn lý tưởng cho công việc di động.', 100, CAST(34490000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T01:13:31.653' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (27, 2, 5, N'Laptop ASUS ROG Strix G16', N'laptop-asus-rog-strix-g16-27', N'Laptop Asus ROG Strix G16 G614JU N3480W mang đến tiềm năng vượt trội khi được trang bị chip Intel Core i5-13450HX cùng VGA NVIDIA GeForce RTX 4050. Mẫu laptop Asus ROG Strix này còn sở hữu 16GB + 16GB RAM, mở rộng tối đa 32GB, ổ cứng SSD 512GB nhằm hỗ trợ hoạt động đa nhiệm cường độ cao. Kèm theo đó là không gian hiển thị lớn, sắc nét với màn hình ROG Nebula 16 inch.', 100, CAST(29990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T01:25:41.693' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (28, 2, 4, N'Laptop Dell Vostro 3530', N'laptop-dell-vostro-3530-28', N'Laptop Dell Vostro 3530 2H1TPI7 sở hữu cấu hình mạnh mẽ với Intel Core i7 thế hệ 13 cùng RAM 16GB DDR4, mang lại hiệu năng ấn tượng và khả năng đa nhiệm tốt. Máy được trang bị màn hình 15.6 inch Full HD LCD với tần số quét 120Hz, cho hình ảnh sắc nét và chuyển động mượt mà. Bên cạnh đó, lớp chống chói cũng giúp thế hệ laptop Dell Vostro này có thể làm việc dễ dàng trong mọi điều kiện ánh sáng. Máy có thiết kế vỏ carbon bền bỉ, trọng lượng nhẹ 1.66 kg và đầy đủ các cổng kết nối.', 100, CAST(18190000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T01:35:34.020' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (29, 2, 4, N'Laptop Dell Latitude 3540', N'laptop-dell-latitude-3540-29', N'Laptop Dell Latitude 3540 71038100 mang hiệu suất đỉnh cao từ vi xử lý i5-1235U Intel Core, kết hợp dung lượng 16GB RAM cùng ổ cứng chuẩn PCIe 512GB. Không những vậy, mẫu laptop Dell này còn sở hữu màn hình Full HD 15.6 inch với tốc độ quét 60Hz. Ngoài ra, thiết kế gọn gàng, hiện đại cũng phù hợp với môi trường, nhu cầu văn phòng chuyên nghiệp của người dùng.', 100, CAST(16990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T01:43:46.643' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (30, 2, 1, N'Laptop Acer Swift Go 14 AI', N'laptop-acer-swift-go-14-ai-30', N'Laptop Acer Swift Go 14 AI SFG14-73-71ZX được trang bị bộ vi xử lý Intel Core Ultra 7-155H đi kèm RAM 16GB và ổ cứng SSD 512GB xử lý tốt mọi tác vụ. Trải nghiệm màn hình IPS 2.8K với tần số làm mới 120Hz cực sắc nét. Đặc biệt, laptop tích hợp công nghệ AI với Acer AI Zone, giúp tăng cường hiệu suất và thao tác nhanh chóng. ', 100, CAST(25190000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T01:49:28.297' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (31, 2, 1, N'Laptop Acer Gaming Aspire 7', N'laptop-acer-gaming-aspire-7-31', N'Laptop Acer Gaming Aspire 7 A715-59G-73LB mở ra thế giới gaming đầy hứng khởi với sức mạnh tiềm ẩn đến từ bộ vi xử lý Intel Core i7-12650H mạnh mẽ. Hệ thống tản nhiệt kép hiện đại giúp luồng khí lưu thông hiệu quả, giữ cho máy luôn mát mẻ. Với thiết kế cứng cáp và trọng lượng chỉ 1.99kg, mẫu laptop Acer Aspire 7 này còn mang đến sự linh hoạt cho người dùng.', 100, CAST(22990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T01:56:41.123' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (34, 2, 7, N'Laptop Lenovo Yoga Slim 7', N'laptop-lenovo-yoga-slim-7-34', N'Laptop Lenovo Yoga Slim 7 14IMH9 83CV00AHVN nổi bật với chip Intel Core Ultra 5 125H, mang lại hiệu suất xử lý nhanh chóng cho mọi nhu cầu công việc. Bộ nhớ RAM 16GB LPDDR5x cùng ổ SSD 1TB giúp máy tối ưu hóa trải nghiệm đa nhiệm, lưu trữ. Mẫu laptop Lenovo Yoga này có thiết kế mỏng nhẹ với trọng lượng chỉ 1.39kg giúp người dùng dễ dàng mang theo khi di chuyển. ', 100, CAST(24990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T02:07:03.320' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (35, 2, 7, N'Laptop Lenovo LOQ', N'laptop-lenovo-loq-35', N'Laptop Lenovo LOQ 15IRX9 83DV017HVN được ưu ái trang bị chipset Intel Core i7-13650HX mạnh mẽ, mang lại hiệu năng xử lý ổn định trong tác vụ nặng. GPU NVIDIA GeForce RTX 4050 đi kèm TGP 105W hỗ trợ máy xử lý đồ họa mượt mà. Cùng với đó là RAM 24GB và ổ cứng 512GB, giúp đa nhiệm hiệu quả và rút ngắn thời gian khởi động máy.', 99, CAST(24990000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T02:17:29.517' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (36, 2, 7, N'Laptop Lenovo IdeaPad Slim 5 OLED', N'laptop-lenovo-ideapad-slim-5-oled-36', N'Laptop Lenovo Ideapad Slim 5 15ARP10 83J3002SVN sử dụng bộ xử lý AMD Ryzen 7 7735HS kết hợp với card AMD Radeon 680 Graphics cho hiệu suất ấn tượng. Máy tính được tích hợp sẵn SSD dung lượng lớn 512GB tốc độ cao và RAM 32GB đa nhiệm hiệu quả. Tấm nền WQXGA OLED 15.1” hiển thị sắc nét, đẹp mắt với tần số làm tươi 165Hz. ', 100, CAST(21990000 AS Decimal(18, 0)), 0, 1, CAST(N'2025-06-14T02:25:44.160' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (37, 2, 7, N'Laptop Lenovo ThinkPad E14 Gen 5', N'laptop-lenovo-thinkpad-e14-gen-5-37', N'Laptop Lenovo Thinkpad E14 Gen 5 21JK00PEVN sử dụng bộ nhớ RAM tổng dung lượng 16GB, mang lại khả năng xử lý linh hoạt và ổn định trong thời gian dài. Ổ cứng SSD dung lượng 512GB chuẩn PCIe 4.0x4 M.2 cho phép truy cập dữ liệu nhanh chóng. Mẫu laptop Lenovo Thinkpad này còn được tích hợp đồ họa Intel® UHD, hỗ trợ hiển thị hình ảnh sắc nét.', 98, CAST(20490000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T02:32:56.177' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (38, 2, 7, N'Laptop Lenovo ThinkBook 16 G6', N'laptop-lenovo-thinkbook-16-g6-38', N'Laptop Lenovo ThinkBook 16 G6 IRL 21KH00Q0VN sở hữu vi xử lý Intel® Core™ i5-13420H, RAM 16GB DDR5 xử lý tác vụ từ cơ bản đến nâng cao một cách dễ dàng. Laptop có thiết kế mỏng nhẹ chỉ 1.7 kg và độ dày 17,5 mm, tiện lợi cho người dùng thường xuyên phải di chuyển. Màn hình laptop Lenovo Thinkbook này có độ lớn 16 inch WUXGA (1920x1200) IPS, chống chói mang đến hình ảnh sắc nét và sống động, người dùng làm việc hay giải trí đều thoải mái.', 100, CAST(17690000 AS Decimal(18, 0)), 1, 1, CAST(N'2025-06-14T02:37:35.717' AS DateTime), NULL)
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1001, 1, 1, N'test', N'', N'test', 100, CAST(1000000 AS Decimal(18, 0)), 0, 0, CAST(N'2026-07-30T22:40:56.830' AS DateTime), CAST(N'2026-07-30T22:40:56.830' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1002, 1, 1, N'test 1', N'', N'test', 100, CAST(300000 AS Decimal(18, 0)), 0, 0, CAST(N'2026-07-30T22:49:56.627' AS DateTime), CAST(N'2026-07-30T22:49:56.627' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1003, 1, 1, N'test 3', N'', N'test', 100, CAST(300000 AS Decimal(18, 0)), 0, 0, CAST(N'2026-07-30T22:55:06.793' AS DateTime), CAST(N'2026-07-30T22:55:06.793' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1004, 1, 1, N'test 4', N'test-4-1004', N'test', 100, CAST(1000000 AS Decimal(18, 0)), 0, 0, CAST(N'2026-07-30T23:03:54.010' AS DateTime), CAST(N'2026-07-30T23:03:54.010' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1005, 1, 1, N'san pham test', N'san-pham-test-1005', N'terst', 100, CAST(300000 AS Decimal(18, 0)), 0, 0, CAST(N'2026-07-30T23:33:32.550' AS DateTime), CAST(N'2026-07-30T23:33:32.550' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1006, 1, 1, N'san pham test 2', N'san-pham-test-2-1006', N'safsfad', 100, CAST(300000 AS Decimal(18, 0)), 0, 0, CAST(N'2026-07-30T23:46:19.677' AS DateTime), CAST(N'2026-07-30T23:46:19.677' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1007, 1, 1, N'san pham test 3', N'san-pham-test-3-1007', N'afasfsd', 1333, CAST(300000 AS Decimal(18, 0)), 0, 1, CAST(N'2026-07-30T23:51:33.490' AS DateTime), CAST(N'2026-07-30T23:51:33.493' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1009, 1, 1, N'test 341343', N'test-341343-1009', N'123123', 1323123, CAST(123123 AS Decimal(18, 0)), 0, 1, CAST(N'2026-07-30T17:15:53.423' AS DateTime), CAST(N'2026-07-31T22:09:50.243' AS DateTime))
GO
INSERT [dbo].[Products] ([id], [category_id], [brand_id], [product_name], [alias], [description], [quantity], [price], [is_active], [is_hot], [created_at], [updated_at]) VALUES (1010, 1, 1, N'123', N'123-1010', N'3123', 122, CAST(10000 AS Decimal(18, 0)), 1, 1, CAST(N'2026-07-31T22:17:43.230' AS DateTime), CAST(N'2026-07-31T22:17:43.230' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([id], [email], [phone_number], [password], [address], [role], [is_active], [full_name], [created_at], [updated_at], [date_of_birth], [gender], [google_id], [login_type]) VALUES (2003, N'user1@gmail.com', N'1231231231', N'$2a$11$2dwJKCVzHC2itHqNT1uUf.oe3in9rz0X06SEYto9S0/fU10c5/RXC', NULL, N'User', 1, N'abc', CAST(N'2026-06-18T18:51:01.643' AS DateTime), CAST(N'2026-06-18T18:51:01.643' AS DateTime), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([id], [email], [phone_number], [password], [address], [role], [is_active], [full_name], [created_at], [updated_at], [date_of_birth], [gender], [google_id], [login_type]) VALUES (2004, N'user2', N'1231231', N'$2a$11$K/GCONXAKq3RZbnK.fSg9u/0R3zLy/11PpVwBkrpWHmF0i.kvTRDy', NULL, N'User', 1, N'abc', CAST(N'2026-06-18T18:51:46.677' AS DateTime), CAST(N'2026-06-18T18:51:46.677' AS DateTime), NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([id], [email], [phone_number], [password], [address], [role], [is_active], [full_name], [created_at], [updated_at], [date_of_birth], [gender], [google_id], [login_type]) VALUES (3002, N'test@gmail.com', N'3123123123', N'$2a$11$NEGzFfoi8z4.WaK/4cweauc6GglaYfuivQODyRNPds6x/2RkGq.AS', N'fadfasdf', N'User', 1, N'Nguyen Thanh Bao', CAST(N'2026-07-31T18:06:15.543' AS DateTime), CAST(N'2026-07-31T20:15:07.777' AS DateTime), CAST(N'2025-08-06T03:15:03.000' AS DateTime), 0, NULL, NULL)
GO
INSERT [dbo].[Users] ([id], [email], [phone_number], [password], [address], [role], [is_active], [full_name], [created_at], [updated_at], [date_of_birth], [gender], [google_id], [login_type]) VALUES (3003, N'test2@gmail.com', N'12312312', N'$2a$11$GsMt/T8fn3Xayg4tLRjKien5eJZbOQxNVZhK90u84eDmtA2bqgqem', N'11 Bàu Bàng', N'User', 1, N'Nguyễn Thanh Bảo', CAST(N'2026-07-31T20:18:51.740' AS DateTime), CAST(N'2026-07-31T21:12:07.723' AS DateTime), CAST(N'2003-11-08T03:19:07.000' AS DateTime), 2, NULL, NULL)
GO
INSERT [dbo].[Users] ([id], [email], [phone_number], [password], [address], [role], [is_active], [full_name], [created_at], [updated_at], [date_of_birth], [gender], [google_id], [login_type]) VALUES (3004, N'thanhbaontb16@gmail.com', N'141241', NULL, N'11 Bàu Bàng', N'User', 1, N'Nguyen Bao', CAST(N'2026-08-02T18:40:33.733' AS DateTime), CAST(N'2026-08-03T20:24:53.043' AS DateTime), CAST(N'2025-08-06T01:44:05.000' AS DateTime), 0, N'108968078197359215801', N'Google')
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Brands] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Images] ADD  DEFAULT ((0)) FOR [is_thumb]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [quantity]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD FOREIGN KEY([parent_id])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD FOREIGN KEY([parent_id])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Images]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Images]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([brand_id])
REFERENCES [dbo].[Brands] ([id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([brand_id])
REFERENCES [dbo].[Brands] ([id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Wishlists]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Wishlists]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([id])
GO
ALTER TABLE [dbo].[Wishlists]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Wishlists]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([id])
GO
