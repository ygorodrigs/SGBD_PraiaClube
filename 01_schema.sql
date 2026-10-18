-- ==========================================
-- 01_schema.sql: ESTRUTURA DAS TABELAS E RLS
-- ==========================================

-- Tabela de Competições
CREATE TABLE IF NOT EXISTS public.competicoes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de Adversários
CREATE TABLE IF NOT EXISTS public.adversarios (
    id SERIAL PRIMARY KEY,
    time VARCHAR(50) NOT NULL,
    nivel VARCHAR(20) NOT NULL,
    estado VARCHAR(2),
    cidade VARCHAR(50),
    ginasio VARCHAR(100)
);

-- Tabela de Jogadoras
CREATE TABLE IF NOT EXISTS public.jogadoras (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    data_nasc DATE NOT NULL,
    nacionalidade VARCHAR(20) NOT NULL,
    numero_camisa INT NOT NULL,
    posicao VARCHAR(20) NOT NULL,
    altura FLOAT NOT NULL,
    CONSTRAINT check_posicao CHECK (posicao IN ('levantadora', 'ponteira', 'oposta', 'líbero', 'central'))
);

-- Tabela de Partidas
CREATE TABLE IF NOT EXISTS public.partidas (
    id SERIAL PRIMARY KEY,
    data_partida DATE NOT NULL,
    sets_time INT NOT NULL DEFAULT 0,
    sets_adversario INT NOT NULL DEFAULT 0,
    id_adversario INT NOT NULL REFERENCES public.adversarios(id),
    id_competicao INT NOT NULL REFERENCES public.competicoes(id),
    mando VARCHAR(10) NOT NULL,
    id_mvp INT REFERENCES public.jogadoras(id),
    cidade VARCHAR(50),
    ginasio VARCHAR(100),
    mvp_externo VARCHAR(100),
    atualizado_em TIMESTAMP DEFAULT NOW(),
    
    CONSTRAINT partidas_mando_check CHECK (mando IN ('casa', 'fora', 'neutro')),
    CONSTRAINT valida_placar_volei CHECK (
        (sets_time = 0 AND sets_adversario = 0) OR
        (sets_time = 3 AND sets_adversario IN (0, 1, 2)) OR
        (sets_adversario = 3 AND sets_time IN (0, 1, 2))
    )
);

-- Tabela de Participações
CREATE TABLE IF NOT EXISTS public.participacoes (
    id SERIAL PRIMARY KEY,
    id_partida INT NOT NULL REFERENCES public.partidas(id) ON DELETE CASCADE,
    id_jogadora INT NOT NULL REFERENCES public.jogadoras(id) ON DELETE CASCADE,
    ataques INT DEFAULT 0,
    bloqueios INT DEFAULT 0,
    aces INT DEFAULT 0,
    passes_total INT DEFAULT 0,
    passes_positivos NUMERIC(5,2) DEFAULT 0.00,
    passes_perfeitos NUMERIC(5,2) DEFAULT 0.00,
    defesas INT DEFAULT 0,
    erros INT DEFAULT 0,
    atualizado_em TIMESTAMP DEFAULT NOW(),
    pontos INT GENERATED ALWAYS AS (COALESCE(ataques, 0) + COALESCE(bloqueios, 0) + COALESCE(aces, 0)) STORED,
    CONSTRAINT unique_jogadora_partida UNIQUE (id_partida, id_jogadora)
);

-- Habilitar Row Level Security (RLS)
ALTER TABLE public.competicoes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.adversarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.jogadoras ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.partidas ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.participacoes ENABLE ROW LEVEL SECURITY;
