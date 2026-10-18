-- ==========================================
-- 02_gatilhos_e_queries.sql: AUTOMAÇÕES E CONSULTAS
-- ==========================================

-- 1. Função: Preencher automaticamente cidade e ginásio
CREATE OR REPLACE FUNCTION public.auto_preencher_partida() 
RETURNS trigger AS $$ 
DECLARE
    adv_cidade VARCHAR;
    adv_ginasio VARCHAR;
BEGIN
    IF NEW.mando = 'casa' THEN
        IF NEW.cidade IS NULL OR NEW.cidade = '' THEN
            NEW.cidade := 'Uberlândia';
        END IF;
        IF NEW.ginasio IS NULL OR NEW.ginasio = '' THEN
            NEW.ginasio := 'Arena Dentil';
        END IF;
        
    ELSIF NEW.mando = 'fora' THEN
        SELECT cidade, ginasio INTO adv_cidade, adv_ginasio 
        FROM public.adversarios 
        WHERE id = NEW.id_adversario;

        IF NEW.cidade IS NULL OR NEW.cidade = '' THEN
            NEW.cidade := adv_cidade;
        END IF;
        
        IF NEW.ginasio IS NULL OR NEW.ginasio = '' THEN
            NEW.ginasio := adv_ginasio;
        END IF;
    END IF;
    
    RETURN NEW;
END; 
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_auto_preencher_partida ON public.partidas;
CREATE TRIGGER trg_auto_preencher_partida 
BEFORE INSERT OR UPDATE ON public.partidas 
FOR EACH ROW EXECUTE FUNCTION public.auto_preencher_partida();


-- 2. Função: Atualizar timestamp (atualizado_em)
CREATE OR REPLACE FUNCTION public.atualiza_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.atualizado_em = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_timestamp_partidas ON public.partidas;
CREATE TRIGGER trg_timestamp_partidas
BEFORE UPDATE ON public.partidas
FOR EACH ROW EXECUTE FUNCTION public.atualiza_timestamp();

DROP TRIGGER IF EXISTS trg_timestamp_participacoes ON public.participacoes;
CREATE TRIGGER trg_timestamp_participacoes
BEFORE UPDATE ON public.participacoes
FOR EACH ROW EXECUTE FUNCTION public.atualiza_timestamp();


-- ==========================================
-- CONSULTAS (QUERIES) ÚTEIS
-- ==========================================

-- Query: Maiores Pontuadoras do Time
/*
SELECT 
    j.nome AS "Jogadora",
    j.posicao AS "Posição",
    SUM(p.pontos) AS "Total de Pontos",
    SUM(p.ataques) AS "Pontos de Ataque",
    SUM(p.bloqueios) AS "Pontos de Bloqueio",
    SUM(p.aces) AS "Aces"
FROM 
    public.jogadoras j
JOIN 
    public.participacoes p ON j.id = p.id_jogadora
GROUP BY 
    j.id, j.nome, j.posicao
ORDER BY 
    "Total de Pontos" DESC;
*/
