drop database if exists db_Tabalho_Grupo;

create database db_Tabalho_Grupo;
use db_Tabalho_Grupo;
/* 
 * TABLE: Cliente 
 */

 DROP TABLE IF EXISTS db_Tabalho_Grupo.Cliente;

CREATE TABLE Cliente(
    IdCliente    bigint         AUTO_INCREMENT,
    Nome         varchar(30)    NOT NULL,
    Sobrenome    varchar(50)    NULL,
    CPF          varchar(11)    NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (IdCliente)
);

 DROP TABLE IF EXISTS db_Tabalho_Grupo.Cliente_Email;
/* 
 * TABLE: Cliente_Email 
 */
CREATE TABLE Cliente_Email(
    IdEmail      bigint          AUTO_INCREMENT,
    IdCliente    bigint          NOT NULL,
    Email        varchar(100)    NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY NONCLUSTERED (IdEmail)
);

DROP TABLE IF EXISTS db_Tabalho_Grupo.Cliente_Endereco;
/* 
 * TABLE: Cliente_Endereco 
 */

CREATE TABLE Cliente_Endereco(
    Cep            varchar(8)      NOT NULL,
    Logradouro     varchar(100)    NOT NULL,
    Numero         int             NULL,
    Complemento    varchar(50)     NULL,
    IdCliente      bigint          NOT NULL
);
DROP TABLE IF EXISTS db_Tabalho_Grupo.Cliente_Telefone;
/* 
 * TABLE: Cliente_Telefone 
 */

CREATE TABLE Cliente_Telefone(
    IdTelefone    bigint        AUTO_INCREMENT,
    IdCliente     bigint        NOT NULL,
    DDI           char(3)       NOT NULL,
    DDD           char(3)       NULL,
    Prefixo       varchar(5)    NOT NULL,
    Sufixo        varchar(5)    NOT NULL,
    CONSTRAINT PK9 PRIMARY KEY NONCLUSTERED (IdTelefone)
);
DROP TABLE IF EXISTS db_Tabalho_Grupo.Pedido;
/* 
 * TABLE: Pedido 
 */

CREATE TABLE Pedido(
    IdPedido      bigint            AUTO_INCREMENT,
    IdCliente     bigint            NOT NULL,
    Quantidade    int               NOT NULL,
    Valor         decimal(10, 2)    NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (IdPedido)
);
DROP TABLE IF EXISTS db_Tabalho_Grupo.Pedido_Item;
/* 
 * TABLE: Pedido_Item 
 */

CREATE TABLE Pedido_Item(
    IdPedidoItem    bigint            AUTO_INCREMENT,
    IdPedido        bigint            NOT NULL,
    IdProduto       bigint            NOT NULL,
	IdProdutoCor	bigint            NOT NULL,
	IdProdutoTamanho bigint            NOT NULL,
    Quantidade      int               NOT NULL,
    Valor           decimal(10, 2)    NOT NULL,
    CONSTRAINT PK13 PRIMARY KEY NONCLUSTERED (IdPedidoItem)
);
DROP TABLE IF EXISTS db_Tabalho_Grupo.Produto;
/* 
 * TABLE: Produto 
 */

CREATE TABLE Produto(
    IdProduto     bigint          AUTO_INCREMENT,
    Codigo       varchar(20)     NOT NULL,
    Nome          varchar(100)    NOT NULL,
    Modelo        varchar(30)     NOT NULL,
    Fabricante    varchar(20)     NOT NULL,
	Preco decimal(10, 2)     NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (IdProduto)
);
DROP TABLE IF EXISTS db_Tabalho_Grupo.Produto_Cor;

/* 
 * TABLE: Produto_Cor 
 */
CREATE TABLE Produto_Cor(
    IdProdutoCor    bigint         AUTO_INCREMENT,
    CodigoCor       varchar(8)     NOT NULL,
    IdProduto       bigint         NOT NULL,
    Descricao       varchar(50)    NOT NULL,
    CONSTRAINT PK14 PRIMARY KEY NONCLUSTERED (IdProdutoCor)
);
DROP TABLE IF EXISTS db_Tabalho_Grupo.Produto_Tamanho;

CREATE TABLE Produto_Tamanho(
    IdProdutoTamanho    bigint         AUTO_INCREMENT,
    CodigoTamanho    varchar(8)     NOT NULL,
    IdProduto        bigint         NOT NULL,
    Tamanho        decimal(4,2)    NOT NULL,
    CONSTRAINT PK15 PRIMARY KEY NONCLUSTERED (IdProdutoTamanho)
);

