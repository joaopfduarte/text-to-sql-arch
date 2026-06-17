-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql.juninho.com.br:3306
-- Generation Time: Jun 11, 2026 at 01:46 AM
-- Server version: 8.0.46-0ubuntu0.24.04.2
-- PHP Version: 8.2.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `putz`
--
CREATE DATABASE IF NOT EXISTS `putz` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `putz`;

-- --------------------------------------------------------

--
-- Table structure for table `asset_category`
--

CREATE TABLE `asset_category` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `root_category_id` bigint DEFAULT NULL,
  `category_type` varchar(64) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_public` bit(1) DEFAULT b'0',
  `is_active` bit(1) DEFAULT b'1',
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_category__users`
--

CREATE TABLE `asset_category__users` (
  `categories_id` bigint NOT NULL,
  `person_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_item`
--

CREATE TABLE `asset_item` (
  `id` bigint NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lettering` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `small_description` varchar(128) NOT NULL,
  `phonetic` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `item_order` int NOT NULL DEFAULT '0',
  `slug` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `video_check_status` enum('CHECKED','NOT_CHECKED','AUTOCHECKED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'AUTOCHECKED',
  `json_data` varchar(2048) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `resource_url` varchar(512) DEFAULT NULL,
  `resource_type` enum('LETTERING','VIDEO','AUDIO','IMAGE','COMPANY') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Assets Genéricos para Vïdeos';

-- --------------------------------------------------------

--
-- Table structure for table `asset_item__categories`
--

CREATE TABLE `asset_item__categories` (
  `category_id` bigint NOT NULL,
  `asset_item_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_item__voice_overs`
--

CREATE TABLE `asset_item__voice_overs` (
  `voice_overs_id` bigint NOT NULL,
  `asset_item_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_retail_product`
--

CREATE TABLE `asset_retail_product` (
  `id` bigint NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `small_description` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Seria Lettering',
  `phonetic` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `slug` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `json_data` varchar(2048) DEFAULT NULL,
  `default_unit_id` bigint NOT NULL,
  `default_supplier_id` bigint DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `resource_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `resource_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `scene_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Produtos de Varejo\\n@author [redacted]';

-- --------------------------------------------------------

--
-- Table structure for table `asset_retail_product__categories`
--

CREATE TABLE `asset_retail_product__categories` (
  `categories_id` bigint NOT NULL,
  `asset_retail_product_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_retail_product__voice_overs`
--

CREATE TABLE `asset_retail_product__voice_overs` (
  `voice_overs_id` bigint NOT NULL,
  `asset_retail_product_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_retail_supplier`
--

CREATE TABLE `asset_retail_supplier` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `phonetic` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `image_alt_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_retail_unit`
--

CREATE TABLE `asset_retail_unit` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `lettering` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` bit(1) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Unidades pra um Produto de Varejo\\n@author [redacted]';

-- --------------------------------------------------------

--
-- Table structure for table `asset_startup`
--

CREATE TABLE `asset_startup` (
  `id` bigint NOT NULL,
  `appearance_id` varchar(128) DEFAULT NULL,
  `pitch_deck_url` varchar(512) DEFAULT NULL,
  `track` varchar(64) DEFAULT NULL,
  `company_id` varchar(128) DEFAULT NULL,
  `company_name` varchar(128) NOT NULL,
  `elevator_pitch` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `country_name` varchar(64) NOT NULL,
  `logo_url` varchar(512) DEFAULT NULL,
  `homepage_url` varchar(128) DEFAULT NULL,
  `instagram_url` varchar(512) DEFAULT NULL,
  `linkedin_url` varchar(512) DEFAULT NULL,
  `facebook_url` varchar(512) DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `industry_id` varchar(128) DEFAULT NULL,
  `industry_name` varchar(128) DEFAULT NULL,
  `stand_number` varchar(64) DEFAULT NULL,
  `time_json` varchar(255) DEFAULT NULL,
  `team_1_id` varchar(512) DEFAULT NULL,
  `team_1_name` varchar(512) DEFAULT NULL,
  `team_1_avatar` varchar(512) DEFAULT NULL,
  `team_1_job` varchar(512) DEFAULT NULL,
  `team_2_id` varchar(512) DEFAULT NULL,
  `team_2_name` varchar(512) DEFAULT NULL,
  `team_2_avatar` varchar(512) DEFAULT NULL,
  `team_2_job` varchar(128) DEFAULT NULL,
  `team_3_id` varchar(512) DEFAULT NULL,
  `team_3_name` varchar(512) DEFAULT NULL,
  `team_3_avatar` varchar(512) DEFAULT NULL,
  `team_3_job` varchar(128) DEFAULT NULL,
  `team_4_id` varchar(128) DEFAULT NULL,
  `team_4_name` varchar(128) DEFAULT NULL,
  `team_4_avatar` varchar(512) DEFAULT NULL,
  `team_4_job` varchar(128) DEFAULT NULL,
  `team_5_id` varchar(128) DEFAULT NULL,
  `team_5_name` varchar(128) DEFAULT NULL,
  `team_5_avatar` varchar(512) DEFAULT NULL,
  `team_5_job` varchar(128) DEFAULT NULL,
  `team_6_id` varchar(128) DEFAULT NULL,
  `team_6_name` varchar(128) DEFAULT NULL,
  `team_6_avatar` varchar(512) DEFAULT NULL,
  `team_6_job` varchar(128) DEFAULT NULL,
  `team_7_id` varchar(128) DEFAULT NULL,
  `team_7_name` varchar(128) DEFAULT NULL,
  `team_7_avatar` varchar(512) DEFAULT NULL,
  `team_7_job` varchar(128) DEFAULT NULL,
  `is_active` bit(1) DEFAULT b'1',
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_voice_speaker`
--

CREATE TABLE `asset_voice_speaker` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(32) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `eleven_labs_id` varchar(64) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `asset_voice_voiceover`
--

CREATE TABLE `asset_voice_voiceover` (
  `id` bigint NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(2048) DEFAULT NULL,
  `slug` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `speaker_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `phonetic` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `voiceover_time` decimal(6,2) DEFAULT NULL,
  `voiceover_time_raw` decimal(6,2) DEFAULT NULL,
  `voiceover_time_type` int DEFAULT NULL,
  `voiceover_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `audiobitrate` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `competence`
--

CREATE TABLE `competence` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `icon_url` varchar(128) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Start Portfolio Pack';

-- --------------------------------------------------------

--
-- Table structure for table `competence_guide`
--

CREATE TABLE `competence_guide` (
  `id` bigint NOT NULL,
  `competence_id` bigint NOT NULL,
  `level` enum('BANK','JUNIOR','PROFISSIONAL','ADVANCED','COPYRIGHT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `slug` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `mark_down` longblob,
  `html_page` longblob,
  `file_link` varchar(512) DEFAULT NULL,
  `file` longblob,
  `file_content_type` varchar(255) DEFAULT NULL,
  `is_active` bit(1) DEFAULT b'1',
  `is_verified` bit(1) DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `config_params`
--

CREATE TABLE `config_params` (
  `id` bigint NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `slug` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `config_params_type` enum('TWILIO_NUMBER','EMAIL','PROJECT_INSURANCE','PROJECT_PAYMENT','PROJECT_PROFIT_TARGET','OTHER','PROJECT_PRIORITY','RENDER_BOT','PROJECT_REBATE','TRIBUTES','MAX_COMMISSION','TWILIO_ACCOUNT_SID','TWILIO_AUTH_TOKEN','FREE_SOURCES','WHATSAPP_ALERTS') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `json_value` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='End Project Pack';

-- --------------------------------------------------------

--
-- Table structure for table `DATABASECHANGELOG`
--

CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias`
--

CREATE TABLE `franquias` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `nome_fantasia` varchar(255) DEFAULT NULL,
  `razao_social` varchar(255) DEFAULT NULL,
  `segmento_id` int DEFAULT NULL,
  `rede_id` int DEFAULT NULL,
  `data_coleta` datetime DEFAULT NULL,
  `ultima_atualizacao` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__expansao_interesse`
--

CREATE TABLE `franquias__expansao_interesse` (
  `id` int NOT NULL,
  `franquia_id` int DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `prioridade` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__investimentos_franquia`
--

CREATE TABLE `franquias__investimentos_franquia` (
  `id` int NOT NULL,
  `franquia_id` int DEFAULT NULL,
  `tipo_investimento` varchar(100) DEFAULT NULL,
  `valor_minimo` decimal(12,2) DEFAULT NULL,
  `valor_maximo` decimal(12,2) DEFAULT NULL,
  `descricao` text,
  `data_atualizacao` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__premiacoes`
--

CREATE TABLE `franquias__premiacoes` (
  `id` int NOT NULL,
  `franquia_id` int DEFAULT NULL,
  `nome_premiacao` varchar(255) DEFAULT NULL,
  `instituicao` varchar(255) DEFAULT NULL,
  `ano` int DEFAULT NULL,
  `categoria` varchar(255) DEFAULT NULL,
  `colocacao` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__redes_franquia`
--

CREATE TABLE `franquias__redes_franquia` (
  `id` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(14) DEFAULT NULL,
  `ano_fundacao` int DEFAULT NULL,
  `ano_inicio_franchising` int DEFAULT NULL,
  `site_oficial` varchar(255) DEFAULT NULL,
  `descricao` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__redes_sociais`
--

CREATE TABLE `franquias__redes_sociais` (
  `id` int NOT NULL,
  `franquia_id` int DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `usuario` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__requisitos_franquia`
--

CREATE TABLE `franquias__requisitos_franquia` (
  `id` int NOT NULL,
  `franquia_id` int DEFAULT NULL,
  `area_minima` int DEFAULT NULL,
  `area_maxima` int DEFAULT NULL,
  `quantidade_minima_funcionarios` int DEFAULT NULL,
  `experiencia_previa` tinyint(1) DEFAULT NULL,
  `exclusividade` tinyint(1) DEFAULT NULL,
  `prazo_contrato` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__segmentos`
--

CREATE TABLE `franquias__segmentos` (
  `id` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__sub_segmentos`
--

CREATE TABLE `franquias__sub_segmentos` (
  `id` int NOT NULL,
  `segmento_id` int DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__taxas_franquia`
--

CREATE TABLE `franquias__taxas_franquia` (
  `id` int NOT NULL,
  `franquia_id` int DEFAULT NULL,
  `taxa_franquia` decimal(10,2) DEFAULT NULL,
  `royalties_percentual` decimal(5,2) DEFAULT NULL,
  `royalties_valor` decimal(10,2) DEFAULT NULL,
  `taxa_publicidade_percentual` decimal(5,2) DEFAULT NULL,
  `taxa_publicidade_valor` decimal(10,2) DEFAULT NULL,
  `outras_taxas` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `franquias__unidades`
--

CREATE TABLE `franquias__unidades` (
  `id` int NOT NULL,
  `franquia_id` int DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `data_inauguracao` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `ibge_names_and_frequency`
-- (See below for the actual view)
--
CREATE TABLE `ibge_names_and_frequency` (
`f_female` decimal(32,0)
,`f_frequency` int
,`f_male` decimal(32,0)
,`first_name` varchar(22)
,`gender` varchar(1)
,`ratio` decimal(36,4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ibge_name_group_sum`
-- (See below for the actual view)
--
CREATE TABLE `ibge_name_group_sum` (
`frequency_female` decimal(32,0)
,`frequency_male` decimal(32,0)
,`frequency_total` decimal(32,0)
,`gender` varchar(1)
,`id` bigint
,`name` varchar(22)
,`names` text
,`ratio` decimal(36,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `ibge__city`
--

CREATE TABLE `ibge__city` (
  `id` bigint NOT NULL COMMENT 'ibge_id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `is_capital` tinyint(1) NOT NULL,
  `uf_id` bigint NOT NULL,
  `siafi_id` varchar(4) NOT NULL,
  `ddd` int NOT NULL,
  `time_zone` varchar(32) NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ibge__name`
--

CREATE TABLE `ibge__name` (
  `id` bigint NOT NULL,
  `first_name` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `classification` enum('M','F','N','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `frequency_female` int DEFAULT NULL,
  `frequency_male` int DEFAULT NULL,
  `frequency_total` int DEFAULT NULL,
  `name_group_id_calc` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `name_group_id` bigint DEFAULT NULL,
  `is_perfect_group` bit(1) NOT NULL DEFAULT b'0',
  `is_name_checked` bit(1) DEFAULT NULL COMMENT 'Se nome já foi checado',
  `frequency_group` int DEFAULT NULL,
  `request_counter` int UNSIGNED NOT NULL DEFAULT '0',
  `name_type` enum('NAME','SURNAME','NICKNAME') DEFAULT 'NAME',
  `ratio` double(5,3) NOT NULL DEFAULT '0.000',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ibge__name_frequency`
--

CREATE TABLE `ibge__name_frequency` (
  `id` bigint NOT NULL,
  `name_id` bigint NOT NULL,
  `name_id_calc` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` enum('M','F','N','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `uf_id` bigint NOT NULL,
  `f_frequency` int NOT NULL DEFAULT '-1' COMMENT 'Frenquencia Basica da API',
  `f_rank` int NOT NULL DEFAULT '-1' COMMENT 'ranking pelo IBGE',
  `f_total` int NOT NULL COMMENT 'Soma dos F_Decadas',
  `f_1930` int UNSIGNED NOT NULL,
  `f_19301940` int UNSIGNED NOT NULL,
  `f_19401950` int UNSIGNED NOT NULL,
  `f_19501960` int UNSIGNED NOT NULL,
  `f_19601970` int UNSIGNED NOT NULL,
  `f_19701980` int UNSIGNED NOT NULL,
  `f_19801990` int UNSIGNED NOT NULL,
  `f_19902000` int UNSIGNED NOT NULL,
  `f_20002010` int UNSIGNED NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_modified_date` datetime DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ibge__name_group`
--

CREATE TABLE `ibge__name_group` (
  `id` bigint NOT NULL,
  `name` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phonetic` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `group_type` enum('MAIN','EXTRA','OLD') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'EXTRA',
  `classification` enum('M','F','N','O') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `frequency_female` int NOT NULL,
  `frequency_male` int NOT NULL,
  `frequency_total` int NOT NULL,
  `ratio` double(9,3) NOT NULL,
  `names` varchar(7000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ibge__name_render`
--

CREATE TABLE `ibge__name_render` (
  `id` bigint NOT NULL,
  `name` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `project_render_id` bigint NOT NULL,
  `counter` int NOT NULL,
  `ibge_name_id` bigint DEFAULT NULL,
  `ibge_name_id_calc` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ibge__uf`
--

CREATE TABLE `ibge__uf` (
  `id` bigint NOT NULL,
  `uf` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_ibge` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `region` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_whatsapp`
--

CREATE TABLE `notification_whatsapp` (
  `id` bigint UNSIGNED NOT NULL,
  `putz_hash` varchar(64) DEFAULT NULL,
  `sid` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `notification_direction` varchar(32) DEFAULT NULL,
  `phone_from` varchar(64) DEFAULT NULL,
  `phone_to` varchar(64) DEFAULT NULL,
  `reference` varchar(64) DEFAULT NULL,
  `reference_chatbot` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `notification_type` varchar(32) DEFAULT NULL,
  `answer` varchar(1024) DEFAULT NULL,
  `reply` varchar(1024) DEFAULT NULL,
  `whatsapp_msg_type` varchar(64) DEFAULT NULL,
  `error_message` varchar(128) DEFAULT NULL,
  `error_code` int DEFAULT NULL,
  `price_unit` varchar(32) DEFAULT NULL,
  `price` varchar(32) DEFAULT NULL,
  `uri` varchar(128) DEFAULT NULL,
  `account_sid` varchar(64) DEFAULT NULL,
  `notification_status` varchar(32) DEFAULT NULL,
  `messaging_service_sid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `api_version` varchar(16) DEFAULT NULL,
  `media_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `date_scheduled` datetime(6) DEFAULT NULL,
  `date_queued` datetime(6) DEFAULT NULL,
  `date_sent` datetime(6) DEFAULT NULL,
  `date_failed` datetime(6) DEFAULT NULL,
  `date_delivered` datetime(6) DEFAULT NULL,
  `date_read` datetime(6) DEFAULT NULL,
  `date_answer` datetime(6) DEFAULT NULL,
  `date_updated` datetime(6) DEFAULT NULL,
  `person_id` bigint DEFAULT NULL,
  `data_source` longtext,
  `time_line_event_id` bigint DEFAULT NULL,
  `project_render_item_id` bigint DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL COMMENT 'Removed?',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL,
  `retry_count` int DEFAULT '0',
  `last_attempt_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openai_assistants`
--

CREATE TABLE `openai_assistants` (
  `id` bigint NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `slug` varchar(64) NOT NULL,
  `assistants_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(64) DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `top_p` double DEFAULT NULL,
  `max_output_tokens` bigint DEFAULT NULL,
  `response_schema` json DEFAULT NULL,
  `instruction` longtext NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `openai_conclusions`
--

CREATE TABLE `openai_conclusions` (
  `id` bigint NOT NULL,
  `sid` varchar(128) NOT NULL,
  `openai_function` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ask` text NOT NULL,
  `slug` varchar(128) NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `user_id` bigint NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `json_conclusion` json DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `last_modified_by` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `page_faq`
--

CREATE TABLE `page_faq` (
  `id` bigint UNSIGNED NOT NULL,
  `ask` varchar(512) DEFAULT NULL,
  `slug` varchar(64) NOT NULL,
  `answer` varchar(8000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `item_index` int DEFAULT NULL,
  `page_type` varchar(64) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL COMMENT 'Removed?',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `slug` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Remover',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Remover',
  `current_balance` double DEFAULT '0',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `company_id` bigint DEFAULT NULL,
  `company_type` varchar(64) DEFAULT 'OTHER',
  `name_fantasy` varchar(512) DEFAULT NULL,
  `cpf_cnpj` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `rg_doc` varchar(64) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `lastaccess` datetime(6) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `avatar_content_type` varchar(255) DEFAULT NULL,
  `person_type` varchar(255) DEFAULT NULL,
  `gender` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `pix_key` varchar(128) DEFAULT NULL,
  `pix_key_type` varchar(32) DEFAULT NULL,
  `thread_id` varchar(128) DEFAULT NULL,
  `active_chat` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Chatbottwillio ativo',
  `instruction_openai` varchar(2048) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `phone_cel` varchar(16) DEFAULT NULL,
  `phone_whatsapp` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_whatsapp_verification` datetime DEFAULT NULL,
  `address_zip_code` varchar(10) DEFAULT NULL,
  `address_location` varchar(128) DEFAULT NULL,
  `address_number` varchar(10) DEFAULT NULL,
  `address_complement` varchar(64) DEFAULT NULL,
  `address_district` varchar(64) DEFAULT NULL,
  `address_city` varchar(64) DEFAULT NULL,
  `address_uf` varchar(255) DEFAULT NULL,
  `address_country` varchar(255) DEFAULT NULL,
  `social_linkedin` varchar(64) DEFAULT NULL,
  `social_web` varchar(255) DEFAULT NULL,
  `social_instagram` varchar(64) DEFAULT NULL,
  `social_pinterest` varchar(64) DEFAULT NULL,
  `reference` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `commission` double NOT NULL DEFAULT '0',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `person_references`
--

CREATE TABLE `person_references` (
  `id` bigint NOT NULL,
  `person_id` bigint NOT NULL,
  `reference_name` enum('FACEBOOK','LINKEDIN','FACEBOOK_PAGES','GITHUB','GOOGLE_LOGIN','DINAMIZE_ID','FACEBOOK_LOGIN','LYTEX_ID','RD_ID','LINKEDIN_PAGES','GITHUB_LOGIN','TWITTER_LOGIN','APPLE_ID','SMART_CODE','REFERENCE_PERSON_ID','RD_OPPORTUNITY_ID','RD_CLIENT_ID','RD_CONTACT_ID','RD_USER_ID','FACEBOOK_DEFAULT','LINKEDIN_DEFAULT','INSTAGRAM_DEFAULT','MANDATORY_ASSETS_MISSING') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reference_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reference_extra` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portfolio`
--

CREATE TABLE `portfolio` (
  `id` bigint NOT NULL,
  `person_id` bigint DEFAULT NULL,
  `competence_id` bigint DEFAULT NULL,
  `level` enum('BANK','JUNIOR','PROFISSIONAL','ADVANCED','COPYRIGHT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `rank_agility` int DEFAULT '0',
  `rank_creativity` int DEFAULT '0',
  `rank_deadline` int DEFAULT '0',
  `rank_quality` int DEFAULT '0',
  `rank_remaking` int DEFAULT '0',
  `file_link` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `file` longblob,
  `file_content_type` varchar(255) DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `request_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'SUBSCRIBED',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portfolio__tags`
--

CREATE TABLE `portfolio__tags` (
  `tags_id` bigint NOT NULL,
  `portfolio_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` bigint NOT NULL,
  `product_type_id` bigint NOT NULL,
  `rd_id` varchar(128) DEFAULT NULL,
  `level` enum('BANK','JUNIOR','PROFISSIONAL','ADVANCED','COPYRIGHT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_competence`
--

CREATE TABLE `product_competence` (
  `id` bigint NOT NULL,
  `competence_id` bigint DEFAULT NULL,
  `product_type_id` bigint DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_group`
--

CREATE TABLE `product_group` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_type`
--

CREATE TABLE `product_type` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `unit` varchar(64) DEFAULT NULL,
  `default_step_index` int UNSIGNED NOT NULL DEFAULT '1',
  `is_active` bit(1) DEFAULT NULL,
  `is_extra_item` bit(1) NOT NULL,
  `price_factor` double NOT NULL DEFAULT '1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` bigint NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `slug` varchar(64) DEFAULT NULL,
  `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Escopo Público',
  `internal_description` varchar(2048) NOT NULL DEFAULT '' COMMENT 'Observaçòes Privadas',
  `project_status` enum('MODEL','CONCEPTION','EXECUTION','CANCELED','CLOSE','BRIEFING','ARCHIVED','SMART') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `approved_date_by_client` datetime DEFAULT NULL,
  `approved_date_by_putz` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `video_time` int DEFAULT NULL,
  `days` int DEFAULT NULL,
  `change_max_number` int DEFAULT NULL COMMENT 'Número Máximo de Mudanças por Etapa',
  `agreement_pdf_link` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `canceled_date` datetime(6) DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `end_date_calc_preview` datetime DEFAULT NULL,
  `difficulty_level` int DEFAULT NULL,
  `video_url_low_res` varchar(512) DEFAULT NULL,
  `video_url_hi_res` varchar(512) DEFAULT NULL,
  `priority_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NO_PRIORITY',
  `priority_percent` double NOT NULL DEFAULT '0' COMMENT 'Percentul de Urgencia',
  `profit_target_percent` double NOT NULL DEFAULT '0',
  `insurance_type` varchar(64) NOT NULL DEFAULT 'NO_INSURANCE',
  `insurance_percent` double DEFAULT NULL COMMENT 'Valor do Seguro Urgencia %',
  `agency_commission_percent` double DEFAULT NULL COMMENT 'Comissão Agencia %',
  `vendor_commission_percent` double DEFAULT NULL COMMENT 'Comissão vendedor',
  `sdr_commission_percent` double NOT NULL DEFAULT '0' COMMENT 'Comissão destinada à SDR',
  `tribute_percent` double DEFAULT NULL COMMENT 'Impostos %',
  `quantity` int NOT NULL DEFAULT '1',
  `tribute_ancine` double DEFAULT NULL,
  `payment_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PAYMENT_DEFAULT_50_50',
  `payment_factor_percent` double NOT NULL DEFAULT '0',
  `rebate_subscriber_percent` double DEFAULT NULL,
  `rebate_subscriber_time` double DEFAULT NULL,
  `rebate_subscriber_plan` double DEFAULT NULL,
  `rebate_credits_percent` double NOT NULL DEFAULT '0' COMMENT 'Desconto Créditos Agencia',
  `rebate_watermark_percent` double NOT NULL DEFAULT '0' COMMENT 'Desconto Marca Agencia',
  `negotiation_rebate_percent` double NOT NULL DEFAULT '0',
  `rebate_commission_percent` int NOT NULL DEFAULT '0',
  `is_render` bit(1) DEFAULT b'0',
  `payment_plan_id` bigint DEFAULT NULL,
  `agency_id` bigint DEFAULT NULL,
  `cancel_user_id` bigint DEFAULT NULL,
  `manager_id` bigint DEFAULT NULL,
  `vendor_id` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `sdr_id` bigint DEFAULT NULL,
  `root_project_id` bigint DEFAULT NULL,
  `rd_id` varchar(128) DEFAULT NULL,
  `created_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_calc`
--

CREATE TABLE `project_calc` (
  `id` bigint NOT NULL COMMENT 'Project_ID',
  `tribute_value` double NOT NULL DEFAULT '0',
  `agency_commission_base_value` double NOT NULL DEFAULT '0',
  `agency_commission_rebate_value` double NOT NULL DEFAULT '0',
  `agency_commission_final_value` double NOT NULL DEFAULT '0',
  `vendor_commission_base_value` double DEFAULT '0',
  `vendor_commission_rebate_value` double DEFAULT '0',
  `vendor_commission_final_value` double DEFAULT '0',
  `sdr_commission_base_value` double DEFAULT '0',
  `sdr_commission_rebate_value` double DEFAULT '0',
  `sdr_commission_final_value` double DEFAULT '0',
  `priority_value` double NOT NULL DEFAULT '0',
  `insurance_value` double NOT NULL DEFAULT '0',
  `video_time_partial_percent` double DEFAULT NULL,
  `resume_commis_tax_profit_sum_percent` double DEFAULT NULL,
  `items_sum` double NOT NULL DEFAULT '0' COMMENT 'Soma dos Items de custo do Freelancer',
  `items_base_sum` double NOT NULL DEFAULT '0' COMMENT 'Soma dos Items de custo original do Freelancer',
  `items_extra_base_sum` double NOT NULL DEFAULT '0' COMMENT 'Soma dos Items Extras de custo original do Freelancer',
  `items_sum_with_priority` double DEFAULT NULL,
  `items_sum_with_priority_plus_insurance` double DEFAULT NULL,
  `items_cost_percentage` double DEFAULT NULL,
  `payment_factor_value` double DEFAULT NULL,
  `rebate_subscriber_value` double DEFAULT NULL,
  `resume_total_agency_putz_rebate_percent` double DEFAULT NULL,
  `rebate_credits_value` double DEFAULT NULL,
  `rebate_watermark_value` double DEFAULT NULL,
  `resume_total_agency_rebate_percent` double DEFAULT NULL,
  `final_extra_budget` double DEFAULT NULL,
  `final_price` double NOT NULL DEFAULT '0' COMMENT 'Inclui forma de pagamento',
  `final_costs` double DEFAULT NULL,
  `final_profit` double DEFAULT NULL,
  `profit_final_percent` double DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='@author [redacted]';

-- --------------------------------------------------------

--
-- Table structure for table `project_case`
--

CREATE TABLE `project_case` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `details` varchar(2048) NOT NULL,
  `problem` varchar(2048) NOT NULL,
  `solution` varchar(2048) NOT NULL,
  `item_index` int NOT NULL,
  `service_area_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'OTHERS',
  `is_active` bit(1) DEFAULT NULL,
  `is_online` bit(1) DEFAULT NULL,
  `video_url` varchar(512) DEFAULT NULL,
  `video_thumbs` varchar(512) DEFAULT NULL,
  `customer_name` varchar(64) NOT NULL,
  `customer_company` varchar(64) NOT NULL,
  `customer_experience` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_item`
--

CREATE TABLE `project_item` (
  `id` bigint NOT NULL,
  `project_id` bigint DEFAULT NULL,
  `rd_id` varchar(128) DEFAULT NULL,
  `project_step_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `freelancer_id` bigint DEFAULT NULL,
  `item_index` int NOT NULL,
  `is_extra_item` bit(1) NOT NULL DEFAULT b'0',
  `price_factor` double NOT NULL DEFAULT '1',
  `is_checked` bit(1) DEFAULT b'0',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `is_public` bit(1) NOT NULL DEFAULT b'0',
  `quantity` int UNSIGNED DEFAULT '1',
  `value_freela` double NOT NULL COMMENT 'Valor Real Pago ao Freela',
  `value_base` double NOT NULL COMMENT 'Valor do usado no Orçamento',
  `start_date` datetime(6) DEFAULT NULL COMMENT 'Data prevista e de Início do Item.',
  `first_commit_date` datetime(6) DEFAULT NULL COMMENT 'Data da primeira entrega parcial',
  `expected_date` datetime(6) DEFAULT NULL COMMENT 'Data prevista entrega do item',
  `end_date` datetime(6) DEFAULT NULL COMMENT 'Data da Aprovação do item',
  `close_date` datetime(6) DEFAULT NULL COMMENT 'Pagamento e encerramento do item',
  `customer_rate` int DEFAULT NULL,
  `manager_rate` int DEFAULT NULL,
  `manager_comment` varchar(512) DEFAULT NULL,
  `invoice_pdf` varchar(512) DEFAULT NULL,
  `invoice_xml` longtext,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_item_request`
--

CREATE TABLE `project_item_request` (
  `id` bigint NOT NULL,
  `freelancer_id` bigint DEFAULT NULL,
  `project_item_id` bigint DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `freela_approved` datetime(6) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `request_status` varchar(255) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_payment`
--

CREATE TABLE `project_payment` (
  `id` bigint NOT NULL,
  `project_id` bigint DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `item_index` int NOT NULL,
  `payment_date` datetime(6) DEFAULT NULL,
  `payment_value` double DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `is_checke` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_render`
--

CREATE TABLE `project_render` (
  `id` bigint NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `short_description` varchar(128) DEFAULT NULL,
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_payment_type` enum('FREE','FREE_FIRST','FREE_REAL_FIRST','50OFF_FIRST','CODE_MANAGER','CODE_OR_PAYMENT','TEST') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'FREE',
  `delivery_max_time` enum('EXPRESS','NORMAL','HOURS2','HOURS5','HOURS8','HOURS16') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'EXPRESS',
  `delivery_msg_json` varchar(1028) DEFAULT NULL,
  `render_slug` varchar(64) DEFAULT NULL,
  `project_id` bigint DEFAULT NULL,
  `owner_id` bigint DEFAULT NULL,
  `json_template` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `json_data_source` longtext,
  `json_field_description` longtext COMMENT 'Descrição dos Campos Select',
  `priority` int DEFAULT '0',
  `max_time` int DEFAULT NULL COMMENT 'Tempo Máximo de Espera',
  `instruction_openai` varchar(2048) DEFAULT NULL,
  `whatsapp_bot` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `whatsapp_flow` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `sending_platform` enum('TWILIO','META','NONE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `avaliable_until` datetime(6) DEFAULT NULL,
  `id_plataform` varchar(256) DEFAULT NULL,
  `token_plataform` varchar(256) DEFAULT NULL,
  `whatsapp_no_credit` varchar(1024) DEFAULT NULL,
  `whatsapp_autoresponse` varchar(1024) DEFAULT NULL,
  `whatsapp_template_service` longtext,
  `whatsapp_welcome` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `whatsapp_wait` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `whatsapp_finish` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `whatsapp_share` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `video_url_template` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `thumb_url` varchar(256) DEFAULT NULL,
  `video_url_example` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `render_avg_time` int DEFAULT '1',
  `videos_per_month` int DEFAULT NULL,
  `videos_per_day` int DEFAULT NULL,
  `number_of_items` int DEFAULT NULL,
  `render_main_url` varchar(128) DEFAULT NULL,
  `whatsapp_bot_welcome_media` varchar(256) DEFAULT NULL,
  `is_csv_render` bit(1) NOT NULL DEFAULT b'0',
  `is_active` bit(1) DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `max_price` double DEFAULT NULL,
  `coupons_required` int NOT NULL DEFAULT '1',
  `pay_max_time` int DEFAULT '23' COMMENT 'Tempo para pagamento do boleto',
  `password_hash` varchar(60) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_render_group_name`
--

CREATE TABLE `project_render_group_name` (
  `id` bigint NOT NULL,
  `render_id` bigint NOT NULL,
  `ibge_name_group_id` bigint DEFAULT NULL,
  `name` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Remover este campo ele é redundante do ID',
  `record_status` enum('APPROVED','SUBSCRIBED','BACKUP','DECLINED','REPLACED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_render_item`
--

CREATE TABLE `project_render_item` (
  `id` bigint NOT NULL,
  `render_slug` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `render_status` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `person_id` bigint DEFAULT NULL,
  `render_project_id` bigint DEFAULT NULL,
  `render_uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `render_count` int DEFAULT '0',
  `type` varchar(64) DEFAULT 'default',
  `origin` varchar(128) DEFAULT NULL,
  `tracking` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `priority` int DEFAULT '0',
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `whatsapp` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `whatsapp_status` enum('ERROR','DELIVERED','INVITED','WATING','CANCELED','EXPIRED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `whatsapp_sent_date` datetime(6) DEFAULT NULL,
  `render_progress` int DEFAULT '0',
  `encode_progress` int DEFAULT '0',
  `error` varchar(256) DEFAULT NULL,
  `workpath` varchar(256) DEFAULT NULL,
  `scriptfile` varchar(256) DEFAULT NULL,
  `resultname` varchar(128) DEFAULT NULL,
  `is_name_checked` bit(1) DEFAULT b'0' COMMENT 'Se nome já foi checado',
  `output` varchar(256) DEFAULT NULL,
  `description_hash` varchar(172) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `json_data` longtext,
  `data_source` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `delivery_max_time` enum('EXPRESS','NORMAL','HOURS2','HOURS5','HOURS8','HOURS16') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'EXPRESS',
  `scheduled_to` datetime(6) DEFAULT NULL,
  `delivery_msg_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `start_render_date` datetime(6) DEFAULT NULL,
  `expected_render_date` datetime(6) DEFAULT NULL,
  `exported_date` datetime(6) DEFAULT NULL,
  `end_render_date` datetime(6) DEFAULT NULL,
  `video_check_status` enum('CHECKED','NOT_CHECKED','AUTOCHECKED') NOT NULL DEFAULT 'AUTOCHECKED',
  `bot_name` varchar(64) DEFAULT NULL,
  `video_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `video_file_size` bigint DEFAULT NULL,
  `thumb_url` varchar(512) DEFAULT NULL,
  `frames` longtext,
  `ia_update_date` datetime DEFAULT NULL COMMENT 'data de uso de IA',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `error_at` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `project_render_log`
--

CREATE TABLE `project_render_log` (
  `id` bigint NOT NULL,
  `uid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `project_render_item_id` bigint DEFAULT NULL,
  `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bot_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Start Product Pack';

-- --------------------------------------------------------

--
-- Stand-in structure for view `project_render_user`
-- (See below for the actual view)
--
CREATE TABLE `project_render_user` (
`person_id` bigint
,`project_render_id` bigint
,`render_slug` varchar(64)
);

-- --------------------------------------------------------

--
-- Table structure for table `project_step`
--

CREATE TABLE `project_step` (
  `id` bigint NOT NULL,
  `project_id` bigint DEFAULT NULL,
  `step_id` bigint DEFAULT NULL,
  `schedule_name` varchar(64) NOT NULL DEFAULT 'principal',
  `is_main_schedule` bit(1) DEFAULT b'0',
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `item_index` int NOT NULL,
  `days_freela` int DEFAULT NULL,
  `days_extra` int NOT NULL DEFAULT '0',
  `days_approv` int NOT NULL DEFAULT '0',
  `days_total` int NOT NULL DEFAULT '0',
  `start_date_expected` timestamp NULL DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `end_date_expected` datetime(6) DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `change_number` int NOT NULL DEFAULT '0',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='ProjectStep/Etapa\\nRepresentação de uma única etapa de um projeto\\n@author [redacted]';

-- --------------------------------------------------------

--
-- Table structure for table `project__tags`
--

CREATE TABLE `project__tags` (
  `tags_id` bigint NOT NULL,
  `project_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publications`
--

CREATE TABLE `publications` (
  `id` bigint NOT NULL,
  `publications_source_id` bigint DEFAULT NULL,
  `source_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `platform` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cache_post_user` longtext,
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `json_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `news_time` varchar(64) DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `last_modified_by` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `publications_complete`
-- (See below for the actual view)
--
CREATE TABLE `publications_complete` (
`id` bigint
,`json_data` longtext
,`main_image` varchar(256)
,`news_time` varchar(64)
,`platform` varchar(64)
,`publications_source_id` bigint
,`published_at` datetime(6)
,`source_type` varchar(64)
,`tags` text
,`title` varchar(256)
,`url` varchar(512)
);

-- --------------------------------------------------------

--
-- Table structure for table `publications_source`
--

CREATE TABLE `publications_source` (
  `id` bigint NOT NULL,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `to_do` longtext,
  `status` enum('CREATED','FINISHED','ALL_STARTED','ERROR','FINISHED_ERROR','STARTED','PRECREATED','CANCELED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `check_status` enum('CHECKED','NOT_CHECKED','AUTOCHECKED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NOT_CHECKED',
  `images` longtext,
  `published_at` datetime(6) DEFAULT NULL,
  `author_id` bigint DEFAULT NULL,
  `content` longtext,
  `source_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `main_image` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `project_render_item_ids` varchar(256) DEFAULT NULL,
  `section` varchar(64) DEFAULT NULL,
  `section_slug` varchar(64) DEFAULT NULL,
  `link` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `json_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `attempt_count` int NOT NULL DEFAULT '0',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `cached_tags` varchar(512) DEFAULT NULL,
  `person_id` bigint DEFAULT NULL,
  `message_error` longtext,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) NOT NULL,
  `created_by` varchar(64) NOT NULL,
  `last_modified_by` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publications_source__tags`
--

CREATE TABLE `publications_source__tags` (
  `tags_id` bigint NOT NULL,
  `publication_source_id` bigint NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publications_source__type_users`
--

CREATE TABLE `publications_source__type_users` (
  `id` bigint NOT NULL,
  `person_id` bigint NOT NULL,
  `publication_source_type` enum('ECOMMERCE','CONTABILIDADE','G1','ESTETICA','CONSTRUCAO','FARMACIA','FINANCENEWS') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) NOT NULL,
  `last_modified_by` varchar(64) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publications_user`
--

CREATE TABLE `publications_user` (
  `id` bigint NOT NULL,
  `to_do` longtext,
  `requester_id` bigint NOT NULL,
  `owner_id` bigint DEFAULT NULL,
  `publication_id` bigint DEFAULT NULL,
  `project_render_item_id` bigint DEFAULT NULL,
  `post_id` varchar(64) DEFAULT NULL,
  `status` varchar(64) NOT NULL,
  `publication_date` datetime(6) DEFAULT NULL,
  `json_publication` longtext,
  `error_description` longtext,
  `app_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `page_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `access_token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `platform` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `publication_task`
--

CREATE TABLE `publication_task` (
  `id` bigint NOT NULL,
  `publication_source_id` bigint DEFAULT NULL,
  `publication_user_id` bigint DEFAULT NULL,
  `todo` varchar(64) NOT NULL,
  `assistant` varchar(64) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `render_news_type` varchar(64) DEFAULT NULL,
  `extra` longtext,
  `project_render_item_id` bigint DEFAULT NULL,
  `status` varchar(32) DEFAULT NULL,
  `attempts` int DEFAULT NULL,
  `next_run_at` datetime DEFAULT NULL,
  `priority` int NOT NULL,
  `lock_until` bigint DEFAULT NULL,
  `locked_by` varchar(64) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `error_message` longtext,
  `created_date` datetime DEFAULT NULL,
  `last_modified_date` datetime DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `putz_authority`
--

CREATE TABLE `putz_authority` (
  `name` varchar(50) NOT NULL,
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `putz_persistent_audit_event`
--

CREATE TABLE `putz_persistent_audit_event` (
  `event_id` bigint NOT NULL,
  `principal` varchar(50) NOT NULL,
  `event_date` timestamp NULL DEFAULT NULL,
  `event_type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `putz_persistent_audit_evt_data`
--

CREATE TABLE `putz_persistent_audit_evt_data` (
  `event_id` bigint NOT NULL,
  `name` varchar(150) NOT NULL,
  `value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `putz_user`
--

CREATE TABLE `putz_user` (
  `id` bigint NOT NULL,
  `login` varchar(50) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `provider` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'local',
  `provider_id` varchar(128) DEFAULT NULL,
  `image_url` varchar(256) DEFAULT NULL,
  `password_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `danger_pass` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `activated` bit(1) NOT NULL,
  `lang_key` varchar(10) DEFAULT NULL,
  `activation_key` varchar(20) DEFAULT NULL,
  `reset_key` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_by` varchar(50) NOT NULL,
  `created_date` timestamp NULL DEFAULT NULL,
  `reset_date` timestamp NULL DEFAULT NULL,
  `last_modified_by` varchar(50) DEFAULT NULL,
  `last_modified_date` timestamp NULL DEFAULT NULL,
  `old_id` varchar(128) DEFAULT NULL COMMENT 'Antigo ID c#',
  `old_passhash` varchar(128) DEFAULT NULL COMMENT 'Antiga PassHash'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `putz_user_authority`
--

CREATE TABLE `putz_user_authority` (
  `user_id` bigint NOT NULL,
  `authority_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `id` bigint NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `content_value` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `question_type` varchar(255) NOT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rel_product_type__groups`
--

CREATE TABLE `rel_product_type__groups` (
  `groups_id` bigint NOT NULL,
  `product_type_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rel_product_type__tags`
--

CREATE TABLE `rel_product_type__tags` (
  `tags_id` bigint NOT NULL,
  `product_type_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `render_item_resume`
-- (See below for the actual view)
--
CREATE TABLE `render_item_resume` (
`data_source` longtext
,`description` varchar(1024)
,`id` bigint
,`NAME` varchar(64)
,`render_slug` varchar(64)
,`render_status` varchar(64)
,`video_url` varchar(512)
,`whatsapp` varchar(64)
);

-- --------------------------------------------------------

--
-- Table structure for table `satisfaction_survey`
--

CREATE TABLE `satisfaction_survey` (
  `id` bigint NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL,
  `project_id` bigint DEFAULT NULL,
  `question_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `id` bigint NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `days` int DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Schedule/Cronograma\\nRepresentação de um modelo de cronograma com etapas\\n@author [redacted]';

-- --------------------------------------------------------

--
-- Table structure for table `schedule_step`
--

CREATE TABLE `schedule_step` (
  `id` bigint NOT NULL,
  `schedule_id` bigint DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `item_index` int NOT NULL,
  `icon_url` varchar(128) DEFAULT NULL,
  `icon_progress_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `icon_finish_url` varchar(128) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `days` int DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Step/ConfiguracaoEtapa\\nEtapa de cronograma modelo\\n@author [redacted]';

-- --------------------------------------------------------

--
-- Table structure for table `smart_websummit_rio`
--

CREATE TABLE `smart_websummit_rio` (
  `id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `avatar_url_large` varchar(1024) DEFAULT NULL,
  `avatar_url_medium` varchar(1024) DEFAULT NULL,
  `country` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `elevatorPitch` varchar(1024) DEFAULT NULL,
  `track` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `industry` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `subscription_plan_id` bigint NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `auto_renew` tinyint(1) DEFAULT '0',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `amount_credits` varchar(2048) DEFAULT '0',
  `amount_paid` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) DEFAULT '0.00',
  `transaction_id` bigint DEFAULT NULL,
  `subscription_id_external` varchar(128) DEFAULT NULL,
  `subscription_status` enum('ACTIVE','EXPIRED','CANCELED','PENDING') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'PENDING',
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscription_plans`
--

CREATE TABLE `subscription_plans` (
  `id` bigint NOT NULL,
  `plan_name` varchar(100) NOT NULL,
  `plan_category` enum('SPONSOR','OLD','CUSTOMER','ACCOUNTING','OTHERS') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `publication_source_type` enum('ECOMMERCE','CONTABILIDADE','G1','ESTETICA','CONSTRUCAO','FARMACIA','FINANCENEWS') DEFAULT NULL,
  `description` varchar(2048) NOT NULL,
  `description_short` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description_items` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `auto_renew` tinyint(1) DEFAULT '0',
  `credit_days` int NOT NULL,
  `meses` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `json_credit_details` varchar(2048) NOT NULL,
  `json_payment_details` varchar(2048) NOT NULL,
  `amount_paid` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) DEFAULT '0.00',
  `id_external` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_date` datetime(6) NOT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `id` bigint NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `tag_type` varchar(32) NOT NULL DEFAULT 'OTHER',
  `is_active` bit(1) DEFAULT NULL,
  `relevance` int NOT NULL DEFAULT '0' COMMENT 'Campo Calculado com o úmero de vezes que a tag foi usada',
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Start Product Pack';

-- --------------------------------------------------------

--
-- Table structure for table `timeline_attachment`
--

CREATE TABLE `timeline_attachment` (
  `id` bigint NOT NULL,
  `event_id` bigint DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `extension` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `link` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timeline_comment`
--

CREATE TABLE `timeline_comment` (
  `id` bigint NOT NULL,
  `event_id` bigint DEFAULT NULL,
  `description` varchar(1024) NOT NULL,
  `is_visible` bit(1) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL,
  `root_comment_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `timeline_event`
--

CREATE TABLE `timeline_event` (
  `id` bigint NOT NULL,
  `title` varchar(64) NOT NULL,
  `project_step_id` bigint DEFAULT NULL,
  `project_item_id` bigint DEFAULT NULL,
  `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `event_type` enum('TOPIC','COMMIT','REQUEST','SOLVED','APPROVED','PARTIAL') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'COMMIT',
  `is_visible` bit(1) DEFAULT b'1',
  `is_active` bit(1) DEFAULT b'1',
  `conclusion_date` datetime(6) DEFAULT NULL,
  `conclusion_title` varchar(64) DEFAULT NULL,
  `conclusion_description` varchar(3072) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `customer_rate` int DEFAULT NULL,
  `is_approved` bit(1) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL,
  `root_event_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Start TimeLine Pack';

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `id` bigint NOT NULL,
  `transaction_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Id único',
  `person_id` bigint DEFAULT NULL,
  `amount` double NOT NULL,
  `project_id` bigint DEFAULT NULL,
  `project_item_id` bigint DEFAULT NULL,
  `subscription_id` bigint DEFAULT NULL,
  `payment_motivation` varchar(64) DEFAULT NULL,
  `qtd` int DEFAULT NULL,
  `payment` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` enum('WAITING_PAYMENT','SUCCESS','NO_PAY','SCHEDULED','ERROR') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description_short` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `operation` enum('CREDIT','DEBIT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `methods_payment` enum('LYTEX','TICKET','PUTZ') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `entry_date` datetime(6) DEFAULT NULL,
  `expiration_date` datetime(6) DEFAULT NULL,
  `finished_codes` bit(1) NOT NULL,
  `related_transaction_id` bigint DEFAULT NULL,
  `transaction_hash` varchar(256) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_coupon`
--

CREATE TABLE `transaction_coupon` (
  `id` bigint NOT NULL,
  `person_owner_id` bigint DEFAULT NULL COMMENT 'Pessoa que Comprou o Cupom, não necessariamente quem usou',
  `person_id` bigint DEFAULT NULL COMMENT 'Pessoa que usou o cupom',
  `code_hash` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `discount_percentual` decimal(8,2) DEFAULT NULL,
  `discount_absolute` decimal(8,2) DEFAULT NULL,
  `coupon_type` enum('STORIES_VIDEOS','FEED_VIDEOS','OTHER','NATAL') NOT NULL DEFAULT 'OTHER',
  `transaction_id` bigint DEFAULT NULL,
  `project_render_id` bigint DEFAULT NULL,
  `project_id` bigint DEFAULT NULL,
  `code_status` enum('AVAILABLE','PROMOTIONAL','WAITING_PAYMENT','USED','GIFT_CODE','EXPIRED','WAITING_VIDEO','OTHER') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reference_coupom` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `project_render_item_id` bigint DEFAULT NULL,
  `publications_user_id` bigint DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `expiration_date` datetime(6) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_coupon_remover`
--

CREATE TABLE `transaction_coupon_remover` (
  `id` bigint NOT NULL,
  `person_owner_id` bigint DEFAULT NULL COMMENT 'Pessoa que Comprou o Cupom, não necessariamente quem usou',
  `person_id` bigint DEFAULT NULL COMMENT 'Pessoa que usou o cupom',
  `code_hash` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `discount_percentual` decimal(8,2) DEFAULT NULL,
  `discount_absolute` decimal(8,2) DEFAULT NULL,
  `transaction_id` bigint DEFAULT NULL,
  `project_render_id` bigint DEFAULT NULL,
  `project_id` bigint DEFAULT NULL,
  `code_status` enum('AVAILABLE','PROMOTIONAL','WAITING_PAYMENT','USED','GIFT_CODE','EXPIRED','WAITING_VIDEO','OTHER') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `reference_coupom` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `project_render_item_id` bigint DEFAULT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `expiration_date` datetime(6) DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_remover`
--

CREATE TABLE `transaction_remover` (
  `id` bigint NOT NULL,
  `transaction_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'Id único',
  `person_id` bigint DEFAULT NULL,
  `amount` double NOT NULL,
  `project_id` bigint DEFAULT NULL,
  `project_item_id` bigint DEFAULT NULL,
  `payment_motivation` varchar(64) DEFAULT NULL,
  `qtd` int DEFAULT NULL,
  `payment` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `status` enum('WAITING_PAYMENT','SUCCESS','NO_PAY','SCHEDULED','ERROR') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `operation` enum('CREDIT','DEBIT') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `methods_payment` enum('LYTEX','TICKET','PUTZ') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `entry_date` datetime(6) DEFAULT NULL,
  `expiration_date` datetime(6) DEFAULT NULL,
  `finished_codes` bit(1) NOT NULL,
  `related_transaction_id` bigint DEFAULT NULL,
  `created_date` datetime(6) DEFAULT NULL,
  `last_modified_date` datetime(6) DEFAULT NULL,
  `created_by` varchar(64) DEFAULT NULL,
  `last_modified_by` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure for view `ibge_names_and_frequency`
--
DROP TABLE IF EXISTS `ibge_names_and_frequency`;

CREATE ALGORITHM=TEMPTABLE DEFINER=`alessio`@`%` SQL SECURITY DEFINER VIEW `ibge_names_and_frequency`  AS SELECT `n`.`first_name` AS `first_name`, `f`.`f_frequency` AS `f_frequency`, sum(if((`f`.`gender` = 'M'),`f`.`f_total`,0)) AS `f_male`, sum(if((`f`.`gender` = 'F'),`f`.`f_total`,0)) AS `f_female`, if((sum(if((`f`.`gender` = 'M'),`f`.`f_total`,0)) < sum(if((`f`.`gender` = 'F'),`f`.`f_total`,0))),'F',if((sum(if((`f`.`gender` = 'M'),`f`.`f_total`,0)) > sum(if((`f`.`gender` = 'F'),`f`.`f_total`,0))),'M','O')) AS `gender`, if((sum(if((`f`.`gender` = 'M'),`f`.`f_total`,0)) < sum(if((`f`.`gender` = 'F'),`f`.`f_total`,0))),(sum(if((`f`.`gender` = 'F'),`f`.`f_total`,0)) / sum(`f`.`f_total`)),if((sum(if((`f`.`gender` = 'M'),`f`.`f_total`,0)) > sum(if((`f`.`gender` = 'F'),`f`.`f_total`,0))),(sum(if((`f`.`gender` = 'M'),`f`.`f_total`,0)) / sum(`f`.`f_total`)),1)) AS `ratio` FROM (`ibge__name` `n` left join `ibge__name_frequency` `f` on((`n`.`id` = `f`.`name_id`))) GROUP BY `n`.`first_name`, `f`.`f_frequency` ;

-- --------------------------------------------------------

--
-- Structure for view `ibge_name_group_sum`
--
DROP TABLE IF EXISTS `ibge_name_group_sum`;

CREATE ALGORITHM=UNDEFINED DEFINER=`alessio`@`%` SQL SECURITY DEFINER VIEW `ibge_name_group_sum`  AS SELECT `g`.`id` AS `id`, `g`.`name` AS `name`, if((sum(`n`.`frequency_female`) < sum(`n`.`frequency_male`)),'M','F') AS `gender`, sum(`n`.`frequency_female`) AS `frequency_female`, sum(`n`.`frequency_male`) AS `frequency_male`, sum(`n`.`frequency_total`) AS `frequency_total`, if((sum(`n`.`frequency_female`) < sum(`n`.`frequency_male`)),(sum(`n`.`frequency_male`) / sum(`n`.`frequency_total`)),(sum(`n`.`frequency_female`) / sum(`n`.`frequency_total`))) AS `ratio`, group_concat(`n`.`first_name` separator ' | ') AS `names` FROM (`ibge__name_group` `g` left join `ibge__name` `n` on((`n`.`name_group_id` = `g`.`id`))) WHERE (`g`.`group_type` = 'MAIN') GROUP BY `g`.`id`, `g`.`name` ;

-- --------------------------------------------------------

--
-- Structure for view `project_render_user`
--
DROP TABLE IF EXISTS `project_render_user`;

CREATE ALGORITHM=UNDEFINED DEFINER=`alessio`@`%` SQL SECURITY DEFINER VIEW `project_render_user`  AS SELECT `person`.`id` AS `person_id`, `project_render`.`id` AS `project_render_id`, `project_render`.`render_slug` AS `render_slug` FROM ((`project` join `person` on(((`project`.`client_id` = `person`.`id`) or `person`.`id` in (select `p`.`id` from `person` `p` where (`p`.`company_id` = `project`.`client_id`))))) join `project_render` on((`project_render`.`project_id` = `project`.`id`))) WHERE ((`person`.`is_active` = true) AND (`project_render`.`is_active` = true)) ;

-- --------------------------------------------------------

--
-- Structure for view `publications_complete`
--
DROP TABLE IF EXISTS `publications_complete`;

CREATE ALGORITHM=UNDEFINED DEFINER=`alessio`@`%` SQL SECURITY DEFINER VIEW `publications_complete`  AS SELECT `p`.`id` AS `id`, `p`.`publications_source_id` AS `publications_source_id`, `p`.`source_type` AS `source_type`, `p`.`platform` AS `platform`, `p`.`json_data` AS `json_data`, `p`.`url` AS `url`, `p`.`news_time` AS `news_time`, `s`.`published_at` AS `published_at`, `s`.`title` AS `title`, `s`.`main_image` AS `main_image`, group_concat(`t`.`name` order by `t`.`name` ASC separator ', ') AS `tags` FROM (((`publications` `p` left join `publications_source` `s` on((`s`.`id` = `p`.`publications_source_id`))) left join `publications_source__tags` `pt` on((`pt`.`publication_source_id` = `s`.`id`))) left join `tag` `t` on((`pt`.`tags_id` = `t`.`id`))) GROUP BY `p`.`id`, `p`.`publications_source_id`, `p`.`source_type`, `p`.`platform`, `p`.`json_data`, `p`.`url`, `p`.`news_time`, `s`.`published_at`, `s`.`title`, `s`.`main_image` ORDER BY `s`.`published_at` DESC, `s`.`id` DESC, `p`.`platform` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `render_item_resume`
--
DROP TABLE IF EXISTS `render_item_resume`;

CREATE ALGORITHM=UNDEFINED DEFINER=`alessio`@`%` SQL SECURITY DEFINER VIEW `render_item_resume`  AS SELECT `project_render_item`.`id` AS `id`, `project_render_item`.`render_slug` AS `render_slug`, `project_render_item`.`render_status` AS `render_status`, `project_render_item`.`name` AS `NAME`, `project_render_item`.`description` AS `description`, `project_render_item`.`whatsapp` AS `whatsapp`, `project_render_item`.`data_source` AS `data_source`, `project_render_item`.`video_url` AS `video_url` FROM `project_render_item` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asset_category`
--
ALTER TABLE `asset_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_asset_category__slug` (`slug`),
  ADD KEY `fk_asset_category___root_category` (`root_category_id`);

--
-- Indexes for table `asset_category__users`
--
ALTER TABLE `asset_category__users`
  ADD PRIMARY KEY (`person_id`,`categories_id`),
  ADD KEY `fk_rel_asset_retail_product__categories__categories_id` (`categories_id`);

--
-- Indexes for table `asset_item`
--
ALTER TABLE `asset_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_asset_item__slug` (`slug`);

--
-- Indexes for table `asset_item__categories`
--
ALTER TABLE `asset_item__categories`
  ADD PRIMARY KEY (`category_id`,`asset_item_id`),
  ADD KEY `fk_asset_item__categories__asset_item_id` (`asset_item_id`);

--
-- Indexes for table `asset_item__voice_overs`
--
ALTER TABLE `asset_item__voice_overs`
  ADD PRIMARY KEY (`asset_item_id`,`voice_overs_id`),
  ADD KEY `fk_rel_asset_retail_product__voice_overs__voice_overs_id` (`voice_overs_id`);

--
-- Indexes for table `asset_retail_product`
--
ALTER TABLE `asset_retail_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_asset_retail_product__slug` (`slug`),
  ADD KEY `fk_asset_retail_product__default_suppliew_id` (`default_supplier_id`),
  ADD KEY `fk_asset_retail_product__default_unit_id` (`default_unit_id`);

--
-- Indexes for table `asset_retail_product__categories`
--
ALTER TABLE `asset_retail_product__categories`
  ADD PRIMARY KEY (`asset_retail_product_id`,`categories_id`),
  ADD KEY `fk_rel_asset_retail_product__categories__categories_id` (`categories_id`);

--
-- Indexes for table `asset_retail_product__voice_overs`
--
ALTER TABLE `asset_retail_product__voice_overs`
  ADD PRIMARY KEY (`asset_retail_product_id`,`voice_overs_id`),
  ADD KEY `fk_rel_asset_retail_product__voice_overs__voice_overs_id` (`voice_overs_id`);

--
-- Indexes for table `asset_retail_supplier`
--
ALTER TABLE `asset_retail_supplier`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_asset_retail_supplier__slug` (`slug`);

--
-- Indexes for table `asset_retail_unit`
--
ALTER TABLE `asset_retail_unit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_asset_retail_unit__slug` (`slug`);

--
-- Indexes for table `asset_startup`
--
ALTER TABLE `asset_startup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `appearance_id_2` (`appearance_id`),
  ADD UNIQUE KEY `company_id_2` (`company_id`),
  ADD KEY `appearance_id` (`appearance_id`),
  ADD KEY `company_id` (`company_id`),
  ADD KEY `fk_asset_startup__category_id` (`category_id`),
  ADD KEY `track` (`track`);

--
-- Indexes for table `asset_voice_speaker`
--
ALTER TABLE `asset_voice_speaker`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_asset_voice_speaker__slug` (`slug`);

--
-- Indexes for table `asset_voice_voiceover`
--
ALTER TABLE `asset_voice_voiceover`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_asset_voice_voiceover__slug` (`slug`),
  ADD KEY `fk_asset_voice_voiceover__speaker_id` (`speaker_id`),
  ADD KEY `fk_asset_voice_voiceover__category_id` (`category_id`);

--
-- Indexes for table `competence`
--
ALTER TABLE `competence`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `competence_guide`
--
ALTER TABLE `competence_guide`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un_competence_level` (`competence_id`,`level`),
  ADD KEY `fk_competence_guide__competence_id` (`competence_id`);

--
-- Indexes for table `config_params`
--
ALTER TABLE `config_params`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `index_value` (`config_params_type`,`value`);

--
-- Indexes for table `DATABASECHANGELOG`
--
ALTER TABLE `DATABASECHANGELOG`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `DATABASECHANGELOGLOCK`
--
ALTER TABLE `DATABASECHANGELOGLOCK`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `franquias`
--
ALTER TABLE `franquias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `segmento_id` (`segmento_id`),
  ADD KEY `rede_id` (`rede_id`);

--
-- Indexes for table `franquias__expansao_interesse`
--
ALTER TABLE `franquias__expansao_interesse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `franquia_id` (`franquia_id`);

--
-- Indexes for table `franquias__investimentos_franquia`
--
ALTER TABLE `franquias__investimentos_franquia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `franquia_id` (`franquia_id`);

--
-- Indexes for table `franquias__premiacoes`
--
ALTER TABLE `franquias__premiacoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `franquia_id` (`franquia_id`);

--
-- Indexes for table `franquias__redes_franquia`
--
ALTER TABLE `franquias__redes_franquia`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `franquias__redes_sociais`
--
ALTER TABLE `franquias__redes_sociais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `franquia_id` (`franquia_id`);

--
-- Indexes for table `franquias__requisitos_franquia`
--
ALTER TABLE `franquias__requisitos_franquia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `franquia_id` (`franquia_id`);

--
-- Indexes for table `franquias__segmentos`
--
ALTER TABLE `franquias__segmentos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `franquias__sub_segmentos`
--
ALTER TABLE `franquias__sub_segmentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `segmento_id` (`segmento_id`);

--
-- Indexes for table `franquias__taxas_franquia`
--
ALTER TABLE `franquias__taxas_franquia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `franquia_id` (`franquia_id`);

--
-- Indexes for table `franquias__unidades`
--
ALTER TABLE `franquias__unidades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `franquia_id` (`franquia_id`);

--
-- Indexes for table `ibge__city`
--
ALTER TABLE `ibge__city`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `siafi_id` (`siafi_id`),
  ADD KEY `fk_ibge_city__uf_id` (`uf_id`);

--
-- Indexes for table `ibge__name`
--
ALTER TABLE `ibge__name`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un__first_name` (`first_name`) USING BTREE,
  ADD KEY `fk_nomes_grupos` (`name_group_id_calc`),
  ADD KEY `fk_ibge_name__ibge_group_name` (`name_group_id`);

--
-- Indexes for table `ibge__name_frequency`
--
ALTER TABLE `ibge__name_frequency`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `name` (`name_id_calc`,`gender`,`uf_id`) USING BTREE,
  ADD KEY `fk_name_frequency__uf_id` (`uf_id`),
  ADD KEY `fk_nomes_frequency__name_id` (`name_id`);

--
-- Indexes for table `ibge__name_group`
--
ALTER TABLE `ibge__name_group`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `group_type` (`group_type`);

--
-- Indexes for table `ibge__name_render`
--
ALTER TABLE `ibge__name_render`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `ibge_name` (`ibge_name_id_calc`),
  ADD KEY `fk_name_render __ibge_name` (`ibge_name_id`),
  ADD KEY `fk_name_render __project_render` (`project_render_id`);

--
-- Indexes for table `ibge__uf`
--
ALTER TABLE `ibge__uf`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `id_ibge` (`id_ibge`),
  ADD UNIQUE KEY `uf` (`uf`);

--
-- Indexes for table `notification_whatsapp`
--
ALTER TABLE `notification_whatsapp`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sid` (`sid`),
  ADD KEY `fk_notification_whatsapp__person_id` (`person_id`),
  ADD KEY `fk_notification_whatsapp__event_id` (`time_line_event_id`),
  ADD KEY `fk_notification_whatsapp__render_id` (`project_render_item_id`),
  ADD KEY `notification_type` (`notification_type`),
  ADD KEY `reference` (`reference`),
  ADD KEY `phone_from` (`phone_from`),
  ADD KEY `bot_number` (`reference_chatbot`);

--
-- Indexes for table `openai_assistants`
--
ALTER TABLE `openai_assistants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `openai_conclusions`
--
ALTER TABLE `openai_conclusions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slug` (`slug`),
  ADD KEY `openai_function` (`openai_function`);

--
-- Indexes for table `page_faq`
--
ALTER TABLE `page_faq`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_person__slug` (`slug`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_whatsapp` (`phone_whatsapp`),
  ADD KEY `fk_person__company_id` (`company_id`);

--
-- Indexes for table `person_references`
--
ALTER TABLE `person_references`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un_person_reference` (`reference_name`,`person_id`) USING BTREE,
  ADD KEY `fk_person__person_id` (`person_id`);

--
-- Indexes for table `portfolio`
--
ALTER TABLE `portfolio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_portfolio__competence_id` (`competence_id`),
  ADD KEY `fk_portfolio__person_id` (`person_id`);

--
-- Indexes for table `portfolio__tags`
--
ALTER TABLE `portfolio__tags`
  ADD PRIMARY KEY (`portfolio_id`,`tags_id`),
  ADD KEY `fk_rel_portfolio__tags__tags_id` (`tags_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product__products_id` (`product_type_id`);

--
-- Indexes for table `product_competence`
--
ALTER TABLE `product_competence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_competence__product_id` (`product_type_id`),
  ADD KEY `fk_product_competence__competence_id` (`competence_id`);

--
-- Indexes for table `product_group`
--
ALTER TABLE `product_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_type`
--
ALTER TABLE `product_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_project__slug` (`slug`),
  ADD KEY `fk_project__payment_plan_id` (`payment_plan_id`),
  ADD KEY `fk_project__root_project_id` (`root_project_id`),
  ADD KEY `fk_project__agency_id` (`agency_id`),
  ADD KEY `fk_project__cancel_user_id` (`cancel_user_id`),
  ADD KEY `fk_project__client_id` (`client_id`),
  ADD KEY `fk_project__manager_id` (`manager_id`),
  ADD KEY `fk_project__vendor_id` (`vendor_id`);

--
-- Indexes for table `project_calc`
--
ALTER TABLE `project_calc`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_case`
--
ALTER TABLE `project_case`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_item`
--
ALTER TABLE `project_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_project_item__project_step_id` (`project_step_id`),
  ADD KEY `fk_project_item__freelancer_id` (`freelancer_id`),
  ADD KEY `fk_project_item__project_id` (`project_id`),
  ADD KEY `fk_project_item__item_id` (`product_id`);

--
-- Indexes for table `project_item_request`
--
ALTER TABLE `project_item_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_project_item_request__freelancer_id` (`freelancer_id`),
  ADD KEY `fk_project_item_request__project_item_id` (`project_item_id`);

--
-- Indexes for table `project_payment`
--
ALTER TABLE `project_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_project_payment__project_id` (`project_id`);

--
-- Indexes for table `project_render`
--
ALTER TABLE `project_render`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `password_hash` (`password_hash`),
  ADD UNIQUE KEY `render_slug` (`render_slug`);

--
-- Indexes for table `project_render_group_name`
--
ALTER TABLE `project_render_group_name`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `un_render_id__name` (`render_id`,`ibge_name_group_id`) USING BTREE,
  ADD KEY `fk_project_render_name__name_id` (`name`),
  ADD KEY `fk_project_render_group_name__group_name_id` (`ibge_name_group_id`);

--
-- Indexes for table `project_render_item`
--
ALTER TABLE `project_render_item`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `render_uid` (`render_uid`),
  ADD KEY `fk_project_render_item__render_project_id` (`render_project_id`),
  ADD KEY `whatzapp` (`whatsapp`),
  ADD KEY `email` (`email`),
  ADD KEY `description_hash` (`description_hash`),
  ADD KEY `render_slug` (`render_slug`),
  ADD KEY `render_status` (`render_status`),
  ADD KEY `tracking` (`tracking`),
  ADD KEY `last_modified_date` (`last_modified_date`),
  ADD KEY `fk_project_render_item__person_id` (`person_id`);

--
-- Indexes for table `project_render_log`
--
ALTER TABLE `project_render_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_project_render_log__render_item_id` (`project_render_item_id`);

--
-- Indexes for table `project_step`
--
ALTER TABLE `project_step`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ItemProjeto` (`project_id`,`item_index`,`schedule_name`) USING BTREE,
  ADD KEY `fk_project_step__step_id` (`step_id`);

--
-- Indexes for table `project__tags`
--
ALTER TABLE `project__tags`
  ADD PRIMARY KEY (`project_id`,`tags_id`),
  ADD KEY `fk_rel_project__tags__tags_id` (`tags_id`);

--
-- Indexes for table `publications`
--
ALTER TABLE `publications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_publications__publication_source_id` (`publications_source_id`),
  ADD KEY `source` (`source_type`);

--
-- Indexes for table `publications_source`
--
ALTER TABLE `publications_source`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNQ_link` (`link`) USING BTREE,
  ADD KEY `status` (`status`),
  ADD KEY `source_type` (`source_type`);

--
-- Indexes for table `publications_source__tags`
--
ALTER TABLE `publications_source__tags`
  ADD PRIMARY KEY (`tags_id`,`publication_source_id`),
  ADD KEY `fk_publications_source_tags__publication_source_id` (`publication_source_id`);

--
-- Indexes for table `publications_source__type_users`
--
ALTER TABLE `publications_source__type_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `publication_source_type` (`publication_source_type`,`person_id`) USING BTREE,
  ADD KEY `fk_publications_types__publication_person_id` (`person_id`);

--
-- Indexes for table `publications_user`
--
ALTER TABLE `publications_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_publications_id` (`publication_id`),
  ADD KEY `fk_project_render_id` (`project_render_item_id`),
  ADD KEY `fk_publications_user__user_id` (`owner_id`) USING BTREE;

--
-- Indexes for table `publication_task`
--
ALTER TABLE `publication_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_publication_task_source_status` (`publication_source_id`,`status`),
  ADD KEY `idx_publication_task_user_id` (`publication_user_id`) USING BTREE;

--
-- Indexes for table `putz_authority`
--
ALTER TABLE `putz_authority`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `putz_persistent_audit_event`
--
ALTER TABLE `putz_persistent_audit_event`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `idx__persistent_audit_event__principal__event_date` (`principal`,`event_date`) USING BTREE;

--
-- Indexes for table `putz_persistent_audit_evt_data`
--
ALTER TABLE `putz_persistent_audit_evt_data`
  ADD PRIMARY KEY (`event_id`,`name`),
  ADD KEY `idx__persistent_audit_evt_data__event_id` (`event_id`) USING BTREE;

--
-- Indexes for table `putz_user`
--
ALTER TABLE `putz_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_user_login` (`login`),
  ADD UNIQUE KEY `ux_user_email` (`email`);

--
-- Indexes for table `putz_user_authority`
--
ALTER TABLE `putz_user_authority`
  ADD PRIMARY KEY (`user_id`,`authority_name`),
  ADD KEY `fk_authority_name` (`authority_name`);

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rel_product_type__groups`
--
ALTER TABLE `rel_product_type__groups`
  ADD PRIMARY KEY (`product_type_id`,`groups_id`),
  ADD KEY `fk_rel_product_type__groups__groups_id` (`groups_id`);

--
-- Indexes for table `rel_product_type__tags`
--
ALTER TABLE `rel_product_type__tags`
  ADD PRIMARY KEY (`product_type_id`,`tags_id`),
  ADD KEY `fk_rel_product_type__tags__tags_id` (`tags_id`);

--
-- Indexes for table `satisfaction_survey`
--
ALTER TABLE `satisfaction_survey`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_satisfaction_survey__project_id` (`project_id`),
  ADD KEY `fk_satisfaction_survey__question_id` (`question_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedule_step`
--
ALTER TABLE `schedule_step`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_schedule_step__schedule_id` (`schedule_id`);

--
-- Indexes for table `smart_websummit_rio`
--
ALTER TABLE `smart_websummit_rio`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `subscriptions_subscription_plan_id` (`subscription_plan_id`);

--
-- Indexes for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_type` (`name`,`tag_type`);

--
-- Indexes for table `timeline_attachment`
--
ALTER TABLE `timeline_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_timeline_attachment__event_id` (`event_id`);

--
-- Indexes for table `timeline_comment`
--
ALTER TABLE `timeline_comment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_timeline_comment__root_comment_id` (`root_comment_id`),
  ADD KEY `fk_timeline_comment__event_id` (`event_id`),
  ADD KEY `fk_timeline_comment__created_by` (`created_by`);

--
-- Indexes for table `timeline_event`
--
ALTER TABLE `timeline_event`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ux_timeline_event__root_event_id` (`root_event_id`),
  ADD KEY `fk_timeline_event__project_step_id` (`project_step_id`),
  ADD KEY `fk_timeline_event__project_item_id` (`project_item_id`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `fk_render_transaction__project_id` (`project_id`),
  ADD KEY `fk_transaction__person_id` (`person_id`),
  ADD KEY `fk_transaction__related_transaction_id` (`related_transaction_id`),
  ADD KEY `fk_transaction__project_item_id` (`project_item_id`),
  ADD KEY `fk_transaction__subscription_id` (`subscription_id`);

--
-- Indexes for table `transaction_coupon`
--
ALTER TABLE `transaction_coupon`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un_code_hash` (`code_hash`),
  ADD KEY `fk_render_code__render_id` (`project_render_id`),
  ADD KEY `fk_render_code__render_transaction` (`transaction_id`),
  ADD KEY `fk_render_code__project_id` (`project_id`),
  ADD KEY `fk_render_code__person_id` (`person_id`),
  ADD KEY `fk_render_code__person_owner_id` (`person_owner_id`),
  ADD KEY `fk_transaction_code__publication_user_id` (`publications_user_id`),
  ADD KEY `fk_transaction_code__render_Item_id` (`project_render_item_id`);

--
-- Indexes for table `transaction_coupon_remover`
--
ALTER TABLE `transaction_coupon_remover`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `un_code_hash` (`code_hash`),
  ADD KEY `fk_render_code__render_id` (`project_render_id`),
  ADD KEY `fk_render_code__render_transaction` (`transaction_id`),
  ADD KEY `fk_render_code__project_id` (`project_id`),
  ADD KEY `fk_render_code__person_id` (`person_id`),
  ADD KEY `fk_render_code__person_owner_id` (`person_owner_id`);

--
-- Indexes for table `transaction_remover`
--
ALTER TABLE `transaction_remover`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `fk_render_transaction__project_id` (`project_id`),
  ADD KEY `fk_transaction__person_id` (`person_id`),
  ADD KEY `fk_transaction__related_transaction_id` (`related_transaction_id`),
  ADD KEY `fk_transaction__project_item_id` (`project_item_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asset_category`
--
ALTER TABLE `asset_category`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_item`
--
ALTER TABLE `asset_item`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_retail_product`
--
ALTER TABLE `asset_retail_product`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_retail_supplier`
--
ALTER TABLE `asset_retail_supplier`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_retail_unit`
--
ALTER TABLE `asset_retail_unit`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_startup`
--
ALTER TABLE `asset_startup`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_voice_speaker`
--
ALTER TABLE `asset_voice_speaker`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `asset_voice_voiceover`
--
ALTER TABLE `asset_voice_voiceover`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `competence`
--
ALTER TABLE `competence`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `competence_guide`
--
ALTER TABLE `competence_guide`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `config_params`
--
ALTER TABLE `config_params`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias`
--
ALTER TABLE `franquias`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__expansao_interesse`
--
ALTER TABLE `franquias__expansao_interesse`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__investimentos_franquia`
--
ALTER TABLE `franquias__investimentos_franquia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__premiacoes`
--
ALTER TABLE `franquias__premiacoes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__redes_franquia`
--
ALTER TABLE `franquias__redes_franquia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__redes_sociais`
--
ALTER TABLE `franquias__redes_sociais`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__requisitos_franquia`
--
ALTER TABLE `franquias__requisitos_franquia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__segmentos`
--
ALTER TABLE `franquias__segmentos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__sub_segmentos`
--
ALTER TABLE `franquias__sub_segmentos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__taxas_franquia`
--
ALTER TABLE `franquias__taxas_franquia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `franquias__unidades`
--
ALTER TABLE `franquias__unidades`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ibge__city`
--
ALTER TABLE `ibge__city`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ibge_id';

--
-- AUTO_INCREMENT for table `ibge__name`
--
ALTER TABLE `ibge__name`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ibge__name_frequency`
--
ALTER TABLE `ibge__name_frequency`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ibge__name_group`
--
ALTER TABLE `ibge__name_group`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ibge__name_render`
--
ALTER TABLE `ibge__name_render`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ibge__uf`
--
ALTER TABLE `ibge__uf`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_whatsapp`
--
ALTER TABLE `notification_whatsapp`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `openai_assistants`
--
ALTER TABLE `openai_assistants`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `openai_conclusions`
--
ALTER TABLE `openai_conclusions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `page_faq`
--
ALTER TABLE `page_faq`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `person`
--
ALTER TABLE `person`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `person_references`
--
ALTER TABLE `person_references`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portfolio`
--
ALTER TABLE `portfolio`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_competence`
--
ALTER TABLE `product_competence`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_group`
--
ALTER TABLE `product_group`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_type`
--
ALTER TABLE `product_type`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_calc`
--
ALTER TABLE `project_calc`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Project_ID';

--
-- AUTO_INCREMENT for table `project_item`
--
ALTER TABLE `project_item`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_item_request`
--
ALTER TABLE `project_item_request`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_payment`
--
ALTER TABLE `project_payment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_render`
--
ALTER TABLE `project_render`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_render_group_name`
--
ALTER TABLE `project_render_group_name`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_render_item`
--
ALTER TABLE `project_render_item`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_render_log`
--
ALTER TABLE `project_render_log`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_step`
--
ALTER TABLE `project_step`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publications`
--
ALTER TABLE `publications`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publications_source`
--
ALTER TABLE `publications_source`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publications_source__type_users`
--
ALTER TABLE `publications_source__type_users`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publications_user`
--
ALTER TABLE `publications_user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `publication_task`
--
ALTER TABLE `publication_task`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `putz_persistent_audit_event`
--
ALTER TABLE `putz_persistent_audit_event`
  MODIFY `event_id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `putz_user`
--
ALTER TABLE `putz_user`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `question`
--
ALTER TABLE `question`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `satisfaction_survey`
--
ALTER TABLE `satisfaction_survey`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule_step`
--
ALTER TABLE `schedule_step`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscription_plans`
--
ALTER TABLE `subscription_plans`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timeline_attachment`
--
ALTER TABLE `timeline_attachment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timeline_comment`
--
ALTER TABLE `timeline_comment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `timeline_event`
--
ALTER TABLE `timeline_event`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_coupon`
--
ALTER TABLE `transaction_coupon`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_coupon_remover`
--
ALTER TABLE `transaction_coupon_remover`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_remover`
--
ALTER TABLE `transaction_remover`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `asset_category`
--
ALTER TABLE `asset_category`
  ADD CONSTRAINT `fk_asset_category___root_category` FOREIGN KEY (`root_category_id`) REFERENCES `asset_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asset_category__users`
--
ALTER TABLE `asset_category__users`
  ADD CONSTRAINT `fk_asset_category_users__category_id` FOREIGN KEY (`categories_id`) REFERENCES `asset_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_asset_category_users__user_id` FOREIGN KEY (`person_id`) REFERENCES `putz_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asset_item__categories`
--
ALTER TABLE `asset_item__categories`
  ADD CONSTRAINT `fk_asset_item__categories__asset_item_id` FOREIGN KEY (`asset_item_id`) REFERENCES `asset_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_asset_item__categories__category_id` FOREIGN KEY (`category_id`) REFERENCES `asset_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asset_item__voice_overs`
--
ALTER TABLE `asset_item__voice_overs`
  ADD CONSTRAINT `fk_asset_item__voice_over__item_id` FOREIGN KEY (`asset_item_id`) REFERENCES `asset_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_asset_item__voice_over__voiceover_id` FOREIGN KEY (`voice_overs_id`) REFERENCES `asset_voice_voiceover` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asset_retail_product`
--
ALTER TABLE `asset_retail_product`
  ADD CONSTRAINT `fk_asset_retail_product__default_suppliew_id` FOREIGN KEY (`default_supplier_id`) REFERENCES `asset_retail_supplier` (`id`),
  ADD CONSTRAINT `fk_asset_retail_product__default_unit_id` FOREIGN KEY (`default_unit_id`) REFERENCES `asset_retail_unit` (`id`);

--
-- Constraints for table `asset_retail_product__categories`
--
ALTER TABLE `asset_retail_product__categories`
  ADD CONSTRAINT `fk_rel_asset_retail_product__ca__asset_retail_product_49_id` FOREIGN KEY (`asset_retail_product_id`) REFERENCES `asset_retail_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rel_asset_retail_product__categories__categories_id` FOREIGN KEY (`categories_id`) REFERENCES `asset_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asset_retail_product__voice_overs`
--
ALTER TABLE `asset_retail_product__voice_overs`
  ADD CONSTRAINT `fk_rel_asset_retail_product__vo__asset_retail_product_98_id` FOREIGN KEY (`asset_retail_product_id`) REFERENCES `asset_retail_product` (`id`),
  ADD CONSTRAINT `fk_rel_asset_retail_product__voice_overs__voice_overs_id` FOREIGN KEY (`voice_overs_id`) REFERENCES `asset_voice_voiceover` (`id`);

--
-- Constraints for table `asset_startup`
--
ALTER TABLE `asset_startup`
  ADD CONSTRAINT `fk_asset_startup__category_id` FOREIGN KEY (`category_id`) REFERENCES `asset_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `asset_voice_voiceover`
--
ALTER TABLE `asset_voice_voiceover`
  ADD CONSTRAINT `fk_asset_voice_voiceover__category_id` FOREIGN KEY (`category_id`) REFERENCES `asset_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_asset_voice_voiceover__speaker_id` FOREIGN KEY (`speaker_id`) REFERENCES `asset_voice_speaker` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `competence_guide`
--
ALTER TABLE `competence_guide`
  ADD CONSTRAINT `fk_competence_guide__competence_id` FOREIGN KEY (`competence_id`) REFERENCES `competence` (`id`);

--
-- Constraints for table `franquias`
--
ALTER TABLE `franquias`
  ADD CONSTRAINT `franquias_ibfk_1` FOREIGN KEY (`segmento_id`) REFERENCES `franquias__segmentos` (`id`),
  ADD CONSTRAINT `franquias_ibfk_2` FOREIGN KEY (`rede_id`) REFERENCES `franquias__redes_franquia` (`id`);

--
-- Constraints for table `franquias__expansao_interesse`
--
ALTER TABLE `franquias__expansao_interesse`
  ADD CONSTRAINT `franquias__expansao_interesse_ibfk_1` FOREIGN KEY (`franquia_id`) REFERENCES `franquias` (`id`);

--
-- Constraints for table `franquias__investimentos_franquia`
--
ALTER TABLE `franquias__investimentos_franquia`
  ADD CONSTRAINT `franquias__investimentos_franquia_ibfk_1` FOREIGN KEY (`franquia_id`) REFERENCES `franquias` (`id`);

--
-- Constraints for table `franquias__premiacoes`
--
ALTER TABLE `franquias__premiacoes`
  ADD CONSTRAINT `franquias__premiacoes_ibfk_1` FOREIGN KEY (`franquia_id`) REFERENCES `franquias` (`id`);

--
-- Constraints for table `franquias__redes_sociais`
--
ALTER TABLE `franquias__redes_sociais`
  ADD CONSTRAINT `franquias__redes_sociais_ibfk_1` FOREIGN KEY (`franquia_id`) REFERENCES `franquias` (`id`);

--
-- Constraints for table `franquias__requisitos_franquia`
--
ALTER TABLE `franquias__requisitos_franquia`
  ADD CONSTRAINT `franquias__requisitos_franquia_ibfk_1` FOREIGN KEY (`franquia_id`) REFERENCES `franquias` (`id`);

--
-- Constraints for table `franquias__sub_segmentos`
--
ALTER TABLE `franquias__sub_segmentos`
  ADD CONSTRAINT `franquias__sub_segmentos_ibfk_1` FOREIGN KEY (`segmento_id`) REFERENCES `franquias__segmentos` (`id`);

--
-- Constraints for table `franquias__taxas_franquia`
--
ALTER TABLE `franquias__taxas_franquia`
  ADD CONSTRAINT `franquias__taxas_franquia_ibfk_1` FOREIGN KEY (`franquia_id`) REFERENCES `franquias` (`id`);

--
-- Constraints for table `franquias__unidades`
--
ALTER TABLE `franquias__unidades`
  ADD CONSTRAINT `franquias__unidades_ibfk_1` FOREIGN KEY (`franquia_id`) REFERENCES `franquias` (`id`);

--
-- Constraints for table `ibge__city`
--
ALTER TABLE `ibge__city`
  ADD CONSTRAINT `fk_ibge_city__uf_id` FOREIGN KEY (`uf_id`) REFERENCES `ibge__uf` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `ibge__name`
--
ALTER TABLE `ibge__name`
  ADD CONSTRAINT `fk_ibge_name__ibge_group_name` FOREIGN KEY (`name_group_id`) REFERENCES `ibge__name_group` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `ibge__name_frequency`
--
ALTER TABLE `ibge__name_frequency`
  ADD CONSTRAINT `fk_name_frequency__uf_id` FOREIGN KEY (`uf_id`) REFERENCES `ibge__uf` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_nomes_frequency__name_id` FOREIGN KEY (`name_id`) REFERENCES `ibge__name` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `ibge__name_render`
--
ALTER TABLE `ibge__name_render`
  ADD CONSTRAINT `fk_name_render __ibge_name` FOREIGN KEY (`ibge_name_id`) REFERENCES `ibge__name` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_name_render __project_render` FOREIGN KEY (`project_render_id`) REFERENCES `project_render` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `notification_whatsapp`
--
ALTER TABLE `notification_whatsapp`
  ADD CONSTRAINT `fk_notification_whatsapp__event_id` FOREIGN KEY (`time_line_event_id`) REFERENCES `timeline_event` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notification_whatsapp__person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_notification_whatsapp__render_id` FOREIGN KEY (`project_render_item_id`) REFERENCES `project_render_item` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `person`
--
ALTER TABLE `person`
  ADD CONSTRAINT `fk_person__company_id` FOREIGN KEY (`company_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `person_references`
--
ALTER TABLE `person_references`
  ADD CONSTRAINT `fk_person__person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `portfolio`
--
ALTER TABLE `portfolio`
  ADD CONSTRAINT `fk_portfolio__competence_id` FOREIGN KEY (`competence_id`) REFERENCES `competence` (`id`),
  ADD CONSTRAINT `fk_portfolio__person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `portfolio__tags`
--
ALTER TABLE `portfolio__tags`
  ADD CONSTRAINT `fk_rel_portfolio__tags__portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolio` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rel_portfolio__tags__tags_id` FOREIGN KEY (`tags_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_product__products_id` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`);

--
-- Constraints for table `product_competence`
--
ALTER TABLE `product_competence`
  ADD CONSTRAINT `fk_product_competence__competence_id` FOREIGN KEY (`competence_id`) REFERENCES `competence` (`id`),
  ADD CONSTRAINT `fk_product_competence__product_id` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `fk_project__agency_id` FOREIGN KEY (`agency_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project__cancel_user_id` FOREIGN KEY (`cancel_user_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project__client_id` FOREIGN KEY (`client_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project__manager_id` FOREIGN KEY (`manager_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project__root_project_id` FOREIGN KEY (`root_project_id`) REFERENCES `project` (`id`),
  ADD CONSTRAINT `fk_project__vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `project_calc`
--
ALTER TABLE `project_calc`
  ADD CONSTRAINT `fk_projectcalc__id` FOREIGN KEY (`id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_case`
--
ALTER TABLE `project_case`
  ADD CONSTRAINT `FK_project_case__project` FOREIGN KEY (`id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_item`
--
ALTER TABLE `project_item`
  ADD CONSTRAINT `fk_project_item__freelancer_id` FOREIGN KEY (`freelancer_id`) REFERENCES `person` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project_item__item_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project_item__project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project_item__project_step_id` FOREIGN KEY (`project_step_id`) REFERENCES `project_step` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `project_item_request`
--
ALTER TABLE `project_item_request`
  ADD CONSTRAINT `fk_project_item_request__freelancer_id` FOREIGN KEY (`freelancer_id`) REFERENCES `person` (`id`),
  ADD CONSTRAINT `fk_project_item_request__project_item_id` FOREIGN KEY (`project_item_id`) REFERENCES `project_item` (`id`);

--
-- Constraints for table `project_payment`
--
ALTER TABLE `project_payment`
  ADD CONSTRAINT `fk_project_payment__project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`);

--
-- Constraints for table `project_render_group_name`
--
ALTER TABLE `project_render_group_name`
  ADD CONSTRAINT `fk_project_render_group_name__group_name_id` FOREIGN KEY (`ibge_name_group_id`) REFERENCES `ibge__name_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project_render_group_name__render_id` FOREIGN KEY (`render_id`) REFERENCES `project_render` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_render_item`
--
ALTER TABLE `project_render_item`
  ADD CONSTRAINT `fk_project_render_item__person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project_render_item__project_render_id` FOREIGN KEY (`render_project_id`) REFERENCES `project_render` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `project_render_log`
--
ALTER TABLE `project_render_log`
  ADD CONSTRAINT `fk_project_render_log__render_item_id` FOREIGN KEY (`project_render_item_id`) REFERENCES `project_render_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `project_step`
--
ALTER TABLE `project_step`
  ADD CONSTRAINT `fk_project_step__project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_project_step__step_id` FOREIGN KEY (`step_id`) REFERENCES `schedule_step` (`id`);

--
-- Constraints for table `project__tags`
--
ALTER TABLE `project__tags`
  ADD CONSTRAINT `fk_rel_project__tags__project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rel_project__tags__tags_id` FOREIGN KEY (`tags_id`) REFERENCES `tag` (`id`);

--
-- Constraints for table `publications`
--
ALTER TABLE `publications`
  ADD CONSTRAINT `fk_publications__publication_source_id` FOREIGN KEY (`publications_source_id`) REFERENCES `publications_source` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `publications_source__tags`
--
ALTER TABLE `publications_source__tags`
  ADD CONSTRAINT `fk_publications_source_tags__publication_source_id` FOREIGN KEY (`publication_source_id`) REFERENCES `publications_source` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_publications_source_tags__tags_id` FOREIGN KEY (`tags_id`) REFERENCES `tag` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `publications_source__type_users`
--
ALTER TABLE `publications_source__type_users`
  ADD CONSTRAINT `fk_publications_types__publication_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `publications_user`
--
ALTER TABLE `publications_user`
  ADD CONSTRAINT `fk_project_render_id` FOREIGN KEY (`project_render_item_id`) REFERENCES `project_render_item` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_publications_id` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_publications_user_requester` FOREIGN KEY (`owner_id`) REFERENCES `putz_user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `publication_task`
--
ALTER TABLE `publication_task`
  ADD CONSTRAINT `fk_publication_task_source_id` FOREIGN KEY (`publication_source_id`) REFERENCES `publications_source` (`id`);

--
-- Constraints for table `putz_persistent_audit_evt_data`
--
ALTER TABLE `putz_persistent_audit_evt_data`
  ADD CONSTRAINT `fk_evt_pers_audit_evt_data` FOREIGN KEY (`event_id`) REFERENCES `putz_persistent_audit_event` (`event_id`);

--
-- Constraints for table `putz_user_authority`
--
ALTER TABLE `putz_user_authority`
  ADD CONSTRAINT `fk_authority_name` FOREIGN KEY (`authority_name`) REFERENCES `putz_authority` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `putz_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rel_product_type__groups`
--
ALTER TABLE `rel_product_type__groups`
  ADD CONSTRAINT `fk_rel_product_type__groups__groups_id` FOREIGN KEY (`groups_id`) REFERENCES `product_group` (`id`),
  ADD CONSTRAINT `fk_rel_product_type__groups__product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`);

--
-- Constraints for table `rel_product_type__tags`
--
ALTER TABLE `rel_product_type__tags`
  ADD CONSTRAINT `fk_rel_product_type__tags__product_type_id` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`id`),
  ADD CONSTRAINT `fk_rel_product_type__tags__tags_id` FOREIGN KEY (`tags_id`) REFERENCES `tag` (`id`);

--
-- Constraints for table `satisfaction_survey`
--
ALTER TABLE `satisfaction_survey`
  ADD CONSTRAINT `fk_satisfaction_survey__project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  ADD CONSTRAINT `fk_satisfaction_survey__question_id` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`);

--
-- Constraints for table `schedule_step`
--
ALTER TABLE `schedule_step`
  ADD CONSTRAINT `fk_schedule_step__schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`id`);

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `putz_user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `subscriptions_subscription_plan_id` FOREIGN KEY (`subscription_plan_id`) REFERENCES `subscription_plans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `timeline_attachment`
--
ALTER TABLE `timeline_attachment`
  ADD CONSTRAINT `fk_timeline_attachment__event_id` FOREIGN KEY (`event_id`) REFERENCES `timeline_event` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `timeline_comment`
--
ALTER TABLE `timeline_comment`
  ADD CONSTRAINT `fk_timeline_comment__created_by` FOREIGN KEY (`created_by`) REFERENCES `putz_user` (`login`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_timeline_comment__event_id` FOREIGN KEY (`event_id`) REFERENCES `timeline_event` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_timeline_comment__root_comment_id` FOREIGN KEY (`root_comment_id`) REFERENCES `timeline_comment` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `timeline_event`
--
ALTER TABLE `timeline_event`
  ADD CONSTRAINT `fk_timeline_event__project_item_id` FOREIGN KEY (`project_item_id`) REFERENCES `project_item` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_timeline_event__project_step_id` FOREIGN KEY (`project_step_id`) REFERENCES `project_step` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_timeline_event__root_event_id` FOREIGN KEY (`root_event_id`) REFERENCES `timeline_event` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `fk_transaction__person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction__project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction__project_item_id` FOREIGN KEY (`project_item_id`) REFERENCES `project_item` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction__related_transaction_id` FOREIGN KEY (`related_transaction_id`) REFERENCES `transaction` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction__subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `transaction_coupon`
--
ALTER TABLE `transaction_coupon`
  ADD CONSTRAINT `fk_transaction_code__person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_code__person_owner_id` FOREIGN KEY (`person_owner_id`) REFERENCES `person` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_code__project_id` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_transaction_code__publication_user_id` FOREIGN KEY (`publications_user_id`) REFERENCES `publications_user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_code__render_id` FOREIGN KEY (`project_render_id`) REFERENCES `project_render` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_transaction_code__render_Item_id` FOREIGN KEY (`project_render_item_id`) REFERENCES `project_render_item` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_transaction_code__render_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
