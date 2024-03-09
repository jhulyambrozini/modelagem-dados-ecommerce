-- recuperando informações do banco
use ecommerce;

-- recuperanso o numero de clientes
select count(*) as Number_of_clients from clients;

select concat(Fname, ' ', Lname) as completeName, cpf, orderFreight, orderStatus, Orderdescription from clients c, product_order o where c.idClient = idOrderClient; 

-- recuperação de pedido com produto associado
select Fname, Lname, idClient, idOrderClient, p.idPOOrder, o.idOrder 
from clients c inner join product_order o on c.idClient = o.idOrderClient
inner join productOrder p on p.idPOOrder = o.idOrder;
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select * from clients;
select * from product_order;

select Fname, Lname, idClient, count(*) as number_of_orders
from clients c inner join product_order p on  c.idClient = p.idOrderClient
group by idClient;

-- Algum vendedor também é fornecedor?
select * from thirdSeller;
select * from supplier;

select * from thirdSeller inner join supplier
using(legalPersonId);

-- Relação de produtos fornecedores e estoques
select productName, category, productDescription, productPrice, productAvaliation, quantity, stocklocation
from product p inner join productSupplier ps on ps.idSupplier = p.idProduct
inner join stock on quantity = stockquantity;


-- Relação de nomes dos fornecedores e nomes dos produtos
select corporateName, productName from supplier s inner join legalPerson p on idLegalPerson = legalPersonId
inner join productSupplier using(idSupplier)
inner join product using(idProduct)
order by productName;
