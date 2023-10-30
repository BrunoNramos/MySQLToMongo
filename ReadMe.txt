################################################################################################################
################################################################################################################
################# Roteiro para criação de tabelas e inclusão de produtos, clientes e pedidos ###################
################################################################################################################
################################################################################################################

===> Subir o serviço do Docker
===> Abrir o pront ou o Shell

===> Instaciar o docker do mySql
docker container exec -it MySQL bash

===> Criar a pasta scripts dentro do contaier
mkdir /tmp/scripts

===> Sair do container para o pront da máquina local
exit

===> Copiar o arquivo script.sql para a pasta do container
docker container cp "{{local de desconpactação}}\script.sql" MySQL:/tmp/scripts

===> Voltar para o container do MySql
docker container exec -it MySQL bash

===> Instarciar MySql
docker container exec -it MySQL bash

===> Executar o script sql completo
source /tmp/scripts/script.sql

################################################################################################################
################################################################################################################
####################### Roteiro para importação do csv com produtos e pedidos ##################################
################################################################################################################
################################################################################################################

===> Executar no mysql
 SHOW VARIABLES LIKE "secure_file_priv";

==> Copiar o resultado da coluna Value Exmplo: "/var/lib/mysql-files/"

==> Sair da instancia do SQL
quit

==> Sair do container
exit

==> Sair do copiar o arquivo csv para o container
docker container cp "{{local de desconpactação}}\Clientes_Carga.csv" MySQL:/var/lib/mysql-files/
docker container cp "{{local de desconpactação}}\Produtos_Carga.csv" MySQL:/var/lib/mysql-files/

===> Instaciar o docker do mySql
docker container exec -it MySQL bash

==> Instanciar o mysql
mysql

==> Excutar importação do Csv para tabela auxiliar de importação
LOAD DATA INFILE '/var/lib/mysql-files/Clientes_Carga.csv' INTO TABLE Cliente_Carga CHARACTER SET utf8mb4 FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 ROWS (CPF,Nome,Sobrenome,Email,Cep,Logradouro,Numero,Complemento,DDI,DDD,Prefixo,Sufixo);

LOAD DATA INFILE '/var/lib/mysql-files/Produtos_Carga.csv' INTO TABLE Produto_Carga CHARACTER SET utf8mb4 FIELDS OPTIONALLY ENCLOSED BY '"' TERMINATED BY ';' LINES TERMINATED BY '\n' IGNORE 1 ROWS (Codigo,Nome,Modelo,Fabricante,Preco,CodigoCor,DescricaoCor,CodigoTamanho,DescricaoTamanho);

==> Efetuar carga para as tabelas transacionais
source /tmp/scripts/script_2.sql
