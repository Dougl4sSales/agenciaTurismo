-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public."Pacote"
(
    codigo serial NOT NULL,
    valor double precision,
    data_ini date,
    data_fim date,
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS public."Visita"
(
    codigo serial NOT NULL,
    nome character varying(63),
    endereco character varying(127),
    hora_ini time,
    hora_fim time,
    tipo_visita integer,
    codigo_cidade integer,
    PRIMARY KEY (codigo),
    codigo_hotel integer
);

CREATE TABLE IF NOT EXISTS public."Cidade"
(
    codigo serial NOT NULL,
    nome character varying(63),
    descricao character varying (300),
    estado character varying(63),
    populacao integer,
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS public."Hotel"
(
    categoria character varying(63),
    codigo_visita integer unique,
    nome character varying(63),
    descricao character varying(300)
);

CREATE TABLE IF NOT EXISTS public."Restaurante"
(
    codigo serial NOT NULL,
    nome character varying(63),
    especialidade character varying(63),
    preco_medio double precision,
    categoria character varying(63),
    codigo_visita integer unique,
    hotel_associado integer,
    casa_de_show_associada integer,
    descricao character varying(300)
);

CREATE TABLE IF NOT EXISTS public."Quarto"
(
    codigo serial NOT NULL,
    nome character varying(63),
    valor double precision,
    tipo character varying(63),
    PRIMARY KEY (codigo_hotel)
);

CREATE TABLE IF NOT EXISTS public."Casa de Show"
(
    hora_ini time without time zone,
    hora_fim time without time zone,
    dia_fecha character varying(15),
    codigo_pontoturistico integer unique,
    nome character varying(63)
);

CREATE TABLE IF NOT EXISTS public."Ponto Turistico"
(
    codigo serial NOT NULL,
    descricao character varying(300),
    codigo_visita integer unique,
    PRIMARY KEY (codigo),
    nome character varying(63)
);

CREATE TABLE IF NOT EXISTS public."Museu"
(
    data_funda date,
    n_salas integer,
    codigo_pontoturistico integer,
    codigo_fundador integer
);

CREATE TABLE IF NOT EXISTS public."Fundador"
(
    codigo serial NOT NULL,
    nome character varying(127),
    data_nasc date,
    data_obito date,
    trabalho character varying(63),
    nacionalidade character varying(63),
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS public."Igreja"
(
    data_const date,
    estilo character varying(63),
    codigo_pontoturistico integer unique
);

CREATE TABLE IF NOT EXISTS public."Cliente"
(
    codigo serial NOT NULL,
    nome character varying(127),
    email character varying (255) unique,
    senha_hash character varying (255),
    endereco character varying(127),
    fone character varying(15),
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS public."Pessoa Fisica"
(
    cpf character varying(15) NOT NULL,
    codigo_cliente integer,
    PRIMARY KEY (cpf)
);

CREATE TABLE IF NOT EXISTS public."Pessoa Juridica"
(
    cnpj character varying(31) NOT NULL,
    codigo_cliente integer,
    PRIMARY KEY (cnpj)
);

CREATE TABLE IF NOT EXISTS public."Tipo Visita"
(
    codigo serial NOT NULL,
    nome character varying(63),
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS public."Cliente_Pacote"
(
    "Cliente_codigo" serial NOT NULL,
    "Pacote_codigo" serial NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Pacote_Visita"
(
    "Pacote_codigo" serial NOT NULL,
    "Visita_codigo" serial NOT NULL,
    "datahora_ini" timestamp WITHOUT time zone,
    "datahora_fim" timestamp WITHOUT time zone
);

ALTER TABLE IF EXISTS public."Visita"
    ADD FOREIGN KEY (tipo_visita)
    REFERENCES public."Tipo Visita" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Visita"
    ADD FOREIGN KEY (codigo_cidade)
    REFERENCES public."Cidade" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Hotel"
    ADD FOREIGN KEY (codigo_visita)
    REFERENCES public."Visita" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Restaurante"
    ADD FOREIGN KEY (codigo_visita)
    REFERENCES public."Visita" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Restaurante"
    ADD FOREIGN KEY (hotel_associado)
    REFERENCES public."Hotel" (codigo_visita) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Restaurante"
    ADD FOREIGN KEY (casa_de_show_associada)
    REFERENCES public."Casa de Show" (codigo_pontoturistico) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Quarto"
    ADD FOREIGN KEY (codigo_hotel)
    REFERENCES public."Hotel" (codigo_visita) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Casa de Show"
    ADD FOREIGN KEY (codigo_pontoturistico)
    REFERENCES public."Ponto Turistico" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Ponto Turistico"
    ADD FOREIGN KEY (codigo_visita)
    REFERENCES public."Visita" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Museu"
    ADD FOREIGN KEY (codigo_pontoturistico)
    REFERENCES public."Ponto Turistico" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Museu"
    ADD FOREIGN KEY (codigo_fundador)
    REFERENCES public."Fundador" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Igreja"
    ADD FOREIGN KEY (codigo_pontoturistico)
    REFERENCES public."Ponto Turistico" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Pessoa Fisica"
    ADD FOREIGN KEY (codigo_cliente)
    REFERENCES public."Cliente" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Pessoa Juridica"
    ADD FOREIGN KEY (codigo_cliente)
    REFERENCES public."Cliente" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Cliente_Pacote"
    ADD FOREIGN KEY ("Pacote_codigo")
    REFERENCES public."Pacote" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Cliente_Pacote"
    ADD FOREIGN KEY ("Cliente_codigo")
    REFERENCES public."Cliente" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Pacote_Visita"
    ADD FOREIGN KEY ("Pacote_codigo")
    REFERENCES public."Pacote" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public."Pacote_Visita"
    ADD FOREIGN KEY ("Visita_codigo")
    REFERENCES public."Visita" (codigo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;



-- Correção na tabela Hotel
-- Adicionar a coluna 'codigo' que está faltando na tabela "Hotel"
ALTER TABLE public."Hotel"
ADD COLUMN codigo serial PRIMARY KEY;

-- Correções nas tabelas de associação
-- Alterar o tipo das colunas 'Cliente_codigo' e 'Pacote_codigo' para integer em vez de serial
ALTER TABLE public."Cliente_Pacote"
ALTER COLUMN "Cliente_codigo" TYPE integer,
ALTER COLUMN "Pacote_codigo" TYPE integer;

ALTER TABLE public."Pacote_Visita"
ALTER COLUMN "Pacote_codigo" TYPE integer,
ALTER COLUMN "Visita_codigo" TYPE integer;

-- Correção no nome da função de validação de CPF
-- Não é necessária uma correção de código aqui, somente certifique-se de que a função chamada na trigger é a que você definiu anteriormente.
-- Apenas certifique-se de que a chamada da função esteja correta em suas triggers.



-- Adicionando suporte para imagem na tabela "Cidade"
ALTER TABLE public."Cidade"
ADD imagem bytea;

-- Adicionando suporte para imagem na tabela "Ponto Turistico"
ALTER TABLE public."Ponto Turistico"
ADD imagem bytea;

-- Adicionando suporte para imagem na tabela "Hotel"
ALTER TABLE public."Hotel"
ADD imagem bytea;

-- Adicionando suporte para imagem na tabela "Restaurante"
ALTER TABLE public."Restaurante"
ADD imagem bytea;

-- Criação da Tabela Carrinho
CREATE TABLE Carrinho (
    codigo SERIAL PRIMARY KEY,
    codigo_cliente INTEGER REFERENCES Cliente(codigo)
);

-- Criação da Tabela Carrinho_Pacote para associar pacotes ao carrinho
CREATE TABLE Carrinho_Pacote (
    carrinho_codigo INTEGER REFERENCES Carrinho(codigo),
    pacote_codigo INTEGER REFERENCES Pacote(codigo),
    PRIMARY KEY (carrinho_codigo, pacote_codigo)
);



-------- Gatilhos ---------

-- CPF EXISTENTE
-----------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_verify_cpf_exists()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM "Pessoa Fisica" WHERE cpf = NEW.cpf) THEN
        RAISE EXCEPTION 'CPF % já existe', NEW.cpf;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cpf_existe
BEFORE INSERT OR UPDATE ON "Pessoa Fisica"
FOR EACH ROW
EXECUTE PROCEDURE fn_verify_cpf_exists();


-- Função para calcular se o CPF é válido.
-----------------------------------------------------------
CREATE OR REPLACE FUNCTION VALIDA_CPF(pcpf CHAR(11))
RETURNS BOOLEAN AS
$$
DECLARE
    soma INT;
    resto INT;
    digito1 INT;
    digito2 INT;
    i INT;
BEGIN
    -- Cálculo do primeiro dígito verificador
    soma := 0;
    FOR i IN 1..9 LOOP
        soma := soma + CAST(SUBSTRING(pcpf FROM i FOR 1) AS INT) * (11 - i);
    END LOOP;
    
    resto := soma % 11;
    IF resto < 2 THEN
        digito1 := 0;
    ELSE
        digito1 := 11 - resto;
    END IF;

    -- Cálculo do segundo dígito verificador
    soma := 0;
    FOR i IN 1..9 LOOP
        soma := soma + CAST(SUBSTRING(pcpf FROM i FOR 1) AS INT) * (12 - i);
    END LOOP;
    soma := soma + digito1 * 2; -- Adiciona o primeiro dígito verificador multiplicado por 2
    
    resto := soma % 11;
    IF resto < 2 THEN
        digito2 := 0;
    ELSE
        digito2 := 11 - resto;
    END IF;

    -- Verifica se os dígitos calculados são iguais aos fornecidos
    IF digito1 = CAST(SUBSTRING(pcpf FROM 10 FOR 1) AS INT) AND digito2 = CAST(SUBSTRING(pcpf FROM 11 FOR 1) AS INT) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION VERIFICA_CPF() RETURNS TRIGGER AS
$$
BEGIN
	IF(NOT VALIDA_CPF(NEW.cpf)) THEN
		RAISE EXCEPTION 'CPF inválido';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER VERIFICA_CPF
BEFORE INSERT OR UPDATE ON "Pessoa Fisica"
FOR EACH ROW
EXECUTE PROCEDURE VERIFICA_CPF();


-- CNPJ VALIDO
-----------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_verify_cnpj_valid()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se o CNPJ tem 14 caracteres
    IF LENGTH(NEW.cnpj) != 14 THEN
        RAISE EXCEPTION 'Tamanho Inválido: %', NEW.cnpj;
    END IF;

    -- Verifica se o CNPJ contém apenas números
    IF NEW.cnpj !~ '^[0-9]+$' THEN
        RAISE EXCEPTION 'CNPJ deve conter apenas números: %', NEW.cnpj;
    END IF;

    -- Verifica se o CNPJ termina com "0001"
    IF RIGHT(NEW.cnpj, 4) != '0001' THEN
        RAISE EXCEPTION 'CNPJ deve terminar em 0001: %', NEW.cnpj;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cnpj_valido
BEFORE INSERT OR UPDATE ON "Pessoa Juridica"
FOR EACH ROW
EXECUTE PROCEDURE fn_verify_cnpj_valid();


-- DATA INICIO DO PACOTE ANTES DA DATA FIM
-----------------------------------------------------------

CREATE OR REPLACE FUNCTION data_antes_de_fim()
RETURNS TRIGGER AS $$
BEGIN
	IF (NEW.DATAHORA_INI < NEW.DATAHORA_FIM) THEN
		RETURN NEW;
	ELSE
		RAISE EXCEPTION 'A data de fim do pacote não pode ser antes do início';
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER datahora_pacote_compara
BEFORE INSERT OR UPDATE ON "Pacote_Visita"
FOR EACH ROW
EXECUTE PROCEDURE data_antes_de_fim();
