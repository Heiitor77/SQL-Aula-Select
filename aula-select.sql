-- Banco de apoio para a aula de SELECT
-- Compatível com MySQL 8+
--
-- Quantidade de registros inseridos:
--   categorias: 10
--   clientes_aula: 10
--   pedidos: 50



CREATE TABLE categorias (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(60) NOT NULL UNIQUE,
  descricao VARCHAR(160),
  ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE clientes_aula (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  cidade VARCHAR(60) NOT NULL,
  estado CHAR(2) NOT NULL,
  idade TINYINT UNSIGNED NOT NULL, /*não permite negativos. tinyint permite de 0 a 255 (sem a ck)*/
  limite_credito DECIMAL(10, 2) NOT NULL,
  ativo BOOLEAN NOT NULL DEFAULT TRUE,
  telefone VARCHAR(20),
  CONSTRAINT chk_clientes_idade CHECK (idade BETWEEN 18 AND 100),
  CONSTRAINT chk_clientes_limite CHECK (limite_credito >= 0)
);

CREATE TABLE pedidos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT NOT NULL,
  categoria_id INT NOT NULL,
  data_pedido DATE NOT NULL,
  valor DECIMAL(10, 2) NOT NULL,
  status ENUM('PENDENTE', 'PAGO', 'ENVIADO', 'CANCELADO') NOT NULL,
  forma_pagamento ENUM('PIX', 'CARTAO', 'BOLETO', 'DINHEIRO') NOT NULL,
  observacao VARCHAR(200),
  CONSTRAINT fk_pedidos_cliente
    FOREIGN KEY (cliente_id) REFERENCES clientes_aula(id),
  CONSTRAINT fk_pedidos_categoria
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
  CONSTRAINT chk_pedidos_valor CHECK (valor > 0)
);

INSERT INTO categorias (id, nome, descricao, ativo) VALUES
  (1, 'Eletronicos', 'Celulares, notebooks e acessorios', TRUE),
  (2, 'Informatica', 'Componentes e perifericos', TRUE),
  (3, 'Casa', 'Moveis e utilidades domesticas', TRUE),
  (4, 'Escritorio', 'Materiais para trabalho e estudo', TRUE),
  (5, 'Livros', 'Livros tecnicos e de ficcao', TRUE),
  (6, 'Esportes', 'Artigos para pratica esportiva', TRUE),
  (7, 'Vestuario', 'Roupas e calcados', TRUE),
  (8, 'Audio', 'Fones, caixas e equipamentos de audio', TRUE),
  (9, 'Fotografia', 'Cameras e acessorios fotograficos', TRUE),
  (10, 'Games', 'Jogos, consoles e controles', FALSE);

INSERT INTO clientes_aula
  (id, nome, email, cidade, estado, idade, limite_credito, ativo, telefone) VALUES
  (1, 'Ana Souza', 'ana.souza@email.com', 'Sao Paulo', 'SP', 28, 3500.00, TRUE, '11987650001'),
  (2, 'Bruno Lima', 'bruno.lima@email.com', 'Campinas', 'SP', 35, 1800.00, TRUE, '19987650002'),
  (3, 'Carla Mendes', 'carla.mendes@email.com', 'Rio de Janeiro', 'RJ', 42, 5200.00, TRUE, '21987650003'),
  (4, 'Diego Alves', 'diego.alves@email.com', 'Belo Horizonte', 'MG', 23, 900.00, TRUE, NULL),
  (5, 'Elisa Rocha', 'elisa.rocha@email.com', 'Curitiba', 'PR', 31, 2700.00, TRUE, '41987650005'),
  (6, 'Felipe Costa', 'felipe.costa@email.com', 'Salvador', 'BA', 19, 600.00, FALSE, '71987650006'),
  (7, 'Gabriela Martins', 'gabriela.martins@email.com', 'Sao Paulo', 'SP', 55, 7500.00, TRUE, '11987650007'),
  (8, 'Henrique Oliveira', 'henrique.oliveira@email.com', 'Porto Alegre', 'RS', 47, 4100.00, TRUE, '51987650008'),
  (9, 'Isabela Nunes', 'isabela.nunes@email.com', 'Recife', 'PE', 26, 1200.00, TRUE, NULL),
  (10, 'Joao Ribeiro', 'joao.ribeiro@email.com', 'Goiania', 'GO', 68, 2300.00, FALSE, '62987650010');

