





create table Users(
username varchar(20) PRIMARY KEY ,
password varchar(20) ,
first_name varchar(20) ,
last_name varchar(20) ,
email varchar(50) not null
);
create table User_mobile_numbers(
mobile_number  varchar(20) not null,
username varchar(20) FOREIGN KEY references Users(username)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(mobile_number,username)
);
create table User_Addresses
(
address varchar(100) not null,
username varchar(20) FOREIGN KEY references Users(username)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(address,username)
);

create table Customer(
username varchar(20) FOREIGN KEY references Users(username)
ON DELETE CASCADE ON UPDATE CASCADE,
points int  default 0,
PRIMARY KEY(username)
);



create table Admins(
username varchar(20) FOREIGN KEY references Users(username)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(username)
);

create table Vendor(
username varchar(20) FOREIGN KEY references Users(username)
ON DELETE CASCADE ON UPDATE CASCADE,
activated bit default 0,
company_name varchar(20) not null,
bank_acc_no varchar(20) not null,
admin_username varchar(20) FOREIGN KEY references Admins(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY(username)
);

create table Delivery_Person(
username varchar(20) FOREIGN KEY references Users(username)
ON DELETE CASCADE ON UPDATE CASCADE,
is_activated bit default 0,
PRIMARY KEY(username)
);
create table Credit_Card(
number varchar(20) not null,
expiry_date datetime not null,
cvv_code varchar(4) not null,
PRIMARY KEY (number)
);
create table Delivery(
id int not null identity,
type varchar(20) not null,
time_duration int not null, 
fees decimal(5,3) not null,
username varchar(20) FOREIGN KEY references Admins(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY (id)
);
create table Orders
(
order_no int primary key IDENTITY,
order_date datetime not null,
total_amount decimal(10,2) , 
cash_amount decimal(10,2),
credit_amount decimal(10,2), 
payment_type varchar(50),
order_status varchar(50) not null default 'not processed',
remaining_days int ,
time_limit int ,

customer_name varchar(20) FOREIGN KEY references Customer (username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
delivery_id int FOREIGN KEY references Delivery(id) 
ON DELETE NO ACTION ON UPDATE NO ACTION,
creditCard_number varchar(20) FOREIGN KEY references Credit_Card(number) 
ON DELETE NO ACTION ON UPDATE NO ACTION,

);
create table Product(
serial_no int not null identity ,
product_name varchar(20) not null,
category varchar(20) not null,
product_description text not null,
price decimal(10,2) not null,
final_price decimal(10,2) not null,
color varchar(20) ,
available bit default 0,
rate int , 
vendor_username varchar(20) FOREIGN KEY references Vendor(username) 
ON DELETE NO ACTION ON UPDATE NO ACTION,
customer_username  varchar(20) FOREIGN KEY references Customer(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
customer_order_id int FOREIGN KEY references Orders(order_no)
ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY (serial_no)
);
create table CustomerAddstoCartProduct
(
serial_no int FOREIGN KEY references product(serial_no) 
ON DELETE NO ACTION ON UPDATE NO ACTION,  
customer_name varchar(20) FOREIGN KEY references Customer(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY (serial_no,customer_name)
);

create table Todays_Deals
(
deal_id int not null identity,
deal_amount int default 0, 
expiry_date datetime not null, 
admin_username varchar(20) FOREIGN KEY references Admins(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY(deal_id)
);

create table Todays_Deals_Product
(
deal_id int FOREIGN KEY references Todays_Deals(deal_id) 
ON DELETE NO ACTION ON UPDATE NO ACTION,
serial_no int FOREIGN KEY references product(serial_no) 
ON DELETE NO ACTION ON UPDATE NO ACTION, 

PRIMARY KEY(deal_id,serial_no)
);
create table offer
(
offer_id int PRIMARY KEY identity,
offer_amount int ,
expiry_date datetime
);
create table offersOnProduct
(
offer_id int FOREIGN KEY references offer (offer_id)
ON DELETE NO ACTION ON UPDATE NO ACTION,
serial_no int FOREIGN KEY references Product (serial_no)
ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY (offer_id,serial_no)
);
create table Customer_Question_Product
(
serial_no int FOREIGN KEY references Product (serial_no)
ON DELETE NO ACTION ON UPDATE NO ACTION,
customer_name varchar(20) FOREIGN KEY references Customer(username)
ON DELETE NO ACTION ON UPDATE NO ACTION, 
question varchar (50) not null,
answer varchar(50),
PRIMARY KEY(serial_no,customer_name)
);
create table Wishlist
(
username varchar(20) FOREIGN KEY references Customer(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,  
name varchar(20) not null,
PRIMARY KEY (username ,name)
);
create table Giftcard
(
code varchar(10) PRIMARY KEY, 
expiry_date datetime, 
amount int default 0,
username varchar(20) FOREIGN KEY references Admins(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
);
ALTER TABLE Orders
ADD GiftCardCodeUsed varchar(10) FOREIGN KEY references Giftcard(code)
ON DELETE NO ACTION ON UPDATE NO ACTION;

create table Wishlist_Product
(
username varchar(20) ,
wish_name varchar(20) ,
serial_no int FOREIGN KEY references Product (serial_no)
ON DELETE NO ACTION ON UPDATE NO ACTION,
FOREIGN KEY(username,wish_name)references Wishlist
ON DELETE NO ACTION ON UPDATE NO ACTION,
PRIMARY KEY( username,wish_name,serial_no)
);
create table Admin_Customer_Giftcard
(
code  varchar(10) FOREIGN KEY references Giftcard(code),
customer_name varchar(20)FOREIGN KEY references Customer(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,  
admin_username varchar(20) FOREIGN KEY references Admins(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
remainingPoints int default 0,
PRIMARY KEY (code, customer_name,admin_username)
);


create table Admin_Delivery_Order(
delivery_username varchar (20) FOREIGN KEY references Delivery_Person(username)
ON DELETE NO ACTION ON UPDATE NO ACTION, 
order_no INT FOREIGN KEY references orders(order_no)
ON DELETE NO ACTION ON UPDATE NO ACTION, 
admin_username varchar(20) FOREIGN KEY references Admins(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,
delivery_window varchar(50), 
PRIMARY KEY (delivery_username,order_no)
);
create table Customer_CreditCard(
customer_name varchar(20)FOREIGN KEY references Customer(username)
ON DELETE NO ACTION ON UPDATE NO ACTION,  
cc_number varchar(20) FOREIGN KEY references Credit_Card (number)
ON DELETE NO ACTION ON UPDATE NO ACTION,  
PRIMARY KEY (customer_name, cc_number)
);
go
create proc activatedV
@user varchar(20) ,
@active int output
as
if ((select activated from Vendor where username=@user)=1)
set @active =1;
else
set @active =0;
go
create proc activateVendors
@admin_username varchar(20),
@vendor_username varchar(20)
AS
BEGIN
IF NOT exists (select 1 from Vendor where username = @vendor_username)
	print 'Such Vendor does not exist'
ELSE IF NOT exists (select 1 from Admins where username = @admin_username)
	print 'Such admin doesn not exist'
ELSE
	update Vendor
	set activated= 1 , Vendor.admin_username = @admin_username
	where  Vendor.username = @vendor_username  AND Vendor.activated = 0
END
go
create proc addAddress
@username varchar(20),
@address varchar(100)
as
insert into User_Addresses
values(@address,(select username from Users where username = @username))
go
CREATE PROC AddCreditCard
@creditcardnumber varchar(20), @expirydate date , @cvv varchar(4), @customername varchar(20)
as
INSERT into Credit_Card VALUES(@creditcardnumber,@expirydate,@cvv )
INSERT into Customer_CreditCard values(
(select username 
from Customer
where username = @customername),
(select number 
from Credit_Card 
where number=@creditcardnumber))
go
create proc addDelivery
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20)
as
BEGIN
IF NOT exists (select 1 from Admins where username = @admin_username)
	print 'Such admin does not exist'
ELSE
	insert into Delivery (type,time_duration,fees,username)
	values(@delivery_type,@time_duration,@fees,
	(select username from Admins where username = @admin_username))
END
go
create proc addMobile
@username varchar(20),
@mobile_number varchar(20)
as
begin
insert into User_mobile_numbers
values (@mobile_number,(select username from Users where username = @username))
END
go
create proc addOffer
@offeramount int, 
@expiry_date datetime
as
insert into offer (offer_amount,expiry_date)
values(@offeramount,@expiry_date)
go
create proc addQuestion
@serial int ,
@customer varchar(20),
@question varchar(50)
as 
insert into customer_question_product(serial_no,customer_name,question)
values ((select serial_no from Product where serial_no = @serial),
(select username from Customer where username = @customer),@question)

-- drop proc addToCart
go
create proc addToCart
@customername varchar(20),
@serial int 
as 
IF((select available FROM Product where serial_no=@serial)=1)
insert into customerAddstoCartProduct
values ((select serial_no from Product where serial_no = @serial ),
(select username from Customer where username = @customername))
go
	create proc changePrice
@deal_id int,
@serial_no int
as
begin
update Product
set final_price = final_price - ((select deal_amount from Todays_deals where deal_id=@deal_id) * 0.01
*price)
where serial_no = @serial_no
END
go
create proc addTodaysDealOnProduct
@deal_id int,
@serial_no int
as
begin
IF NOT exists (select 1 from Todays_Deals where deal_id = @deal_id)
	print 'Such deal does not exist'
ELSE IF NOT exists (select 1 from Product where serial_no = @serial_no)
	print 'Such Product does not exist'
ELSE
	insert into Todays_Deals_Product (deal_id,serial_no)
	values ((select deal_id from Todays_Deals where deal_id = @deal_id),
	(select serial_no from Product where serial_no = @serial_no))

	exec changePrice @deal_id,@serial_no
end
go
create proc AddtoWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int
as 
insert into wishlist_product
values((select username from Customer where username=@customername),
(select name from Wishlist where name=@wishlistname and username=@customername),
(select serial_no from Product where serial_no = @serial))
go

create proc answerQuestions
@vendorname varchar(20), 
@serialno int, 
@customername varchar(20), 
@answer text
as
BEGIN
update  Customer_Question_Product
set answer = @answer
WHERE (serial_no =
 (select serial_no from Product where serial_no=@serialno AND vendor_username = @vendorname))
 and customer_name=@customername
END
go

create proc applyOffer --already mawgood sa7?
@vendorname varchar(20),
@offerid int, 
@serial int
as
BEGIN
insert into offersOnProduct
values(@offerid,@serial)
update Product
set final_price=price-(price*0.01*(select offer.offer_amount from offer where offer_id=@offerid)) --amount percentage walla rakam
where serial_no=@serial and vendor_username=@vendorname
END
go
create proc assignOrdertoDelivery
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
as
BEGIN
IF NOT exists (select 1 from Delivery_Person where username = @delivery_username)
	print 'Such delivery person does not exist'
	
ELSE IF NOT exists (select 1 from Orders where order_no = @order_no)
	print 'Such order does not exist'

ELSE IF NOT exists (select 1 from Admins where username = @admin_username)
	print 'Such admin does not exist'

ELSE
	insert into Admin_Delivery_Order(delivery_username,order_no,admin_username)
	values((select username from Delivery_Person where username = @delivery_username),
	(select order_no from Orders where order_no = @order_no),
	(select username from Admins where username = @admin_username))
END
go
create proc available1
@sn int ,
@av int output
as
begin
if((select available from Product where serial_no=@sn)='true')
set @av = 1 ;
else
set @av =0;
end
go
create proc calculatepriceOrder
@customername varchar(20),
@sum decimal(10,2) OUTPUT
as
BEGIN
IF NOT exists (select 1 from Customer where username = @customername)
	print 'Such customer does not exist'
ELSE
	set @sum = (select sum(final_price) from Product p inner join CustomerAddstoCartProduct cp on p.serial_no=cp.serial_no
	where cp.customer_name=@customername)
END
---
go
create proc cancelOrder
@orderid int
as


	update Product
	set available=1,customer_order_id=null ,customer_username=null
	where customer_order_id=@orderid;

    update Customer
	set points=points+(select total_amount from Orders where order_no=@orderid)-(select cash_amount from Orders where order_no=@orderid)
	-(select credit_amount from Orders where order_no=@orderid)
	where username in(
	select customer_name from Orders where order_no=@orderid);
	if exists(select code from Giftcard g inner join Orders o on g.code=o.GiftCardCodeUsed where g.expiry_date>CURRENT_TIMESTAMP )
	
    update Admin_Customer_Giftcard
	set remainingPoints=remainingPoints+(select total_amount from Orders where order_no=@orderid)-(select cash_amount from Orders where order_no=@orderid)
	-(select credit_amount from Orders where order_no=@orderid)
	where customer_name in(
	select customer_name from Orders
	where order_no=@orderid
	);
	delete from Orders where order_no = @orderid ;
	
go
create proc checkandremoveExpiredoffer
@offerid int
as
BEGIN
declare @offeramount int
set @offeramount = (select offer.offer_amount from offer where offer_id=@offerid)/100
update  Product 
set final_price=price+price*@offeramount
from offersOnProduct o inner join Product p on o.serial_no=p.serial_no
where (select expiry_date from offer where offer.offer_id=@offerid) <  CURRENT_TIMESTAMP
delete  from offersOnProduct
where offersOnProduct.offer_id=@offerid and (select expiry_date from offer where offer.offer_id=@offerid) <  CURRENT_TIMESTAMP
delete  from offer
where offer_id=@offerid and(select expiry_date from offer where offer.offer_id=@offerid) <  CURRENT_TIMESTAMP
END
go
create proc checkGiftCardOnCustomer
@code varchar(10),
@activeGiftCard BIT OUTPUT
as
BEGIN
IF NOT exists (select 1 from Giftcard where code = @code)
	print 'Such giftcard does not exist'
ELSE
	IF NOT exists (select 1 from Admin_Customer_Giftcard where code = @code)
		set @activeGiftCard = 0
	ELSE 
		set @activeGiftCard = 1
END
go
create proc checkOfferonProduct
@serial int,
@active BIT output
as
if @serial in (select serial_no from offersOnProduct)
set @active =1
else
set @active=0
go
create proc checkpro
@serialno int ,
@exists int output
as
if(@serialno in (select serial_no from Product where available='1'))
set @exists=1;
else set @exists=0;
go
create proc checkTodaysDealOnProduct
@serial_no INT,
@activeDeal BIT output
as
BEGIN
IF NOT exists (select 1 from Product where serial_no = @serial_no)
	print 'Such product does not exist'
ELSE
	IF NOT exists (select 1 from Todays_Deals_Product where serial_no = @serial_no)
		set @activeDeal = 0
	ELSE
		set @activeDeal = 1
END
go
CREATE PROC ChooseCreditCard
@creditcard varchar(20), @orderid int,
@out int output
AS
if(@creditcard in (select number from Credit_Card where number=@creditcard))
begin
set @out =1;
Update Orders 
SET creditCard_number = (select number from Credit_Card where number=@creditcard)
WHERE order_no = @orderid
end
else 
set @out =0;
go
create proc createGiftCard
@code varchar(10),
@expiry_date datetime,
@amount int,
@admin_username varchar(20)
as
IF NOT exists (select 1 from Admins where username = @admin_username)
	print 'Such admin does not exist'
ELSE
	insert into Giftcard (code,expiry_date,amount,username)values(@code,@expiry_date,@amount,
	(select username from Admins where username = @admin_username))
	go
	create proc createTodaysDeal
@deal_amount int,
@admin_username varchar(20),
@expiry_date datetime
as
BEGIN
IF NOT exists (select 1 from Admins where username = @admin_username)
	print 'Such admin does not exist'
ELSE
	insert into Todays_Deals(deal_amount,expiry_date,admin_username)
	values(@deal_amount,@expiry_date,(select username from Admins where username = @admin_username))
END
go
create proc createWishlist
@customername varchar(20),
@name varchar(20)
as 
insert into wishlist
values((select username from Customer where username=@customername),@name)
go
create proc customerRegister
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
as
begin
insert into Users
values (@username,@password,@first_name,@last_name,@email)
insert into Customer(username,points)
values ((select username from Users where username = @username),0)

end
go

create proc deleteProduct
@vendorname varchar(20), 
@serialnumber int
as
delete from Product 
where vendor_username=@vendorname and serial_no=@serialnumber
delete from Customer_Question_Product
where serial_no=@serialnumber
delete from CustomerAddstoCartProduct
where serial_no=@serialnumber
delete from offersOnProduct
where serial_no=@serialnumber
delete from Todays_Deals_Product
where serial_no=@serialnumber
delete from Wishlist_Product
where serial_no=@serialnumber
go
create proc deliveryPersonUpdateInfo
@username varchar(20),
@first_name varchar(20),
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS
UPDATE Users
SET first_name = @first_name , last_name = @last_name , password = @password ,
email = @email
WHERE username = @username and exists(SELECT * FROM Delivery_Person
WHERE username = @username and is_activated = 1
)
go
create proc EditProduct
@vendorname varchar(20), 
@serialnumber int, 
@product_name varchar(20) ,
@category varchar(20),
@product_description text , 
@price decimal(10,2), 
@color varchar(20)
as
declare @offeramount int
declare @todaysdealamount int
set @offeramount=0
set @todaysdealamount=0
if exists(select offer_id from offersOnProduct where serial_no=@serialnumber)
set @offeramount=(select offer_amount from offer where offer_id=(select offer_id from offersOnProduct where serial_no=@serialnumber))
if exists(select deal_id from Todays_Deals_Product where serial_no=@serialnumber)
set @todaysdealamount=(select deal_amount from Todays_Deals where deal_id=(select deal_id from Todays_Deals_Product where serial_no=@serialnumber))

update Product 
set 
product_name=@product_name, category=@category , product_description = @product_description , price=@price , color=@color,
final_price=@price-price*(@offeramount/100)-price*(@todaysdealamount/100)
where 
vendor_username=@vendorname and serial_no=@serialnumber

----------------
go
create proc emptyCart
@customername varchar(20)
AS
BEGIN
if not exists(select 1 from Customer where username= @customername)
	print'Such customer does not exist'
ELSE
	delete from CustomerAddstoCartProduct where customer_name=@customername 
END
go
create proc giveGiftCardtoCustomer
@code varchar(10),
@customer_name varchar(20),
@admin_username varchar(20)
as
IF NOT exists (select 1 from Admins where username = @admin_username)
	print 'Such admin does not exist'
ELSE IF NOT exists (select 1 from Customer where username = @customer_name)
	print 'Such customer does not exist'
ELSE IF NOT exists (select 1 from Giftcard where code = @code)
	print 'Such giftcard does not exist'
ELSE
begin
	insert into Admin_Customer_Giftcard values (
	(select code from Giftcard where code = @code),
	(select username from Customer where username = @customer_name),
	(select username from Admins where username = @admin_username),
	(select amount from Giftcard where code = @code))

	update Customer
	set points = (select points from Customer where username = @customer_name)+
	(select amount from Giftcard where code = @code)
    where username=@customer_name 
end
--leqaaa
go
create proc inviteDeliveryPerson
@delivery_username varchar(20),
@delivery_email varchar(20)
AS
BEGIN
insert into users (username,email) Values (@delivery_username,@delivery_email)
insert into Delivery_Person (username) VALUES (@delivery_username)
END
go
create proc latestOrder
@orderid int output
as
select @orderid = MAX(order_no)
from Orders;
go
create proc productsinorder
@customername varchar(20),
@orderID int 
as
BEGIN
update product 
set available=0,customer_order_id=@orderid,customer_username=@customername
where serial_no in
(
select p.serial_no 
from product p INNER JOIN
customerADDstocartproduct ca
on p.serial_no=ca.serial_no
where ca.customer_name=@customername
)
delete from customeraddstocartproduct
where serial_no in(
select p.serial_no 
from product p INNER JOIN
customerADDstocartproduct ca
on p.serial_no=ca.serial_no
where ca.customer_name<>@customername
)
select *
from product p 
where p.customer_username=@customername and p.customer_order_id=@orderid
END
go
create proc makeOrder
@customername varchar(20)
AS
declare @tot decimal(10,2),
@lol int
begin
if not exists(select 1 from Customer where username= @customername)
	print'Such customer does not exist'
ELSE
	exec calculatepriceOrder @customername,@tot output
	insert into Orders(total_amount, customer_name, order_date) values (
	@tot,
	(select username from Customer where username = @customername),
	CURRENT_TIMESTAMP)

	set @lol = (select max(order_no) from Orders)
	exec productsinorder @customername, @lol
	exec emptyCart @customername
END
go
CREATE PROC postProduct
@vendorUsername varchar(20), 
@product_name varchar(20) ,
@category varchar(20), 
@product_description text , 
@price decimal(10,2), 
@color varchar(20)
AS
BEGIN
INSERT into Product (vendor_username, product_name, category , product_description, price,final_price, color,available)
VALUES ((select username from Vendor where username=@vendorUsername),
@product_name,@category,@product_description,@price,@price,@color,1)
END
go
CREATE PROC rate
@serialno int, @rate int , @customername varchar(20)
AS 
UPDATE Product
SET rate = @rate
where serial_no = @serialno AND customer_username = @customername
go
create proc recommend 
@customername varchar(20)
as
select * from product
where serial_no in(
select top 3 
p2.serial_no 
from 
Product p2 inner join Wishlist_Product wp on p2.serial_no=wp.serial_no
where p2.category in(
select top 3
p.category
from  Product p inner join CustomerAddstoCartProduct c2 on p.serial_no=c2.serial_no
where c2.customer_name=@customername
group by p.category
order by count(*) desc
)
group by p2.serial_no 
order by count(*) desc
)
or serial_no in
(select top 3 
p2.serial_no 
from 
Product p2 inner join Wishlist_Product wp on p2.serial_no=wp.serial_no
where wp.username in(
select 
c3.customer_name
from CustomerAddstoCartProduct c2 
inner join CustomerAddstoCartProduct c3 on c3.serial_no= c2.serial_no
where c3.customer_name<>c2.customer_name and c2.customer_name=@customername

)
group by p2.serial_no 
order by count(*) desc
)




---------------------
go
create proc removeExpiredDeal
@deal_id int
as
begin
IF NOT exists (select 1 from Todays_Deals where deal_id = @deal_id)
	print 'Such deal does not exist'
ELSE
	if exists(select t.deal_id from Todays_Deals t inner join 
	Todays_Deals_Product d on t.deal_id=d.deal_id where t.deal_id=@deal_id and
	CURRENT_TIMESTAMP > t.expiry_date)
	begin
		update Product
		set final_price = final_price + ((select deal_amount from Todays_Deals where
		deal_id = @deal_id) * 0.01 * price)

		delete from Todays_Deals_Product
		where deal_id = @deal_id
	
	end
	
	delete from Todays_Deals
	where deal_id = @deal_id AND CURRENT_TIMESTAMP > expiry_date
	
end
go
create proc removeExpiredGiftCard
@code varchar(10)
as
IF NOT exists (select 1 from Giftcard where code = @code)
	print 'Such giftcard does not exist'
ELSE 
begin

	if exists(select g.code from Giftcard g inner join 
	Admin_Customer_Giftcard a on g.code=a.code where g.code=@code and
	CURRENT_TIMESTAMP > g.expiry_date)
	begin
		update Customer
		set points = points - (select amount from Giftcard where
		code = @code)

		delete from Admin_Customer_Giftcard
		where code = @code
	end
	delete from Giftcard
	where code = @code AND CURRENT_TIMESTAMP > expiry_date
end
go
create proc removefromCart
@customername varchar(20),
@serial int
as
delete from customerAddstoCartProduct
where serial_no=@serial and customer_name=@customername
go
create proc removefromWishlist
@customername varchar(20),
@wishlistname varchar(20),
@serial int
as 
delete from wishlist_product
where username=@customername and wish_name =@wishlistname and serial_no=@serial

--lydiaaa
go

create proc returnProduct --rag3y 3aleha ya menna
@serialno int,
@orderid int 
as
BEGIN
if not exists (select 1 from Product where serial_no = @serialno)
begin
	print('Such product does not exist');
end
else
begin
	if not exists (select 1 from Orders where order_no = @orderid)
	begin
	print('Such product does not exist')
	end
	else
	begin
		update Product
		set available = 1 , customer_username=null ,customer_order_id=null 
		where serial_no = @serialno
		if exists ( select order_no from Orders o where o.order_no=@orderid and o.GiftCardCodeUsed=null)
		begin
			if exists (select order_no from Orders where order_no=@orderid and not(cash_amount<>0 or cash_amount<>null))
			begin
    			update Orders
				set cash_amount = cash_amount - (select final_price from Product where serial_no = @serialno),
				total_amount = total_amount - (select final_price from Product where serial_no = @serialno)
				where order_no = @orderid;
			end
			else
			begin
				update Orders
				set credit_amount = credit_amount - (select final_price from Product where serial_no = @serialno),
				total_amount = total_amount - (select final_price from Product where serial_no = @serialno)
				where order_no = @orderid;
			end
 		end
 		else
 		begin
 			declare @productprice int
 			declare @giftamountpaid int
 			set @productprice= (select price from Product where serial_no=@serialno)

 			if (select cash_amount from Orders where order_no=@orderid)=0 or (select cash_amount from Orders where order_no=@orderid)=null
 			begin
 				if (select credit_amount from Orders where order_no=@orderid)=0 or (select credit_amount from Orders where order_no=@orderid)=null
 				begin
 					update Admin_Customer_Giftcard
 					set remainingPoints =remainingPoints+@productprice
 					where code=(select giftcardcodeused from Orders where order_no=@orderid)
 					update Customer 
 					set points=points+@productprice
 					where username=(select customer_name from Orders where order_no=@orderid)
	 			end 
 				else
 				begin
 					set @giftamountpaid=(select total_amount from Orders where order_no=@orderid)-(select credit_amount from Orders where order_no=@orderid)
	 				if(@giftamountpaid >=@productprice)
 					begin
 						update Admin_Customer_Giftcard
 						set remainingPoints =remainingPoints+@productprice
 						where code=(select giftcardcodeused from Orders where order_no=@orderid)
 						update Customer 
 						set points=points+@productprice
 						where username=(select customer_name from Orders where order_no=@orderid)
 					end
 					else
 					begin
 						update Admin_Customer_Giftcard
 						set remainingPoints =remainingPoints+@giftamountpaid
 						where code=(select giftcardcodeused from Orders where order_no=@orderid)
 						update Customer 
 						set points=points+@giftamountpaid
 						where username=(select customer_name from Orders where order_no=@orderid)
 						update Orders
 						set credit_amount=credit_amount-(@productprice-@giftamountpaid)
 						where order_no=@orderid
 					end
 				end
 			end
 			else
 			begin
 				set @giftamountpaid=(select total_amount from Orders where order_no=@orderid)-(select cash_amount from Orders where order_no=@orderid)
 				if(@giftamountpaid >=@productprice)
 				begin
 					update Admin_Customer_Giftcard
 					set remainingPoints =remainingPoints+@productprice
 					where code=(select giftcardcodeused from Orders where order_no=@orderid)
 					update Customer 
 					set points=points+@productprice
 					where username=(select customer_name from Orders where order_no=@orderid)
 				end
 				else
 				begin
 					update Admin_Customer_Giftcard
 					set remainingPoints =remainingPoints+@giftamountpaid
 					where code=(select giftcardcodeused from Orders where order_no=@orderid)
 					update Customer 
 					set points=points+@giftamountpaid
 					where username=(select customer_name from Orders where order_no=@orderid)
 					update Orders
 					set cash_amount=cash_amount-(@productprice-@giftamountpaid)
 					where order_no=@orderid
 				end
 			end
 		end
	end
end
END
go

create proc reviewOrders
as
select *
from Orders
go
create proc searchbyname
@text varchar(20)
as
select*
from Product
where product_name=@text
go

create proc showProducts
as
select*
from Product
go
create proc ShowProductsbyPrice
as
select*
from Product
order by final_price
go
create proc ShowproductsIbought
@customername varchar(20)
as
begin
--select product_name from (select o.order_no from Orders inner join Customer c where )
select *
from Product 
WHERE customer_username = @customername
end
----
go
create proc showWishlistProduct
@customername varchar(20),               ---msh 3arfeen ne show kollo walla elly fl test cases bs
@name varchar(20)
as
Select p.serial_no , product_name, category, product_description, price ,final_price, color,
available, rate, vendor_username, customer_username, customer_order_id
from  wishlist_product wp
INNER JOIN product p
ON WP.serial_no=p.serial_no 
where wp.username=@customername and wp.wish_name =@name
go
create proc specifyamount
@customername varchar(20),
@orderID int,
@cash decimal(10,2),
@credit decimal(10,2)
AS
DECLARE @code VARCHAR(10)
DECLARE @total DECIMAL(10,2)
DECLARE @remgift int 

select @total=total_amount 
from orders
where order_no=@orderID;

set @remgift=@total-@cash-@credit

select @code =a2.code
from Admin_Customer_Giftcard a2
where a2.customer_name=@customername and code >any(select  a.code
from Admin_Customer_Giftcard a
where a.customer_name=@customername)
update Admin_Customer_Giftcard
set remainingpoints=remainingpoints-@remgift
where code = @code

if @remgift>0
begin
update orders
set GiftCardCodeUsed=(select code 
                      from  Giftcard
                      where code =@code
                      )
where order_no=@orderId
end
go
CREATE PROC specifydeliverytype
@orderID int, @deliveryID int
AS
DECLARE @remd INT
SET @remd = (
    select time_duration
    FROM delivery
    WHERE id = @deliveryID
)
update Orders
SET delivery_id = @deliveryID , remaining_days = @remd
where order_no=@orderID
go
CREATE proc specifyDeliveryWindow
@delivery_username varchar(20),
@order_no int,
@delivery_window varchar(50)
AS
UPDATE Admin_Delivery_Order 
SET delivery_window = @delivery_window
where delivery_username =@delivery_username and order_no =@order_no
go
CREATE PROC trackRemainingDays
@orderid int, @customername varchar(20),
@days INT OUTPUT 
AS
BEGIN
DECLARE @date datetime
DECLARE @duration int
SET @date = (
    SELECT order_date
    FROM Orders
    WHERE order_no = @orderid AND customer_name =@customername
)
SET @duration = (
    SELECT time_duration
    FROM Delivery
    WHERE id =(select delivery_id from Orders where order_no =@orderid)
)
SET @days = @duration- (Select DATEDIFF(DAY, @date , CURRENT_TIMESTAMP ))
UPDATE Orders
SET remaining_days = @days
WHERE order_no = @orderid AND customer_name =@customername
end
go
CREATE PROC updateOrderStatusDelivered
@order_no int
AS
begin
UPDATE Orders
SET order_status = 'delivered'
where order_no = @order_no
end
go
create proc updateOrderStatusInProcess
@order_no int
as
BEGIN
IF NOT exists (select 1 from Orders where order_no = @order_no)
	print 'Such order does not exist'
ELSE
	update Orders
	set order_status = 'in process'
	where order_no = @order_no
END
go
CREATE PROC updateOrderStatusOutforDelivery
@order_no int
AS
UPDATE Orders
SET order_status = 'Out for delivery'
where order_no = @order_no
go
create proc userLogin
@username varchar(20), 
@password varchar(20),
@success bit output , 
@type int output
AS
BEGIN
IF not exists (select 1 from Users where username = @username and password = @password)
    set @success = 0
ELSE IF exists (select 1 from Customer where username = @username AND
    exists (select password from Users where username = @username and password=@password))
    begin
    set @success = 1
    set @type = 0
    end 
else IF exists (select 1 from Vendor where username = @username AND
    exists (select password from Users where username = @username and password=@password))
    begin
    set @success = 1
    set @type = 1
    end
else if exists (select 1 from Admins where username = @username AND
    exists (select password from Users where username = @username and password=@password)) 
    BEGIN
    set @success = 1
    set @type = 2
    END
else if exists (select 1 from Delivery_Person where username = @username AND
    exists (select password from Users where username = @username and password=@password))
    BEGIN
    set @success = 1
    set @type = 3
    END
END
-- go
-- create proc userLogin --eb2y shofeeha
-- @username varchar(20), 
-- @password varchar(20),
-- @success bit output , 
-- @type int output
-- as
-- BEGIN
-- declare @s bit
-- declare @t int
-- if @username IN (select username from Admins) 
-- if @password in (select u.password from Users u where u.username=@username )
-- set @success=1 , @type=2
-- else
-- set @success=0 , @type=2
-- if @username IN (select username from Customer) 
-- if @password in (select u.password from Users u where u.username=@username )
-- set @success=1 , @type=0
-- else
-- set @success=0 , @type=0
-- if @username IN (select username from Vendor) 
-- if @password in (select u.password from Users u where u.username=@username )
-- set @success=1 , @type=1
-- else
-- set @success=0 , @type=1
-- if @username IN (select username from Delivery_Person) 
-- if @password in (select u.password from Users u where u.username=@username )
-- set @success=1 , @type=3
-- else
-- set @success=0 , @type=3
-- END
go
create proc vendorRegister
@username varchar(20),
@first_name varchar(20), 
@last_name varchar(20),
@password varchar(20),
@email varchar(50), 
@company_name varchar(20), 
@bank_acc_no varchar(20)
as
begin
insert into Users
values (@username,@password,@first_name,@last_name,@email)
insert into Vendor(username,company_name,bank_acc_no)
values((select username from Users where username = @username),@company_name,@bank_acc_no)
END
go
create proc vendorviewProducts
@vendorname varchar(20)
as
select * 
from Product p
where p.vendor_username=@vendorname
go
CREATE PROC vewDeliveryTypes
AS
SELECT DISTINCT type,time_duration,fees
FROM Delivery
go
create proc viewMycart
@customername varchar(20)
as
select *
from product p
INNER JOIN CustomerAddstoCartProduct c
ON p.serial_no=c.serial_no
where c.customer_name=@customername
go
CREATE proc viewmyorders
@deliveryperson varchar(20)
as
SELECT O.* 
FROM Orders O , Admin_Delivery_Order A
WHERE A.delivery_username=@deliveryperson And A.order_no = O.order_no
go

create proc viewQuestions
@vendorname varchar(20)
as
select p.serial_no,p.available,p.product_name,q.question
from Customer_Question_Product q inner join Product p on q.serial_no=p.serial_no
where p.vendor_username =@vendorname
