-- ==========================================
-- 03_dados.sql: INSERÇÃO DE DADOS INICIAIS (SEED)
-- ==========================================

INSERT INTO public.competicoes (id, nome) VALUES 
    (4, 'SuperCopa'),
    (5, 'Superliga'),
    (6, 'Copa Brasil')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.adversarios (id, time, nivel, estado, cidade, ginasio) VALUES 
    (1, 'ABEL Moda Vôlei Brusque', 'desafiante', 'SC', 'Brusque', 'Sesi Brusque'),
    (2, 'Batavo Mackenzie', 'competitiva', 'MG', 'Belo Horizonte', 'Ginásio do Mackenzie'),
    (3, 'Brasília Vôlei', 'desafiante', 'DF', 'Brasília', 'Ginásio Sesi Taguatinga'),
    (4, 'Esporte Clube Pinheiros', 'desafiante', 'SP', 'São Paulo', 'Ginásio Henrique Villaboim'),
    (5, 'Fluminense', 'competitiva', 'RJ', 'Rio de Janeiro', 'Ginásio da Hebraica'),
    (6, 'Gerdau Minas', 'favorita', 'MG', 'Belo Horizonte', 'Arena UniBH'),
    (7, 'Osasco São Cristóvão Saúde', 'favorita', 'SP', 'Osasco', 'Ginásio José Liberatti'),
    (8, 'Paulistano Barueri', 'desafiante', 'SP', 'Barueri', 'Sportville'),
    (9, 'Sancor Seguros Vôlei Londrina', 'competitiva', 'PR', 'Londrina', 'Ginásio Moringão'),
    (10, 'Sesc RJ Flamengo', 'favorita', 'RJ', 'Rio de Janeiro', 'Ginásio do Tijuca Tênis Clube'),
    (11, 'Sesi Vôlei Bauru', 'competitiva', 'SP', 'Bauru', 'Arena Paulo Skaf')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.jogadoras (id, nome, data_nasc, nacionalidade, numero_camisa, posicao, altura) VALUES 
    (16, 'Macris', '1989-03-03', 'Brasil', 3, 'levantadora', 1.78),
    (17, 'Fabiola', '1983-02-03', 'Brasil', 14, 'levantadora', 1.85),
    (18, 'Milla', '1992-05-12', 'Brasil', 20, 'levantadora', 1.76),
    (19, 'Sabrina', '1996-04-09', 'Brasil', 9, 'oposta', 1.84),
    (20, 'Carla', '1992-01-17', 'Brasil', 13, 'oposta', 1.74),
    (21, 'Sofya Kuznetsova', '1999-10-31', 'Rússia', 7, 'ponteira', 1.85),
    (22, 'Michele Pavão', '1986-10-30', 'Brasil', 10, 'ponteira', 1.79),
    (23, 'Andrea Mitrovic', '1999-06-03', 'Canadá', 11, 'ponteira', 1.87),
    (24, 'Drussyla', '1996-07-01', 'Brasil', 15, 'ponteira', 1.84),
    (25, 'Adenízia', '1986-12-18', 'Brasil', 5, 'central', 1.89),
    (26, 'Lara Nobre', '1989-02-11', 'Brasil', 8, 'central', 1.88),
    (27, 'Lanna', '2000-01-04', 'Brasil', 18, 'central', 1.89),
    (28, 'Ana Carolina', '2004-01-01', 'Brasil', 19, 'central', 1.83),
    (29, 'Natinha', '1997-04-10', 'Brasil', 2, 'líbero', 1.62),
    (30, 'Suelen', '1987-10-04', 'Brasil', 17, 'líbero', 1.71)
ON CONFLICT (id) DO NOTHING;

-- Ajustei os inserts para já conter a cidade/ginasio que fizemos no update
INSERT INTO public.partidas (id, data_partida, sets_time, sets_adversario, id_adversario, id_competicao, mando, cidade, ginasio, mvp_externo) VALUES 
    (1, '2026-10-16', 0, 0, 7, 4, 'neutro', 'São Luís do Maranhão', 'Arena Castelinho', 'Tiffany | Osasco'),
    (2, '2026-10-20', 0, 0, 4, 5, 'casa', 'Uberlândia', 'Arena Dentil', NULL),
    (3, '2026-10-24', 0, 0, 1, 5, 'fora', 'Brusque', 'Sesi Brusque', NULL),
    (4, '2026-10-30', 0, 0, 8, 5, 'casa', 'Uberlândia', 'Arena Dentil', NULL),
    (5, '2026-11-07', 0, 0, 3, 5, 'fora', 'Brasília', 'Ginásio Sesi Taguatinga', NULL),
    (6, '2026-11-13', 0, 0, 2, 5, 'casa', 'Uberlândia', 'Arena Dentil', NULL),
    (7, '2026-11-18', 0, 0, 9, 5, 'fora', 'Londrina', 'Ginásio Moringão', NULL),
    (8, '2026-11-24', 0, 0, 5, 5, 'casa', 'Uberlândia', 'Arena Dentil', NULL),
    (9, '2026-11-27', 0, 0, 7, 5, 'casa', 'Uberlândia', 'Arena Dentil', NULL),
    (10, '2026-12-04', 0, 0, 11, 5, 'fora', 'Bauru', 'Arena Paulo Skaf', NULL),
    (11, '2026-12-14', 0, 0, 10, 5, 'fora', 'Rio de Janeiro', 'Ginásio do Tijuca Tênis Clube', NULL),
    (12, '2026-12-21', 0, 0, 6, 5, 'fora', 'Belo Horizonte', 'Arena UniBH', NULL)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.participacoes (id_partida, id_jogadora, ataques, bloqueios, aces, passes_total, passes_positivos, passes_perfeitos, defesas, erros) VALUES 
    (1, 29, 0, 0, 0, 0, 0.00, 0.00, 11, 0),
    (1, 16, 0, 0, 0, 0, 0.00, 0.00, 4, 0),
    (1, 25, 3, 4, 0, 0, 0.00, 0.00, 0, 2),
    (1, 21, 6, 0, 0, 0, 0.00, 0.00, 2, 5),
    (1, 26, 1, 2, 0, 0, 0.00, 0.00, 2, 1),
    (1, 19, 16, 0, 1, 0, 0.00, 0.00, 8, 4),
    (1, 22, 5, 2, 0, 0, 0.00, 0.00, 7, 5),
    (1, 23, 3, 0, 1, 0, 0.00, 0.00, 6, 4),
    (1, 17, 0, 0, 0, 0, 0.00, 0.00, 5, 0),
    (1, 24, 0, 0, 0, 0, 0.00, 0.00, 0, 0),
    (1, 27, 2, 1, 0, 0, 0.00, 0.00, 0, 1)
ON CONFLICT ON CONSTRAINT unique_jogadora_partida DO NOTHING;

-- Ajustando sequências
SELECT setval('competicoes_id_seq', (SELECT COALESCE(MAX(id), 1) FROM competicoes));
SELECT setval('adversarios_id_seq', (SELECT COALESCE(MAX(id), 1) FROM adversarios));
SELECT setval('jogadoras_id_seq', (SELECT COALESCE(MAX(id), 1) FROM jogadoras));
SELECT setval('partidas_id_seq', (SELECT COALESCE(MAX(id), 1) FROM partidas));
SELECT setval('participacoes_id_seq', (SELECT COALESCE(MAX(id), 1) FROM participacoes));
