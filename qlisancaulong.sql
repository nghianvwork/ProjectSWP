-- ==========================
-- BẢNG NGƯỜI DÙNG
-- ==========================
CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(20),

    role VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);

-- ==========================
-- BẢNG KHU VỰC
-- ==========================
CREATE TABLE Areas (
    area_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255),
    manager_id INT NOT NULL,
    EmptyCourt INT,
    open_time TIME NOT NULL ,
    close_time TIME NOT NULL ,
    FOREIGN KEY (manager_id) REFERENCES Users(user_id),
    CONSTRAINT chk_area_time CHECK (open_time < close_time)
);


-- ==========================
-- BẢNG GIÁ THUÊ SÂN
-- ==========================
CREATE TABLE Court_Pricing (
    pricing_id INT PRIMARY KEY IDENTITY(1,1),
    area_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

-- ==========================
-- BẢNG SÂN
-- ==========================
CREATE TABLE Courts (
    court_id INT PRIMARY KEY IDENTITY(1,1),
    court_number VARCHAR(50) NOT NULL,
    [status] NVARCHAR(50),
    area_id INT NOT NULL,
    open_time TIME NULL,
    close_time TIME NULL,
    FOREIGN KEY (area_id) REFERENCES Areas(area_id),
    CONSTRAINT chk_court_time CHECK (
        open_time IS NULL OR close_time IS NULL OR open_time < close_time
    )
);

-- ==========================
-- BẢNG ĐẶT SÂN
-- ==========================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    court_id INT NOT NULL,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    [status] [nvarchar](50),
    
   
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id)
);

-- ==========================
-- BẢNG THIẾT BỊ
-- ==========================
CREATE TABLE Equipments (
    equipment_id INT PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    
);

-- ==========================
-- BẢNG ĐẶT THIẾT BỊ THEO BOOKING
-- ==========================
CREATE TABLE Booking_Equipments (
    id INT PRIMARY KEY IDENTITY(1,1),
    booking_id INT NOT NULL,
    equipment_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipments(equipment_id)
);

-- ==========================
-- BẢNG BÀI VIẾT
-- ==========================
CREATE TABLE Posts (
    post_id INT PRIMARY KEY IDENTITY(1,1),
    title VARCHAR(255) NOT NULL,
    content VARCHAR(MAX) NOT NULL,
    created_by INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    type VARCHAR(20) ,
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG BÌNH LUẬN
-- ==========================
CREATE TABLE Comments (
    comment_id INT PRIMARY KEY IDENTITY(1,1),
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content VARCHAR(MAX) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ==========================
-- BẢNG ĐÁNH GIÁ
-- ==========================
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    area_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment VARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (area_id) REFERENCES Areas(area_id)
);

-- ==========================
-- BẢNG DOANH THU
-- ==========================
CREATE TABLE Revenue (
    revenue_id INT PRIMARY KEY IDENTITY(1,1),
    court_id INT NOT NULL,
    date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    description VARCHAR(MAX),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (court_id) REFERENCES Courts(court_id)
);
CREATE TABLE [dbo].[password_reset_tokens](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[token] [varchar](255) NOT NULL,
	[created_at] [datetime] NULL,
	[is_used] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT ((0)) FOR [is_used]
GO
ALTER TABLE [dbo].[password_reset_tokens]  WITH CHECK ADD  CONSTRAINT [FK_password_reset_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[password_reset_tokens] CHECK CONSTRAINT [FK_password_reset_user]
GO
