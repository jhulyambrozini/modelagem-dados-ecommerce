use ecommerce;

-- Qual o cliente mais antigo cadastrado?
-- Procedure para inserir, atualizar ou remover dados da tabela clients
DELIMITER //

CREATE PROCEDURE ManageClients(
    IN action INT,
    IN idClient INT,
    IN Fname VARCHAR(10),
    IN Minit CHAR(3),
    IN Lname VARCHAR(20),
    IN CPF CHAR(11),
    IN ClientAdress VARCHAR(30),
    IN Bdate DATE
)
BEGIN
    CASE action
        WHEN 1 THEN -- Inserir
            INSERT INTO clients (Fname, Minit, Lname, CPF, ClientAdress, Bdate) VALUES (Fname, Minit, Lname, CPF, ClientAdress, Bdate);
        WHEN 2 THEN -- Atualizar
            UPDATE clients
            SET Fname = Fname, Minit = Minit, Lname = Lname, ClientAdress = ClientAdress, Bdate = Bdate
            WHERE idClient = idClient;
        WHEN 3 THEN -- Remover
            DELETE FROM clients WHERE idClient = idClient;
    END CASE;
END //

DELIMITER ;

-- Criação de índices para a tabela clients
CREATE INDEX idx_clients_bdate ON clients(Bdate);

-- Qual é o status mais comum dos pedidos?
-- Procedure para inserir, atualizar ou remover dados da tabela product_order
DELIMITER //

CREATE PROCEDURE ManageProductOrders(
    IN action INT,
    IN idOrder INT,
    IN idOrderClient INT,
    IN OrderFreight FLOAT,
    IN OrderStatus ENUM('Em andamento', 'Processando', 'Enviando', 'Entregue', 'Cancelado'),
    IN OrderDescription VARCHAR(255),
    IN paymentCard BOOL
)
BEGIN
    CASE action
        WHEN 1 THEN -- Inserir
            INSERT INTO product_order (idOrderClient, OrderFreight, OrderStatus, OrderDescription, paymentCard) 
            VALUES (idOrderClient, OrderFreight, OrderStatus, OrderDescription, paymentCard);
        WHEN 2 THEN -- Atualizar
            UPDATE product_order
            SET OrderFreight = OrderFreight, OrderStatus = OrderStatus, OrderDescription = OrderDescription, paymentCard = paymentCard
            WHERE idOrder = idOrder;
        WHEN 3 THEN -- Remover
            DELETE FROM product_order WHERE idOrder = idOrder;
    END CASE;
END //

DELIMITER ;

-- Criação de índices para a tabela product_order
CREATE INDEX idx_product_order_status ON product_order(OrderStatus);