CREATE TABLE Cliente_Carga(
    CPF            varchar(11)     NOT NULL,
    Nome           varchar(30)     NOT NULL,
    Sobrenome      varchar(50)     NULL,
    Email          varchar(100)    NULL,
    Cep            varchar(8)      NULL,
    Logradouro     varchar(100)    NULL,
    Numero         int             NULL,
    Complemento    varchar(50)     NULL,
    DDI            char(3)         NULL,
    DDD            char(3)         NULL,
    Prefixo        varchar(5)      NULL,
    Sufixo         varchar(5)      NULL,
    CONSTRAINT PK16 PRIMARY KEY NONCLUSTERED (CPF)
);

CREATE TABLE Produto_Carga(
    Codigo              varchar(20)       NOT NULL,
    Nome                varchar(100)      NOT NULL,
    Modelo              varchar(30)       NOT NULL,
    Fabricante          varchar(20)       NOT NULL,
    Preco               decimal(10, 2)    NOT NULL,
    CodigoCor           varchar(8)        NOT NULL,
    DescricaoCor        varchar(50)       NOT NULL,
    CodigoTamanho       varchar(8)        NOT NULL,
    DescricaoTamanho    decimal(4, 2)     NOT NULL,
    CONSTRAINT PK17 PRIMARY KEY NONCLUSTERED (Codigo)
);

/*CONSTRAINTS*/
ALTER TABLE Cliente_Email ADD CONSTRAINT RefCliente18 
    FOREIGN KEY (IdCliente)
    REFERENCES Cliente(IdCliente)
;
ALTER TABLE Cliente_Endereco ADD CONSTRAINT RefCliente19 
    FOREIGN KEY (IdCliente)
    REFERENCES Cliente(IdCliente)
;
ALTER TABLE Cliente_Telefone ADD CONSTRAINT RefCliente17 
    FOREIGN KEY (IdCliente)
    REFERENCES Cliente(IdCliente)
;
ALTER TABLE Pedido ADD CONSTRAINT RefCliente16 
    FOREIGN KEY (IdCliente)
    REFERENCES Cliente(IdCliente)
;
ALTER TABLE Pedido_Item ADD CONSTRAINT RefPedido20 
    FOREIGN KEY (IdPedido)
    REFERENCES Pedido(IdPedido)
;
ALTER TABLE Pedido_Item ADD CONSTRAINT RefProduto23 
    FOREIGN KEY (IdProduto)
    REFERENCES Produto(IdProduto)
;

ALTER TABLE Pedido_Item ADD CONSTRAINT RefProduto_Cor26 
    FOREIGN KEY (IdProdutoCor)
    REFERENCES Produto_Cor(IdProdutoCor)
;
ALTER TABLE Pedido_Item ADD CONSTRAINT RefProduto_Tamanho27 
    FOREIGN KEY (IdProdutoTamanho)
    REFERENCES Produto_Tamanho(IdProdutoTamanho)
;
ALTER TABLE Produto_Cor ADD CONSTRAINT RefProduto21 
    FOREIGN KEY (IdProduto)
    REFERENCES Produto(IdProduto)
;
ALTER TABLE Produto_Tamanho ADD CONSTRAINT RefProduto22 
    FOREIGN KEY (IdProduto)
    REFERENCES Produto(IdProduto)
;
/*CONSTRAINTS*/

/*DADOS CLIENTE*/
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 1', 'Sobrenome 1', '40397223021');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 2', 'Sobrenome 2', '06998883013');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 3', 'Sobrenome 3', '49495788048');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 4', 'Sobrenome 4', '07551811079');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 5', 'Sobrenome 5', '83209531030');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 6', 'Sobrenome 6', '81672341000');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 7', 'Sobrenome 7', '57197617057');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 8', 'Sobrenome 8', '16522236060');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 9', 'Sobrenome 8', '92392066043');
INSERT INTO Cliente (Nome, Sobrenome, CPF) VALUES ('Cliente 10', 'Sobrenome 10', '06526522041');

INSERT INTO Cliente_Telefone (IdCliente, DDI, DDD, Prefixo, Sufixo)
SELECT IdCliente, '+55' AS DDI, '011' AS DDD, '98888' AS Prefixo, '7777' AS Sufixo FROM Cliente;