-- 50 pedidos: os valores, datas e status foram escolhidos para sustentar
-- todos os exemplos e exercicios do roteiro.
INSERT INTO pedidos
  (id, cliente_id, categoria_id, data_pedido, valor, status, forma_pagamento, observacao) VALUES
  (1, 1, 1, '2026-01-05', 1299.90, 'PAGO', 'PIX', 'Entrega expressa'),
  (2, 2, 2, '2026-01-06', 249.90, 'ENVIADO', 'CARTAO', NULL),
  (3, 3, 3, '2026-01-08', 899.00, 'PENDENTE', 'BOLETO', 'Aguardando confirmacao'),
  (4, 4, 4, '2026-01-10', 149.90, 'CANCELADO', 'PIX', 'Endereco incorreto'),
  (5, 5, 5, '2026-01-12', 79.90, 'PAGO', 'DINHEIRO', NULL),
  (6, 6, 6, '2026-01-15', 320.00, 'PENDENTE', 'CARTAO', NULL),
  (7, 7, 7, '2026-01-18', 450.00, 'ENVIADO', 'PIX', 'Troca de tamanho'),
  (8, 8, 8, '2026-01-20', 699.90, 'PAGO', 'CARTAO', NULL),
  (9, 9, 9, '2026-01-22', 1890.00, 'PENDENTE', 'BOLETO', 'Cliente solicitou prazo'),
  (10, 10, 10, '2026-01-25', 299.90, 'CANCELADO', 'PIX', NULL),
  (11, 1, 2, '2026-02-01', 189.90, 'PAGO', 'PIX', NULL),
  (12, 2, 5, '2026-02-03', 59.90, 'ENVIADO', 'BOLETO', NULL),
  (13, 3, 1, '2026-02-05', 2199.00, 'PAGO', 'CARTAO', 'Nota fiscal enviada'),
  (14, 4, 6, '2026-02-07', 85.00, 'PENDENTE', 'DINHEIRO', NULL),
  (15, 5, 3, '2026-02-09', 1250.00, 'ENVIADO', 'PIX', NULL),
  (16, 6, 7, '2026-02-11', 199.90, 'CANCELADO', 'CARTAO', 'Produto indisponivel'),
  (17, 7, 8, '2026-02-13', 329.90, 'PAGO', 'PIX', NULL),
  (18, 8, 9, '2026-02-15', 780.00, 'PENDENTE', 'CARTAO', 'Retirar na loja'),
  (19, 9, 10, '2026-02-17', 159.90, 'ENVIADO', 'BOLETO', NULL),
  (20, 10, 4, '2026-02-19', 210.00, 'PAGO', 'DINHEIRO', NULL),
  (21, 1, 3, '2026-02-21', 499.90, 'PENDENTE', 'PIX', NULL),
  (22, 2, 6, '2026-02-23', 680.00, 'PAGO', 'CARTAO', NULL),
  (23, 3, 7, '2026-02-25', 129.90, 'ENVIADO', 'PIX', 'Embalagem para presente'),
  (24, 4, 8, '2026-02-27', 249.00, 'PENDENTE', 'BOLETO', NULL),
  (25, 5, 9, '2026-03-01', 1450.00, 'PAGO', 'CARTAO', NULL),
  (26, 6, 10, '2026-03-03', 399.90, 'CANCELADO', 'PIX', 'Cliente desistiu'),
  (27, 7, 1, '2026-03-05', 3599.90, 'ENVIADO', 'CARTAO', 'Seguro incluido'),
  (28, 8, 2, '2026-03-07', 899.90, 'PAGO', 'PIX', NULL),
  (29, 9, 4, '2026-03-09', 75.00, 'PENDENTE', 'DINHEIRO', NULL),
  (30, 10, 5, '2026-03-11', 120.00, 'ENVIADO', 'BOLETO', NULL),
  (31, 1, 6, '2026-03-13', 250.00, 'PAGO', 'PIX', NULL),
  (32, 2, 7, '2026-03-15', 320.00, 'CANCELADO', 'CARTAO', NULL),
  (33, 3, 8, '2026-03-17', 999.90, 'PAGO', 'CARTAO', 'Entrega agendada'),
  (34, 4, 9, '2026-03-19', 2150.00, 'ENVIADO', 'PIX', NULL),
  (35, 5, 10, '2026-03-21', 249.90, 'PENDENTE', 'BOLETO', 'Aguardando boleto'),
  (36, 6, 1, '2026-03-23', 799.90, 'PAGO', 'DINHEIRO', NULL),
  (37, 7, 2, '2026-03-25', 1499.00, 'ENVIADO', 'CARTAO', NULL),
  (38, 8, 3, '2026-03-27', 2750.00, 'PAGO', 'PIX', 'Montagem solicitada'),
  (39, 9, 4, '2026-03-29', 95.90, 'CANCELADO', 'PIX', 'Duplicidade'),
  (40, 10, 5, '2026-03-31', 89.90, 'PENDENTE', 'CARTAO', NULL),
  (41, 1, 7, '2026-04-02', 599.90, 'PAGO', 'PIX', NULL),
  (42, 2, 8, '2026-04-04', 179.90, 'ENVIADO', 'BOLETO', NULL),
  (43, 3, 9, '2026-04-06', 3300.00, 'PENDENTE', 'CARTAO', 'Analise de limite'),
  (44, 4, 10, '2026-04-08', 450.00, 'PAGO', 'PIX', NULL),
  (45, 5, 1, '2026-04-10', 1099.90, 'ENVIADO', 'CARTAO', NULL),
  (46, 6, 2, '2026-04-12', 420.00, 'CANCELADO', 'BOLETO', 'Pagamento vencido'),
  (47, 7, 3, '2026-04-14', 650.00, 'PAGO', 'PIX', NULL),
  (48, 8, 4, '2026-04-16', 310.00, 'PENDENTE', 'DINHEIRO', NULL),
  (49, 9, 5, '2026-04-18', 65.00, 'ENVIADO', 'PIX', NULL),
  (50, 10, 6, '2026-04-20', 880.00, 'PAGO', 'CARTAO', 'Ultimo pedido do periodo');

-- Conferencia rápida da carga.
SELECT 'categorias' AS tabela, COUNT(*) AS quantidade FROM categorias
UNION ALL
SELECT 'clientes_aula', COUNT(*) FROM clientes_aula
UNION ALL
SELECT 'pedidos', COUNT(*) FROM pedidos;
