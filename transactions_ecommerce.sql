use ecommerce;

-- Desabilitar autocommit
SET autocommit = 0;

-- Iniciar a transação
START TRANSACTION;

SELECT * FROM clients WHERE idClient = 1;

UPDATE clients SET ClientAdress = 'Nova rua, 123' WHERE idClient = 1;

-- Commit da transação
COMMIT;


DELIMITER //

CREATE PROCEDURE UpdateClientAddress(IN client_id INT, IN new_address VARCHAR(30))
BEGIN
    -- Declaração de variáveis para controle de erro
    DECLARE rollbackOccurred BOOLEAN DEFAULT FALSE;
    
    SET autocommit = 0;

    START TRANSACTION;

    -- Verificar se o cliente existe
    SELECT COUNT(*) INTO @clientExists FROM clients WHERE idClient = client_id;
    
    -- Se cliente não existe, ocorreu um erro
    IF @clientExists = 0 THEN
        SET rollbackOccurred = TRUE;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente não encontrado.';
    END IF;

    -- Atualizar o endereço do cliente
    UPDATE clients SET ClientAdress = new_address WHERE idClient = client_id;

    -- Se houver algum erro, fazer rollback
    IF rollbackOccurred THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END//

DELIMITER ;
