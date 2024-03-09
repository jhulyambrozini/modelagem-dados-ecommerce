-- esquema para cenário de Ecommerce
create database ecommerce;
use ecommerce;

SHOW TABLES;

-- tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    ClientAdress varchar(30),
    Bdate date not null,
    constraint unique_cpf_client unique (CPF)
);

-- fazer isso para todas as tabbelas com auto_increment
alter table payments auto_increment=1;

-- table metodos de pagamento relação 1:N com client
create table payments(
	idPayment int,
    idClient int,
    MethodPayment enum('Cartão de crédito', 'Boleto', 'Dois cartões', 'Pix', 'PicPay'),
    primary key auto_increment (idClient, idPayment),
    constraint fk_id_client foreign key (idClient) references clients(idClient)
);

-- tabela de pedido relação 1:N com client
create table product_order(
	idOrder int auto_increment primary key,
    idOrderClient int,
    OrderFreight float not null,
    OrderStatus ENUM('Em andamento', 'Processando', 'Enviando', 'Entregue', 'Cancelado') default 'Processando',
    OrderDescription varchar(255),
    paymentCard bool default false,
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
);

-- table de entrega relação 1:1 com productOrder
create table delivery(
	idDelivery int auto_increment primary key,
    idOrder int unique,
    DeliveryStatus ENUM('Saiu para entrega', 'Em anadmento', 'Entregue') default 'Saiu para entrega',
    TrackingCode varchar(45) not null,
    constraint fk_order_id foreign key (idOrder) references product_order(idOrder)
);

drop table product;
-- table produto
create table product(
	idProduct int auto_increment primary key,
    Category enum('Blusas', 'Saias', 'Conjuntos', 'Shorts', 'Infantil', 'Tapetes', 'Biquinis') not null,
    ProductDescription varchar(255),
    ProductPrice float not null,
    ProductSize varchar(10), -- Dimensão do produto
    ProductAvaliation Float default 0
);

alter table product add ProductName varchar(45) not null;
desc product;

-- table de estoque
create table stock(
	idStock int auto_increment primary key,
    StockLocation varchar(60) not null,
    StockQuantity int not null
);

-- tabela de de pessoa juridica
create table legalPerson(
	idLegalPerson int auto_increment primary key,
    CorporateName varchar(45) not null,
    CNPJ char(14) not null,
    Adress varchar(60),
    constraint unique_cnpj unique(CNPJ)
);


-- tabela de fornecedor relação 1:1 com legalPerson
create table supplier(
	idSupplier int auto_increment primary key,
    legalPersonId int,
    Contact char(11) not null,
    constraint fk_legal_person foreign key (legalPersonId) references legalPerson(idLegalPerson)
);

-- table de vendedor terceiro relaçao 1:1 com legalPerson
create table thirdSeller(
	idThirdSeller int auto_increment primary key,
    AbstractName varchar(45),
	legalPersonId int,
    constraint fk_legal_person_id foreign key (legalPersonId) references legalPerson(idLegalPerson)
);

drop table productThirdSeller;

-- tabela relação N:M entre product e third seller
create table productThirdSeller(
	idTSeller int,
    idProduct int,
    productQuantity int default 1,
    primary key (idTSeller, idProduct),
    constraint fk_product_seller foreign key (idTSeller) references thirdSeller(idThirdSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);


-- tabela relação N:M entre product e product_order
create table productOrder(
	idPOProduct int,
    idPOOrder int,
    productQuantity int default 1,
    orderStatus ENUM('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOProduct, idPOOrder),
    constraint fk_product_order_id foreign key (idPOOrder) references product_order(idOrder),
    constraint fk_product_product_id foreign key (idPOProduct) references product(idProduct)
);

-- table relação N:M entre product e Supplier
create table productSupplier(
	idProduct int,
    idSupplier int,
    quantity int not null,
    primary key (idProduct, idSupplier),
    constraint fk_product_supplier_id foreign key (idSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idProduct) references product(idProduct)
);


-- tabela relação N:M entre product e stock
create table productStock(
	idProduct int,
    idStock int,
    location varchar(60) not null,
    primary key (idProduct, idStock),
    constraint fk_product_stock foreign key (idStock) references stock(idStock),
	constraint fk_product_stock_product foreign key (idProduct) references product(idProduct)
);

show tables;

use information_schema;
select * from referential_constraints where constraint_schema = 'ecommerce';

