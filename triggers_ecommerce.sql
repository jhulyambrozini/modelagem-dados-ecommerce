use ecommerce;

-- Trigger para copiar informações de clientes antes da remoção
DELIMITER //
CREATE TRIGGER before_delete_clients
BEFORE DELETE ON clients
FOR EACH ROW
BEGIN
    INSERT INTO deleted_clients (idClient, Fname, Minit, Lname, CPF, ClientAdress, Bdate)
    VALUES (OLD.idClient, OLD.Fname, OLD.Minit, OLD.Lname, OLD.CPF, OLD.ClientAdress, OLD.Bdate);
END;
//
DELIMITER ;

-- Trigger de atualização para inserção de novos colaboradores e atualização do salário base
DELIMITER //
CREATE TRIGGER update_employee_salary
BEFORE UPDATE ON legalPerson
FOR EACH ROW
BEGIN
    -- Verifica se a mudança é relacionada ao nome da empresa
    IF NEW.CorporateName != OLD.CorporateName THEN
        -- Realiza o registro da atualização do nome da empresa na tabela de histórico
        INSERT INTO corporate_name_updates (idLegalPerson, OldCorporateName, NewCorporateName, UpdateDate)
        VALUES (OLD.idLegalPerson, OLD.CorporateName, NEW.CorporateName, NOW());
    END IF;
END;
//
DELIMITER ;


