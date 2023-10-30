/*PROC LOAD CLIENTE*/
DELIMITER //
CREATE PROCEDURE CarregarCliente()
BEGIN 
	DECLARE ClienteRestantes INT DEFAULT 1;
	DECLARE ClienteId bigint;
	DECLARE ClienteCPF varchar(11);

	WHILE ClienteRestantes > 0 DO
		SET ClienteRestantes = (SELECT COUNT(*) FROM Cliente_Carga);

		IF ClienteRestantes > 0 THEN
			SELECT CPF INTO ClienteCPF FROM Cliente_Carga ORDER BY CPF LIMIT 1;
		
			INSERT INTO Cliente (Nome, Sobrenome, CPF)
			SELECT Nome, SobreNome, CPF FROM Cliente_Carga WHERE CPF = ClienteCPF;
		
			SET ClienteId = LAST_INSERT_ID();

			INSERT INTO Cliente_Endereco (IdCliente, Cep, Logradouro, Numero, Complemento)
			SELECT ClienteId, Cep, Logradouro, Numero, Complemento FROM Cliente_Carga WHERE CPF = ClienteCPF;

			INSERT INTO Cliente_Telefone (IdCliente, DDI, DDD, Prefixo, Sufixo)
			SELECT ClienteId, DDI, DDD, Prefixo, Sufixo FROM Cliente_Carga WHERE CPF = ClienteCPF;

			INSERT INTO Cliente_Email (IdCliente, Email)
			SELECT ClienteId, Email FROM Cliente_Carga WHERE CPF = ClienteCPF;

			DELETE FROM Cliente_Carga WHERE CPF = ClienteCPF;

			SET ClienteRestantes = (SELECT COUNT(*) FROM Cliente_Carga);
		END IF;
    END WHILE;
END//
DELIMITER ;
/*PROC LOAD CLIENTE*/


/*PROC LOAD CLIENTE*/
DELIMITER //
CREATE PROCEDURE CarregarProduto()
BEGIN 
	DECLARE ProdutoRestantes INT DEFAULT 1;
	DECLARE ProdutoId bigint;
	DECLARE CodigoProduto varchar(20);

	WHILE ProdutoRestantes > 0 DO
		SET ProdutoRestantes = (SELECT COUNT(*) FROM Produto_Carga);

		IF ProdutoRestantes > 0 THEN
			SELECT Codigo INTO CodigoProduto FROM Produto_Carga ORDER BY Codigo LIMIT 1;
		
			INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco)
			SELECT Codigo, Nome, Modelo, Fabricante, Preco FROM Produto_Carga WHERE Codigo = CodigoProduto;
		
			SET ProdutoId = LAST_INSERT_ID();

			INSERT INTO Produto_Cor (IdProduto, CodigoCor, Descricao)
			SELECT ProdutoId, CodigoCor, DescricaoCor FROM Produto_Carga WHERE Codigo = CodigoProduto;

			INSERT INTO Produto_Tamanho (IdProduto, CodigoTamanho, Tamanho)
			SELECT ProdutoId, CodigoTamanho, DescricaoTamanho FROM Produto_Carga WHERE Codigo = CodigoProduto;

			DELETE FROM Produto_Carga WHERE Codigo = CodigoProduto;

			SET ProdutoRestantes = (SELECT COUNT(*) FROM Produto_Carga);
		END IF;
    END WHILE;
END//
DELIMITER ;
/*PROC LOAD CLIENTE*/

CALL CarregarProduto();
CALL CarregarCliente();

SELECT * FROM Cliente;
SELECT * FROM Produto;