IF EXISTS (SELECT * FROM sys.databases WHERE name='Elevationsystem_G5')
DROP DATABASE Elevationsystem_G5;
CREATE DATABASE Elevationsystem_G5;
GO
USE Elevationsystem_G5
GO
CREATE TABLE Users(
	idu int PRIMARY KEY IDENTITY NOT NULL,  /* id của người sử dụng */
	username nvarchar(20) NOT NULL, /* username đăng nhập hệ thống */
	[password] nvarchar(50) NOT NULL, /* mật khẩu truy cập hệ thống */
	fullname varchar(100) NOT NULL, /* họ tên người sử dụng */
	birthday date, /* ngày tháng năm sinh người sử dụng */
	phone varchar(11), /* số điện thoại người sử dụng */
	email nvarchar(100), /* email người sử dụng */
	[address] nvarchar(500), /* địa chỉ người sử dụng */
	isactive bit, /* trạng thái tài khoản */
)
CREATE TABLE Product_types(
	idp_type int PRIMARY KEY IDENTITY NOT NULL, /*id của loại sản phẩm */
	value nvarchar(100) /* tên của loại sản phẩm */
)
CREATE TABLE Products(
	idp int PRIMARY KEY IDENTITY NOT NULL, /* id của sản phẩm */
	idp_type int CONSTRAINT pk_idp FOREIGN KEY (idp_type) REFERENCES Product_types(idp_type), /* id của loại sản phẩm */
	name nvarchar(500), /* tên sản phẩm */
	price float, /* giá sản phẩm */
	[weight] nvarchar(300), /* tải trọng của sản phẩm */
	speed nvarchar(300), /* tốc độ di chuyển của sản phẩm */
	height int, /* độ cao tối đa có thể di chuyển của sản phẩm */
	sale float, /* mức khuyến mại của sản phẩm */
	[status] int, /* trạng thái của sản phẩm(0 là còn hàng, 1 là hết hàng) */
	ishot bit default 0, /* trạng thái hot của sản phẩm (default là 0: bình thường, 1 là sản phẩm hot) */
	isactive bit, /* trạng thái của sản phẩm */
	[description] nvarchar(max) /* mô tả về sản phẩm */
)
CREATE TABLE Images(
	id int PRIMARY KEY IDENTITY NOT NULL, /* mã ảnh */
	idp int CONSTRAINT pk_idpimg FOREIGN KEY (idp) REFERENCES Products(idp), /* mã sản phẩm */
	url nvarchar(max)
)
CREATE TABLE Playment(
	idpl int PRIMARY KEY IDENTITY NOT NULL, /* Mã hình thức thanh toán */
	valuepl nvarchar(100) /* loại hình thức thanh toán */
)
CREATE TABLE Orders(
	ido int PRIMARY KEY IDENTITY NOT NULL, /* id hóa đơn */
	fullname nvarchar(100), /* họ tên khách hàng */
	phone varchar(11), /* số điện thoại khách hàng */
	email nvarchar(100), /* email khách hàng */
	[address] nvarchar(max), /* địa chỉ nhận hàng */
	idpl int CONSTRAINT pk_playment FOREIGN KEY (idpl) REFERENCES Playment(idpl), /* mã hình thức thanh toán */
)
CREATE TABLE OrderDetails(
	idd int PRIMARY KEY IDENTITY NOT NULL, /* id của chi tiết hóa đơn */
	ido int CONSTRAINT pk_ido FOREIGN KEY (ido) REFERENCES Orders(ido), /* mã hóa đơn */
	idp int CONSTRAINT pk_idpod FOREIGN KEY (idp) REFERENCES Products(idp), /* mã sản phẩm */
	countp int default 1 /* số lượng sản phẩm trong đơn hàng */
)
CREATE TABLE Feedback(
	idf int PRIMARY KEY IDENTITY NOT NULL, /* mã phản hồi */
	fullname nvarchar(100), /* họ tên người phản hồi */
	email nvarchar(100), /* email phản hồi */
	content nvarchar(max), /* nội dung phản hồi */
	isreply bit default 0, /* trạng thái trả lời: 0 là chưa, 1 là đã trả lời */
	replycontent nvarchar(max) /* nội dung trả lời phản hồi */
)
CREATE TABLE Abouts(
	id int PRIMARY KEY IDENTITY, /* mã *//
	name nvarchar(100), /* tên công ty */
	phone varchar(11), /* số điện thoại công ty */
	fax varchar(24), /* fax công ty */
	email varchar(100), /* email công ty */
	[address] nvarchar(max), /* địa chỉ công ty */
	[description] nvarchar(max) /* giới thiệu về công ty */
)