INSERT INTO Cliente_Email (IdCliente, Email)
SELECT IdCliente, CONCAT(REPLACE(Nome, ' ', ''), '@email.com.br') AS Email FROM Cliente;


CREATE TEMPORARY TABLE EnderecosTmp (Id bigint, Cep varchar(8), Logradouro varchar(50), Numero int, Complemento varchar(50));
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 1, '13317292', 'SOLARIS', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 2, '04045000', 'JABAQUARA', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 3, '31035560', 'CONSELHEIRO LAFAIETE', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 4, '18030000', 'BARAO DE TATUI', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 5, '18030000', 'BARAO DE TATUI', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 6, '04612002', 'BARONESA DE BELA VISTA', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 7, '18047620', 'ANTONIO CARLOS COMITRE', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 8, '18047620', 'ANTONIO CARLOS COMITRE', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 9, '99010001', 'BRASIL', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;
INSERT INTO EnderecosTmp (Id, Cep, Logradouro, Numero, Complemento) SELECT 10, '18047620', 'ANTONIO CARLOS COMITRE', (FLOOR( 1 + RAND( ) *1600 )) AS Numero, '' AS Complemento;


INSERT INTO Cliente_Endereco (IdCliente, Cep, Logradouro, Numero, Complemento) SELECT IdCliente, B.Cep, B.Logradouro, (FLOOR( 1 + RAND( ) * 1600)) AS Numero, B.Complemento FROM Cliente A INNER JOIN EnderecosTmp B ON A.IdCliente = B.Id;
DROP TEMPORARY TABLE EnderecosTmp;
/*DADOS CLIENTE*/

/*DADOS PRODUTO*/
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('01.01.01', 'Tenis 1', 'Tenis', 'Nike', 199.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('01.01.02', 'Tenis 2', 'Tenis', 'Adidas', 189.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('01.01.03', 'Tenis 3', 'Tenis', 'Vans', 299.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('02.01.04', 'Tenis', 'Tenis', 'Vert', 159.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('02.01.05', 'Tenis', 'Tenis', 'Puma', 109.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('02.01.01', 'Sapato 1', 'Sapato', 'Arezzo', 99.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('02.01.02', 'Sapato 2', 'Sapato', 'Shutz', 199.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('02.01.03', 'Sapato 3', 'Sapato', 'CNS', 169.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('02.01.04', 'Sapato 4', 'Sapato', 'Prego', 189.9);
INSERT INTO Produto (Codigo, Nome, Modelo, Fabricante, Preco) VALUES ('02.01.05', 'Sapato 5', 'Sapato', 'Reserva', 159.9);

CREATE TEMPORARY TABLE CoresTmp (CodigoCor varchar(2), Descricao varchar(50));
INSERT INTO CoresTmp (CodigoCor, Descricao) VALUES ('01', 'Branco');
INSERT INTO CoresTmp (CodigoCor, Descricao) VALUES ('02', 'Marrom');
INSERT INTO CoresTmp (CodigoCor, Descricao) VALUES ('02', 'Preto');

CREATE TEMPORARY TABLE TamanhosTmp (CodigoTamanho varchar(2), Tamanho decimal(4,2));
INSERT INTO TamanhosTmp (CodigoTamanho, Tamanho) VALUES ('01', 35);
INSERT INTO TamanhosTmp (CodigoTamanho, Tamanho) VALUES ('02', 35.5);
INSERT INTO TamanhosTmp (CodigoTamanho, Tamanho) VALUES ('03', 36);
INSERT INTO TamanhosTmp (CodigoTamanho, Tamanho) VALUES ('04', 37);
INSERT INTO TamanhosTmp (CodigoTamanho, Tamanho) VALUES ('05', 38);

INSERT INTO Produto_Cor (IdProduto, CodigoCor, Descricao) SELECT A.IdProduto, B.CodigoCor, B.Descricao FROM Produto A INNER JOIN CoresTmp B ON 1 = 1;

INSERT INTO Produto_Tamanho (IdProduto, CodigoTamanho, Tamanho) SELECT A.IdProduto, B.CodigoTamanho, B.Tamanho FROM Produto A INNER JOIN TamanhosTmp B ON 1 = 1;

DROP TEMPORARY TABLE CoresTmp;

DROP TEMPORARY TABLE TamanhosTmp;
/*DADOS PRODUTO*/

/*CRIA VIEW PEDIDO*/
CREATE VIEW ViewPedidos AS SELECT F.Nome AS Nome_Cliente, F.SobreNome AS SobreNome_Cliente, A.IdPedido, A.Quantidade, A.Valor, C.Nome AS Produto, D.Descricao AS Cor, E.Tamanho, B.Valor AS Valor_Item FROM Pedido A INNER JOIN Pedido_Item B ON A.IdPedido = B.IdPedido INNER JOIN Produto C ON B.IdProduto = C.IdProduto INNER JOIN Produto_Cor D ON B.IdProdutoCor = D.IdProdutoCor INNER JOIN Produto_Tamanho E ON B.IdProdutoTamanho = E.IdProdutoTamanho INNER JOIN Cliente F ON A.IdCliente = F.IdCliente;
/*CRIA VIEW PEDIDO*/

/*PROC INCLUI PEDIDO*/
DELIMITER //
CREATE PROCEDURE IncluiPedido (IdCliente bigint, QtdeItens int)
BEGIN 
	DECLARE PedidoId bigint;
	INSERT INTO Pedido (IdCliente, Quantidade, Valor) VALUES (IdCliente, QtdeItens, 0);
	SET PedidoId = LAST_INSERT_ID();
	
	CREATE TEMPORARY TABLE IF NOT EXISTS PedidoItemTmp AS (SELECT PedidoId AS IdPedido, IdProduto, 0 AS IdProdutoCor, 0 AS IdProdutoTamanho, Preco FROM Produto ORDER BY RAND() LIMIT QtdeItens);

	CREATE TEMPORARY TABLE IF NOT EXISTS PedidoItemTamanhoTmp AS (SELECT A.IdProdutoTamanho, B.IdProduto FROM Produto_Tamanho A INNER JOIN PedidoItemTmp B ON A.IdProduto = B.IdProduto ORDER BY RAND() LIMIT QtdeItens);
	
	CREATE TEMPORARY TABLE IF NOT EXISTS PedidoItemCorTmp AS (SELECT A.IdProdutoCor, B.IdProduto FROM Produto_Cor A INNER JOIN PedidoItemTmp B ON A.IdProduto = B.IdProduto ORDER BY RAND() LIMIT QtdeItens);

	CREATE TEMPORARY TABLE IF NOT EXISTS PedidoItemCompletedTmp AS (SELECT A.IdPedido,  A.IdProduto, B.IdProdutoCor, C.IdProdutoTamanho, A.Preco FROM PedidoItemTmp A INNER JOIN PedidoItemCorTmp B ON A.IdProduto = B.IdProduto INNER JOIN PedidoItemTamanhoTmp C ON A.IdProduto = B.IdProduto LIMIT QtdeItens);
	
	UPDATE Pedido A
	INNER JOIN (
		SELECT IdPedido, SUM(Preco) AS Total
		FROM PedidoItemCompletedTmp
		GROUP BY IdPedido
	) B ON A.IdPedido = B.IdPedido
	SET A.Valor = B.Total;

	INSERT INTO Pedido_Item (IdPedido,  IdProduto, IdProdutoCor, IdProdutoTamanho, Quantidade, Valor)
	SELECT IdPedido,  IdProduto, IdProdutoCor, IdProdutoTamanho, 1, Preco FROM PedidoItemCompletedTmp;

	DROP TEMPORARY TABLE PedidoItemTmp;
	DROP TEMPORARY TABLE PedidoItemTamanhoTmp;
	DROP TEMPORARY TABLE PedidoItemCorTmp;
	DROP TEMPORARY TABLE PedidoItemCompletedTmp;
END//
DELIMITER ;
/*PROC INCLUI PEDIDO*/

/*PROC INCLUI PEDIDO*/
CALL IncluiPedido(1, 5);
CALL IncluiPedido(2, 6);
CALL IncluiPedido(3, 3);
CALL IncluiPedido(4, 4);
CALL IncluiPedido(5, 3);
CALL IncluiPedido(6, 2);
CALL IncluiPedido(7, 3);
CALL IncluiPedido(8, 1);
CALL IncluiPedido(9, 3);
CALL IncluiPedido(10, 5);
/*PROC INCLUI PEDIDO*/

SELECT '********************** LISTA DE PEDIDOS CRIADOS *****************************';
SELECT * FROM ViewPedidos;