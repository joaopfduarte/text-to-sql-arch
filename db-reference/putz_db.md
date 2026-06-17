## Table of contents




- 1 DATABASECHANGELOG Page number:
- 2 DATABASECHANGELOGLOCK Page number:
- 3 asset_category Page number:
- 4 asset_category__users Page number:
- 5 asset_item Page number:
- 6 asset_item__categories Page number:
- 7 asset_item__voice_overs Page number:
- 8 asset_retail_product Page number:
- 9 asset_retail_product__categories Page number:
- 10 asset_retail_product__voice_overs Page number:
- 11 asset_retail_supplier Page number:
- 12 asset_retail_unit Page number:
- 13 asset_startup Page number:
- 14 asset_voice_speaker Page number:
- 15 asset_voice_voiceover Page number:
- 16 competence Page number:
- 17 competence_guide Page number:
- 18 config_params Page number:
- 19 franquias Page number:
- 20 franquias__expansao_interesse Page number:
- 21 franquias__investimentos_franquia Page number:
- 22 franquias__premiacoes Page number:
- 23 franquias__redes_franquia Page number:
- 24 franquias__redes_sociais Page number:
- 25 franquias__requisitos_franquia Page number:
- 26 franquias__segmentos Page number:
- 27 franquias__sub_segmentos Page number:
- 28 franquias__taxas_franquia Page number:
- 29 franquias__unidades Page number:
- 30 ibge__city Page number:
- 31 ibge__name Page number:
- 32 ibge__name_frequency Page number:
- 33 ibge__name_group Page number:
- 34 ibge__name_render Page number:
- 35 ibge__uf Page number:
- 36 ibge_name_group_sum Page number:
- 37 ibge_names_and_frequency Page number:
- 38 notification_whatsapp Page number:
- 39 openai_assistants Page number:
- 40 openai_conclusions Page number:
- 41 page_faq Page number:
- 42 person Page number:
- 43 person_references Page number:
- 44 portfolio Page number:
- 45 portfolio__tags Page number:
- 46 product Page number:
- 47 product_competence Page number:
- 48 product_group Page number:
- 49 product_type Page number:
- 50 project Page number:
- 51 project__tags Page number:
- 52 project_calc Page number:
- 53 project_case Page number:
- 54 project_item Page number:
- 55 project_item_request Page number:
- 56 project_payment Page number:
- 57 project_render Page number:
- 58 project_render_group_name Page number:
- 59 project_render_item Page number:
- 60 project_render_log Page number:
- 61 project_render_user Page number:
- 62 project_step Page number:
- 63 publication_task Page number:
- 64 publications Page number:
- 65 publications_complete Page number:
- 66 publications_source Page number:
- 67 publications_source__tags Page number:
- 68 publications_source__type_users Page number:
- 69 publications_user Page number:
- 70 putz_authority Page number:
- 71 putz_persistent_audit_event Page number:
- 72 putz_persistent_audit_evt_data Page number:
- 73 putz_user Page number:
- 74 putz_user_authority Page number:
- 75 question Page number:
- 76 rel_product_type__groups Page number:
- 77 rel_product_type__tags Page number:
- 78 render_item_resume Page number:
- 79 satisfaction_survey Page number:
- 80 schedule Page number:
- 81 schedule_step Page number:
- 82 smart_websummit_rio Page number:
- 83 subscription_plans Page number:
- 84 subscriptions Page number:
- 85 tag Page number:
- 86 timeline_attachment Page number:
- 87 timeline_comment Page number:
- 88 timeline_event Page number:
- 89 transaction Page number:
- 90 transaction_coupon Page number:
- 91 transaction_coupon_remover Page number:
- 92 transaction_remover Page number:
- 93 Relational schema Page number:


# 1 DATABASECHANGELOG

Creation: Apr 28, 2026 at 11:47 PM
Last update: May 08, 2026 at 04:17 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
ID varchar(
)

```
No
```
AUTHOR varchar(
)

```
No
```
FILENAME varchar(
)

```
No
```
DATEEXECUTED datetime No
ORDEREXECUT
ED

```
int No
```
EXECTYPE varchar(10) No
MD5SUM varchar(35) Yes NULL
DESCRIPTION varchar(
)

```
Yes NULL
```
COMMENTS varchar(
)

```
Yes NULL
```
TAG varchar(
)

```
Yes NULL
```
LIQUIBASE varchar(20) Yes NULL
CONTEXTS varchar(
)

```
Yes NULL
```
LABELS varchar(
)

```
Yes NULL
```
### DEPLOYMENT_I

### D

```
varchar(10) Yes NULL
```

# 2 DATABASECHANGELOGLOCK

Creation: Apr 28, 2026 at 11:47 PM
Last update: May 08, 2026 at 04:17 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
ID int No
LOCKED bit(1) No
LOCKGRANTED datetime Yes NULL
LOCKEDBY varchar(
)

```
Yes NULL
```

# 3 asset_category

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
slug varchar(64) No
root_category_i
d

```
bigint Yes NULL -> asset_category.id
ON UPDATE CASCADE
ON DELETE CASCADE
```
category_type varchar(64) Yes NULL
description varchar(
)

```
Yes NULL
```
is_public bit(1) Yes b'0'
is_active bit(1) Yes b'1'
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 4 asset_category__users

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
categories_id bigint No -> asset_category.id
ON UPDATE CASCADE
ON DELETE CASCADE

person_id bigint No -> putz_user.id
ON UPDATE CASCADE
ON DELETE CASCADE


# 5 asset_item

Table comments: Assets Genéricos para Vïdeos
Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(
)

```
No
```
lettering varchar(
)

```
Yes NULL
```
small_descriptio
n

```
varchar(
)
```
```
No
```
phonetic varchar(
)

```
Yes NULL
```
item_order int No 0
slug varchar(
)

```
No
```
video_check_st
atus

```
enum('CHEC
KED', 'NOT_
CHECKED', '
AUTOCHECK
ED')
```
```
No AUTOCHECK
ED
```
json_data varchar(
8)

```
Yes NULL
```
description varchar(
)

```
Yes NULL
```
resource_url varchar(
)

```
Yes NULL
```
resource_type enum('LETT
ERING',
'VIDEO',
'AUDIO',
'IMAGE',
'COMPANY')

```
Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 6 asset_item__categories

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
category_id bigint No -> asset_category.id
ON UPDATE CASCADE
ON DELETE CASCADE

asset_item_id bigint No -> asset_item.id
ON UPDATE CASCADE
ON DELETE CASCADE


# 7 asset_item__voice_overs

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
voice_overs_id bigint No -> asset_voice_voiceover.id
ON UPDATE CASCADE
ON DELETE CASCADE

asset_item_id bigint No -> asset_item.id
ON UPDATE CASCADE
ON DELETE CASCADE


# 8 asset_retail_product

Table comments: Produtos de Varejo\n@author [redacted]
Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(
)

```
No
```
small_descriptio
n

```
varchar(
)
```
```
No Seria Lettering
```
phonetic varchar(
)

```
No
```
slug varchar(
)

```
No
```
json_data varchar(
8)

```
Yes NULL
```
default_unit_id bigint No -> asset_retail_unit.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

default_supplier
_id

```
bigint Yes NULL -> asset_retail_supplier.id
ON UPDATE RESTRICT
ON DELETE RESTRICT
```
description varchar(
)

```
Yes NULL
```
resource_type varchar(32) Yes NULL
resource_url varchar(
)

```
Yes NULL
```
scene_type varchar(
)

```
Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 9 asset_retail_product__categories

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
categories_id bigint No -> asset_category.id
ON UPDATE CASCADE
ON DELETE CASCADE

asset_retail_pro
duct_id

```
bigint No -> asset_retail_product.id
ON UPDATE CASCADE
ON DELETE CASCADE
```

# 10 asset_retail_product__voice_overs

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
voice_overs_id bigint No -> asset_voice_voiceover.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

asset_retail_pro
duct_id

```
bigint No -> asset_retail_product.id
ON UPDATE RESTRICT
ON DELETE RESTRICT
```

# 11 asset_retail_supplier

Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
phonetic varchar(64) No
slug varchar(32) No
description varchar(
)

```
Yes NULL
```
image_url varchar(
)

```
Yes NULL
```
image_alt_url varchar(
)

```
Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 12 asset_retail_unit

Table comments: Unidades pra um Produto de Varejo\n@author [redacted]
Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
slug varchar(32) No
lettering varchar(64) No
description varchar(
)

```
Yes NULL
```
is_active bit(1) No
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 13 asset_startup

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
appearance_id varchar(
)

```
Yes NULL
```
pitch_deck_url varchar(
)

```
Yes NULL
```
track varchar(64) Yes NULL
company_id varchar(
)

```
Yes NULL
```
company_name varchar(
)

```
No
```
elevator_pitch varchar(
)

```
Yes NULL
```
country_name varchar(64) No
logo_url varchar(
)

```
Yes NULL
```
homepage_url varchar(
)

```
Yes NULL
```
instagram_url varchar(
)

```
Yes NULL
```
linkedin_url varchar(
)

```
Yes NULL
```
facebook_url varchar(
)

```
Yes NULL
```
category_id bigint Yes NULL -> asset_category.id
ON UPDATE CASCADE
ON DELETE CASCADE

industry_id varchar(
)

```
Yes NULL
```
industry_name varchar(
)

```
Yes NULL
```
stand_number varchar(64) Yes NULL
time_json varchar(
)

```
Yes NULL
```
team_1_id varchar(
)

```
Yes NULL
```
team_1_name varchar(
)

```
Yes NULL
```
team_1_avatar varchar(
)

```
Yes NULL
```

team_1_job varchar(
)

```
Yes NULL
```
team_2_id varchar(
)

```
Yes NULL
```
team_2_name varchar(
)

```
Yes NULL
```
team_2_avatar varchar(
)

```
Yes NULL
```
team_2_job varchar(
)

```
Yes NULL
```
team_3_id varchar(
)

```
Yes NULL
```
team_3_name varchar(
)

```
Yes NULL
```
team_3_avatar varchar(
)

```
Yes NULL
```
team_3_job varchar(
)

```
Yes NULL
```
team_4_id varchar(
)

```
Yes NULL
```
team_4_name varchar(
)

```
Yes NULL
```
team_4_avatar varchar(
)

```
Yes NULL
```
team_4_job varchar(
)

```
Yes NULL
```
team_5_id varchar(
)

```
Yes NULL
```
team_5_name varchar(
)

```
Yes NULL
```
team_5_avatar varchar(
)

```
Yes NULL
```
team_5_job varchar(
)

```
Yes NULL
```
team_6_id varchar(
)

```
Yes NULL
```
team_6_name varchar(
)

```
Yes NULL
```
team_6_avatar varchar(
)

```
Yes NULL
```
team_6_job varchar(
)

```
Yes NULL
```
team_7_id varchar(
)

```
Yes NULL
```
team_7_name varchar(
)

```
Yes NULL
```
team_7_avatar varchar(
)

```
Yes NULL
```

team_7_job varchar(
)

```
Yes NULL
```
is_active bit(1) Yes b'1'
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 14 asset_voice_speaker

Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
slug varchar(32) No
description varchar(
)

```
Yes NULL
```
eleven_labs_id varchar(64) Yes NULL
is_active bit(1) Yes NULL
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 15 asset_voice_voiceover

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(128
)

```
No
```
description varchar(204
8)

```
Yes NULL
```
slug varchar(128
)

```
No
```
speaker_id bigint No -> asset_voice_speaker.id
ON UPDATE CASCADE
ON DELETE CASCADE

category_id bigint No -> asset_category.id
ON UPDATE CASCADE
ON DELETE CASCADE

phonetic varchar(204
8)

```
No
```
voiceover_time decimal(6,2) Yes NULL
voiceover_time_
raw

```
decimal(6,2) Yes NULL
```
voiceover_time_
type

```
int Yes NULL
```
voiceover_url varchar(256
)

```
Yes NULL
```
audiobitrate varchar(16) Yes NULL
is_active bit(1) Yes NULL
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 16 competence

Table comments: Start Portfolio Pack
Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
description varchar(512
)

```
Yes NULL
```
icon_url varchar(128
)

```
Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 17 competence_guide

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
competence_id bigint No -> competence.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

level enum('BANK
', 'JUNIOR', '
PROFISSION
AL',
'ADVANCED'
,
'COPYRIGHT'
)

```
No
```
name varchar(64) No
slug varchar(64) No
description varchar(512
)

```
Yes NULL
```
mark_down longblob Yes NULL
html_page longblob Yes NULL
file_link varchar(512
)

```
Yes NULL
```
file longblob Yes NULL
file_content_typ
e

```
varchar(255
)
```
```
Yes NULL
```
is_active bit(1) Yes b'1'
is_verified bit(1) Yes b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 18 config_params

Table comments: End Project Pack
Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) Yes NULL
slug varchar(64) No
description varchar(512
)

```
Yes NULL
```
config_params_
type

```
enum('TWILI
O_NUMBER',
'EMAIL', 'PR
OJECT_INSU
RANCE', 'PR
OJECT_PAYM
ENT', 'PROJE
CT_PROFIT_
TARGET',
'OTHER', 'PR
OJECT_PRIO
RITY', 'REND
ER_BOT', 'P
ROJECT_REB
ATE',
'TRIBUTES', '
MAX_COMMI
SSION', 'TWI
LIO_ACCOU
NT_SID', 'TW
ILIO_AUTH_T
OKEN', 'FRE
E_SOURCES'
, 'WHATSAP
P_ALERTS')
```
```
No
```
value varchar(256
)

```
Yes NULL
```
json_value varchar(102
4)

```
Yes NULL
```

is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 19 franquias

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
nome varchar(255
)

```
No
```
nome_fantasia varchar(255
)

```
Yes NULL
```
razao_social varchar(255
)

```
Yes NULL
```
segmento_id int Yes NULL -> franquias__segmentos.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

rede_id int Yes NULL ->
franquias__redes_franquia.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

data_coleta datetime Yes NULL
ultima_atualiza
cao

```
datetime Yes NULL
```

# 20 franquias__expansao_interesse

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
franquia_id int Yes NULL -> franquias.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

estado varchar(2) Yes NULL
cidade varchar(100
)

```
Yes NULL
```
prioridade int Yes NULL
status varchar(50) Yes NULL


# 21 franquias__investimentos_franquia

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
franquia_id int Yes NULL -> franquias.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

tipo_investimen
to

```
varchar(100
)
```
```
Yes NULL
```
valor_minimo decimal(12,
2)

```
Yes NULL
```
valor_maximo decimal(12,
2)

```
Yes NULL
```
descricao text Yes NULL
data_atualizaca
o

```
datetime Yes NULL
```

# 22 franquias__premiacoes

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
franquia_id int Yes NULL -> franquias.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

nome_premiaca
o

```
varchar(255
)
```
```
Yes NULL
```
instituicao varchar(255
)

```
Yes NULL
```
ano int Yes NULL
categoria varchar(255
)

```
Yes NULL
```
colocacao varchar(50) Yes NULL


# 23 franquias__redes_franquia

Creation: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
nome varchar(255
)

```
No
```
cnpj varchar(14) Yes NULL
ano_fundacao int Yes NULL
ano_inicio_franc
hising

```
int Yes NULL
```
site_oficial varchar(255
)

```
Yes NULL
```
descricao text Yes NULL


# 24 franquias__redes_sociais

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
franquia_id int Yes NULL -> franquias.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

tipo varchar(50) Yes NULL
url varchar(255
)

```
Yes NULL
```
usuario varchar(100
)

```
Yes NULL
```

# 25 franquias__requisitos_franquia

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
franquia_id int Yes NULL -> franquias.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

area_minima int Yes NULL
area_maxima int Yes NULL
quantidade_min
ima_funcionario
s

```
int Yes NULL
```
experiencia_pre
via

```
tinyint(1) Yes NULL
```
exclusividade tinyint(1) Yes NULL
prazo_contrato int Yes NULL


# 26 franquias__segmentos

Creation: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
nome varchar(100
)

```
No
```
descricao text Yes NULL


# 27 franquias__sub_segmentos

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
segmento_id int Yes NULL -> franquias__segmentos.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

nome varchar(100
)

```
No
```
descricao text Yes NULL


# 28 franquias__taxas_franquia

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
franquia_id int Yes NULL -> franquias.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

taxa_franquia decimal(10,
2)

```
Yes NULL
```
royalties_perce
ntual

```
decimal(5,2) Yes NULL
```
royalties_valor decimal(10,
2)

```
Yes NULL
```
taxa_publicidad
e_percentual

```
decimal(5,2) Yes NULL
```
taxa_publicidad
e_valor

```
decimal(10,
2)
```
```
Yes NULL
```
outras_taxas text Yes NULL


# 29 franquias__unidades

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id int No auto_increment
franquia_id int Yes NULL -> franquias.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

tipo varchar(50) Yes NULL
estado varchar(2) Yes NULL
cidade varchar(100
)

```
Yes NULL
```
data_inaugurac
ao

```
datetime Yes NULL
```
status varchar(50) Yes NULL


# 30 ibge__city

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment ibge_id
name varchar(100
)

```
No
```
latitude float No
longitude float No
is_capital tinyint(1) No
uf_id bigint No -> ibge__uf.id
ON UPDATE CASCADE
ON DELETE RESTRICT

siafi_id varchar(4) No
ddd int No
time_zone varchar(32) No
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 31 ibge__name

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
first_name varchar(22) No
classification enum('M',
'F', 'N', 'O')

```
No
```
frequency_fema
le

```
int Yes NULL
```
frequency_male int Yes NULL
frequency_total int Yes NULL
name_group_id
_calc

```
varchar(22) Yes NULL
```
name_group_id bigint Yes NULL -> ibge__name_group.id
ON UPDATE CASCADE
ON DELETE RESTRICT

is_perfect_grou
p

```
bit(1) No b'0'
```
is_name_check
ed

```
bit(1) Yes NULL Se nome já foi checado
```
frequency_grou
p

```
int Yes NULL
```
request_counte
r

```
int UNSIGNED No 0
```
name_type enum('NAM
E',
'SURNAME',
'NICKNAME')

```
Yes NAME
```
ratio double(5,3) No 0.000
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 32 ibge__name_frequency

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name_id bigint No -> ibge__name.id
ON UPDATE CASCADE
ON DELETE RESTRICT

name_id_calc varchar(22) No
gender enum('M',
'F', 'N', 'O')

```
No
```
uf_id bigint No -> ibge__uf.id
ON UPDATE CASCADE
ON DELETE RESTRICT

f_frequency int No -1 Frenquencia Basica da API
f_rank int No -1 ranking pelo IBGE
f_total int No Soma dos F_Decadas
f_1930 int UNSIGNED No
f_19301940 int UNSIGNED No
f_19401950 int UNSIGNED No
f_19501960 int UNSIGNED No
f_19601970 int UNSIGNED No
f_19701980 int UNSIGNED No
f_19801990 int UNSIGNED No
f_19902000 int UNSIGNED No
f_20002010 int UNSIGNED No
is_active bit(1) No b'1'
created_date datetime Yes CURRENT_TI
MESTAMP

### DEFAULT_GENE

### RATED

last_modified_d
ate

```
datetime Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 33 ibge__name_group

Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(22) No
phonetic varchar(24) Yes NULL
group_type enum('MAIN
', 'EXTRA',
'OLD')

```
No EXTRA
```
classification enum('M',
'F', 'N', 'O')

```
No
```
frequency_fema
le

```
int No
```
frequency_male int No
frequency_total int No
ratio double(9,3) No
names varchar(700
0)

```
Yes NULL
```
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 34 ibge__name_render

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(22) No
project_render_i
d

```
bigint No -> project_render.id
ON UPDATE RESTRICT
ON DELETE RESTRICT
```
counter int No
ibge_name_id bigint Yes NULL -> ibge__name.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

ibge_name_id_c
alc

```
varchar(22) Yes NULL
```
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 35 ibge__uf

Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
uf varchar(2) No
id_ibge bigint No
name varchar(100
)

```
No
```
latitude float No
longitude float No
region varchar(12) No
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 36 ibge_name_group_sum

Table comments: VIEW
Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No 0
name varchar(22) No
gender varchar(1) No
frequency_fema
le

```
decimal(32,
0)
```
```
Yes NULL
```
frequency_male decimal(32,
0)

```
Yes NULL
```
frequency_total decimal(32,
0)

```
Yes NULL
```
ratio decimal(36,
4)

```
Yes NULL
```
names text Yes NULL


# 37 ibge_names_and_frequency

Table comments: VIEW
Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
first_name varchar(22) No
f_frequency int Yes -1 Frenquencia Basica da API
f_male decimal(32,
0)

```
Yes NULL
```
f_female decimal(32,
0)

```
Yes NULL
```
gender varchar(1) No
ratio decimal(36,
4)

```
Yes NULL
```

# 38 notification_whatsapp

Creation: May 08, 2026 at 04:17 AM
Last update: May 12, 2026 at 12:59 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint UNSIGNED No auto_increment
putz_hash varchar(64) Yes NULL
sid varchar(64) Yes NULL
name varchar(64) Yes NULL
body text Yes NULL
notification_dire
ction

```
varchar(32) Yes NULL
```
phone_from varchar(64) Yes NULL
phone_to varchar(64) Yes NULL
reference varchar(64) Yes NULL
reference_chatb
ot

```
varchar(64) Yes NULL
```
notification_typ
e

```
varchar(32) Yes NULL
```
answer varchar(102
4)

```
Yes NULL
```
reply varchar(102
4)

```
Yes NULL
```
whatsapp_msg_
type

```
varchar(64) Yes NULL
```
error_message varchar(128
)

```
Yes NULL
```
error_code int Yes NULL
price_unit varchar(32) Yes NULL
price varchar(32) Yes NULL
uri varchar(128
)

```
Yes NULL
```
account_sid varchar(64) Yes NULL
notification_stat
us

```
varchar(32) Yes NULL
```
messaging_serv
ice_sid

```
varchar(64) Yes NULL
```
api_version varchar(16) Yes NULL
media_url varchar(256
)

```
Yes NULL
```
date_scheduled datetime(6) Yes NULL
date_queued datetime(6) Yes NULL
date_sent datetime(6) Yes NULL


date_failed datetime(6) Yes NULL
date_delivered datetime(6) Yes NULL
date_read datetime(6) Yes NULL
date_answer datetime(6) Yes NULL
date_updated datetime(6) Yes NULL
person_id bigint Yes NULL -> person.id
ON UPDATE RESTRICT
ON DELETE CASCADE

data_source longtext Yes NULL
time_line_event
_id

```
bigint Yes NULL -> timeline_event.id
ON UPDATE RESTRICT
ON DELETE CASCADE
```
project_render_i
tem_id

```
bigint Yes NULL -> project_render_item.id
ON UPDATE RESTRICT
ON DELETE CASCADE
```
is_active bit(1) Yes NULL Removed?
created_date timestamp Yes CURRENT_TI
MESTAMP

### DEFAULT_GENE

### RATED

created_by varchar(64) Yes NULL
last_modified_d
ate

```
timestamp Yes NULL
```
last_modified_b
y

```
varchar(64) Yes NULL
```
retry_count int Yes 0
last_attempt_da
te

```
datetime Yes NULL
```

# 39 openai_assistants

Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(128
)

```
Yes NULL
```
slug varchar(64) No
assistants_id varchar(64) No
model varchar(64) Yes NULL
temperature double Yes NULL
top_p double Yes NULL
max_output_tok
ens

```
bigint Yes NULL
```
response_sche
ma

```
json Yes NULL
```
instruction longtext No
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 40 openai_conclusions

Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
sid varchar(128
)

```
No
```
openai_function varchar(64) No
ask text No
slug varchar(128
)

```
No
```
is_active bit(1) No b'1'
user_id bigint No
description varchar(512
)

```
Yes NULL
```
json_conclusion json Yes NULL
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) No
```
created_by varchar(64) No
last_modified_b
y

```
varchar(64) No
```

# 41 page_faq

Creation: Apr 28, 2026 at 11:47 PM
Last update: Apr 28, 2026 at 11:47 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint UNSIGNED No auto_increment
ask varchar(512
)

```
Yes NULL
```
slug varchar(64) No
answer varchar(800
0)

```
Yes NULL
```
item_index int Yes NULL
page_type varchar(64) Yes NULL
is_active bit(1) Yes NULL Removed?
created_date timestamp Yes CURRENT_TI
MESTAMP

### DEFAULT_GENE

### RATED

created_by varchar(64) Yes NULL
last_modified_d
ate

```
timestamp Yes NULL
```
last_modified_b
y

```
varchar(64) Yes NULL
```

# 42 person

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 29, 2026 at 12:01 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
slug varchar(64) Yes NULL Remover
email varchar(128
)

```
Yes NULL Remover
```
current_balance double Yes 0
is_active bit(1) No b'1'
company_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT

company_type varchar(64) Yes OTHER
name_fantasy varchar(512
)

```
Yes NULL
```
cpf_cnpj varchar(64) Yes NULL
rg_doc varchar(64) Yes NULL
birthday date Yes NULL
lastaccess datetime(6) Yes NULL
avatar varchar(255
)

```
Yes NULL
```
avatar_content_
type

```
varchar(255
)
```
```
Yes NULL
```
person_type varchar(255
)

```
Yes NULL
```
gender varchar(2) Yes NULL
pix_key varchar(128
)

```
Yes NULL
```
pix_key_type varchar(32) Yes NULL
thread_id varchar(128
)

```
Yes NULL
```
active_chat bit(1) No b'1' Chatbottwillio ativo
instruction_ope
nai

```
varchar(204
8)
```
```
Yes NULL
```
phone varchar(16) Yes NULL
phone_cel varchar(16) Yes NULL
phone_whatsap
p

```
varchar(16) Yes NULL
```
phone_whatsap
p_verification

```
datetime Yes NULL
```

address_zip_co
de

```
varchar(10) Yes NULL
```
address_locatio
n

```
varchar(128
)
```
```
Yes NULL
```
address_numbe
r

```
varchar(10) Yes NULL
```
address_comple
ment

```
varchar(64) Yes NULL
```
address_district varchar(64) Yes NULL
address_city varchar(64) Yes NULL
address_uf varchar(255
)

```
Yes NULL
```
address_countr
y

```
varchar(255
)
```
```
Yes NULL
```
social_linkedin varchar(64) Yes NULL
social_web varchar(255
)

```
Yes NULL
```
social_instagra
m

```
varchar(64) Yes NULL
```
social_pinterest varchar(64) Yes NULL
reference varchar(32) Yes NULL
commission double No 0
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 43 person_references

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
person_id bigint No -> person.id
ON UPDATE CASCADE
ON DELETE CASCADE


reference_nam
e

```
enum('FACE
BOOK',
'LINKEDIN', '
FACEBOOK_
PAGES',
'GITHUB', 'G
OOGLE_LOG
IN', 'DINAMI
ZE_ID', 'FAC
EBOOK_LOG
IN',
'LYTEX_ID',
'RD_ID', 'LIN
KEDIN_PAGE
S', 'GITHUB_
LOGIN', 'TWI
TTER_LOGIN
',
'APPLE_ID', '
SMART_COD
E', 'REFERE
NCE_PERSO
N_ID', 'RD_O
PPORTUNITY
_ID', 'RD_CLI
ENT_ID', 'RD
_CONTACT_I
D', 'RD_USE
R_ID', 'FACE
BOOK_DEFA
ULT', 'LINKE
DIN_DEFAUL
T', 'INSTAGR
AM_DEFAUL
T', 'MANDAT
ORY_ASSET
S_MISSING')
```
```
No
```
reference_value text No
reference_extra varchar(256
)

```
Yes NULL
```
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL


last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 44 portfolio

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
person_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT

competence_id bigint Yes NULL -> competence.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

level enum('BANK
', 'JUNIOR', '
PROFISSION
AL',
'ADVANCED'
,
'COPYRIGHT'
)

```
No
```
name varchar(64) No
description varchar(512
)

```
Yes NULL
```
rank_agility int Yes 0
rank_creativity int Yes 0
rank_deadline int Yes 0
rank_quality int Yes 0
rank_remaking int Yes 0
file_link varchar(512
)

```
No
```
file longblob Yes NULL
file_content_typ
e

```
varchar(255
)
```
```
Yes NULL
```
is_active bit(1) No b'1'
request_status varchar(255
)

```
No SUBSCRIBE
D
```
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 45 portfolio__tags

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
tags_id bigint No -> tag.id
ON UPDATE CASCADE
ON DELETE CASCADE

portfolio_id bigint No -> portfolio.id
ON UPDATE CASCADE
ON DELETE CASCADE


# 46 product

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
product_type_id bigint No -> product_type.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

rd_id varchar(128
)

```
Yes NULL
```
level enum('BANK
', 'JUNIOR', '
PROFISSION
AL',
'ADVANCED'
,
'COPYRIGHT'
)

```
No
```
name varchar(64) No
description varchar(512
)

```
Yes NULL
```
price double Yes NULL
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 47 product_competence

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
competence_id bigint Yes NULL -> competence.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

product_type_id bigint Yes NULL -> product_type.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 48 product_group

Creation: Apr 28, 2026 at 11:48 PM
Last update: Apr 28, 2026 at 11:48 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
description varchar(512
)

```
Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 49 product_type

Creation: Apr 28, 2026 at 11:48 PM
Last update: Apr 28, 2026 at 11:48 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
description varchar(512
)

```
Yes NULL
```
unit varchar(64) Yes NULL
default_step_in
dex

```
int UNSIGNED No 1
```
is_active bit(1) Yes NULL
is_extra_item bit(1) No
price_factor double No 1
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 50 project

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) Yes NULL
slug varchar(64) Yes NULL
description varchar(204
8)

```
Yes NULL Escopo Público
```
internal_descrip
tion

```
varchar(204
8)
```
```
No Observaçòes Privadas
```
project_status enum('MOD
EL', 'CONCE
PTION',
'EXECUTION'
,
'CANCELED',
'CLOSE',
'BRIEFING',
'ARCHIVED',
'SMART')

```
No
```
approved_date_
by_client

```
datetime Yes NULL
```
approved_date_
by_putz

```
datetime Yes NULL
```
is_active bit(1) Yes NULL
video_time int Yes NULL
days int Yes NULL
change_max_nu
mber

```
int Yes NULL Número Máximo de Mudanças por Etapa
```
agreement_pdf_
link

```
varchar(512
)
```
```
Yes NULL
```
start_date datetime(6) Yes NULL
canceled_date datetime(6) Yes NULL
end_date datetime(6) Yes NULL
end_date_calc_
preview

```
datetime Yes NULL
```
difficulty_level int Yes NULL
video_url_low_r
es

```
varchar(512
)
```
```
Yes NULL
```
video_url_hi_res varchar(512
)

```
Yes NULL
```

priority_type varchar(64) No NO_PRIORIT
Y

priority_percent double No 0 Percentul de Urgencia
profit_target_pe
rcent

```
double No 0
```
insurance_type varchar(64) No NO_INSURA
NCE

insurance_perc
ent

```
double Yes NULL Valor do Seguro Urgencia %
```
agency_commis
sion_percent

```
double Yes NULL Comissão Agencia %
```
vendor_commis
sion_percent

```
double Yes NULL Comissão vendedor
```
sdr_commission
_percent

```
double No 0 Comissão destinada à SDR
```
tribute_percent double Yes NULL Impostos %
quantity int No 1
tribute_ancine double Yes NULL
payment_type varchar(64) No PAYMENT_D
EFAULT_50_
50

payment_factor
_percent

```
double No 0
```
rebate_subscrib
er_percent

```
double Yes NULL
```
rebate_subscrib
er_time

```
double Yes NULL
```
rebate_subscrib
er_plan

```
double Yes NULL
```
rebate_credits_
percent

```
double No 0 Desconto Créditos Agencia
```
rebate_waterm
ark_percent

```
double No 0 Desconto Marca Agencia
```
negotiation_reb
ate_percent

```
double No 0
```
rebate_commis
sion_percent

```
int No 0
```
is_render bit(1) Yes b'0'
payment_plan_i
d

```
bigint Yes NULL
```
agency_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT

cancel_user_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT


manager_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT

vendor_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT

client_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT

sdr_id bigint Yes NULL
root_project_id bigint Yes NULL -> project.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

rd_id varchar(128
)

```
Yes NULL
```
created_by varchar(64) Yes NULL
created_date datetime(6) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```
last_modified_d
ate

```
datetime(6) Yes NULL
```

# 51 project__tags

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
tags_id bigint No -> tag.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

project_id bigint No -> project.id
ON UPDATE CASCADE
ON DELETE CASCADE


# 52 project_calc

Table comments: @author [redacted]
Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment -> project.id
ON UPDATE CASCADE
ON DELETE CASCADE

```
Project_ID
```
tribute_value double No 0
agency_commis
sion_base_valu
e

```
double No 0
```
agency_commis
sion_rebate_val
ue

```
double No 0
```
agency_commis
sion_final_value

```
double No 0
```
vendor_commis
sion_base_valu
e

```
double Yes 0
```
vendor_commis
sion_rebate_val
ue

```
double Yes 0
```
vendor_commis
sion_final_value

```
double Yes 0
```
sdr_commission
_base_value

```
double Yes 0
```
sdr_commission
_rebate_value

```
double Yes 0
```
sdr_commission
_final_value

```
double Yes 0
```
priority_value double No 0
insurance_value double No 0
video_time_part
ial_percent

```
double Yes NULL
```
resume_commi
s_tax_profit_su
m_percent

```
double Yes NULL
```
items_sum double No 0 Soma dos Items de custo do Freelancer
items_base_su
m

```
double No 0 Soma dos Items de custo original do
Freelancer
```
items_extra_ba
se_sum

```
double No 0 Soma dos Items Extras de custo original do
Freelancer
```

items_sum_with
_priority

```
double Yes NULL
```
items_sum_with
_priority_plus_in
surance

```
double Yes NULL
```
items_cost_perc
entage

```
double Yes NULL
```
payment_factor
_value

```
double Yes NULL
```
rebate_subscrib
er_value

```
double Yes NULL
```
resume_total_a
gency_putz_reb
ate_percent

```
double Yes NULL
```
rebate_credits_
value

```
double Yes NULL
```
rebate_waterm
ark_value

```
double Yes NULL
```
resume_total_a
gency_rebate_p
ercent

```
double Yes NULL
```
final_extra_bud
get

```
double Yes NULL
```
final_price double No 0 Inclui forma de pagamento
final_costs double Yes NULL
final_profit double Yes NULL
profit_final_perc
ent

```
double Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 53 project_case

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No -> project.id
ON UPDATE CASCADE
ON DELETE CASCADE

name varchar(64) No
details varchar(204
8)

```
No
```
problem varchar(204
8)

```
No
```
solution varchar(204
8)

```
No
```
item_index int No
service_area_ty
pe

```
varchar(255
)
```
```
No OTHERS
```
is_active bit(1) Yes NULL
is_online bit(1) Yes NULL
video_url varchar(512
)

```
Yes NULL
```
video_thumbs varchar(512
)

```
Yes NULL
```
customer_name varchar(64) No
customer_comp
any

```
varchar(64) No
```
customer_exper
ience

```
varchar(512
)
```
```
No
```
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 54 project_item

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
project_id bigint Yes NULL -> project.id
ON UPDATE CASCADE
ON DELETE CASCADE

rd_id varchar(128
)

```
Yes NULL
```
project_step_id bigint Yes NULL -> project_step.id
ON UPDATE CASCADE
ON DELETE RESTRICT

product_id bigint Yes NULL -> product.id
ON UPDATE CASCADE
ON DELETE RESTRICT

name varchar(64) No
description varchar(512
)

```
Yes NULL
```
freelancer_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE RESTRICT

item_index int No
is_extra_item bit(1) No b'0'
price_factor double No 1
is_checked bit(1) Yes b'0'
is_active bit(1) No b'1'
is_public bit(1) No b'0'
quantity int UNSIGNED Yes 1
value_freela double No Valor Real Pago ao Freela
value_base double No Valor do usado no Orçamento
start_date datetime(6) Yes NULL Data prevista e de Início do Item.
first_commit_da
te

```
datetime(6) Yes NULL Data da primeira entrega parcial
```
expected_date datetime(6) Yes NULL Data prevista entrega do item
end_date datetime(6) Yes NULL Data da Aprovação do item
close_date datetime(6) Yes NULL Pagamento e encerramento do item
customer_rate int Yes NULL
manager_rate int Yes NULL
manager_comm
ent

```
varchar(512
)
```
```
Yes NULL
```
invoice_pdf varchar(512
)

```
Yes NULL
```

invoice_xml longtext Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 55 project_item_request

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
freelancer_id bigint Yes NULL -> person.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

project_item_id bigint Yes NULL -> project_item.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

description varchar(512
)

```
Yes NULL
```
freela_approved datetime(6) Yes NULL
is_active bit(1) Yes NULL
request_status varchar(255
)

```
Yes NULL
```
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 56 project_payment

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
project_id bigint Yes NULL -> project.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

description varchar(512
)

```
Yes NULL
```
is_active bit(1) Yes NULL
item_index int No
payment_date datetime(6) Yes NULL
payment_value double Yes NULL
payment_type varchar(255
)

```
Yes NULL
```
is_checke bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 57 project_render

Creation: Apr 29, 2026 at 12:02 PM
Last update: May 15, 2026 at 04:57 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) Yes NULL
short_descriptio
n

```
varchar(128
)
```
```
Yes NULL
```
description varchar(102
4)

```
Yes NULL
```
user_payment_t
ype

```
enum('FREE'
,
'FREE_FIRST
', 'FREE_REA
L_FIRST', '50
OFF_FIRST',
'CODE_MAN
AGER', 'COD
E_OR_PAYM
ENT', 'TEST')
```
```
No FREE
```
delivery_max_ti
me

```
enum('EXPR
ESS',
'NORMAL',
'HOURS2',
'HOURS5',
'HOURS8',
'HOURS16')
```
```
No EXPRESS
```
delivery_msg_js
on

```
varchar(102
8)
```
```
Yes NULL
```
render_slug varchar(64) Yes NULL
project_id bigint Yes NULL
owner_id bigint Yes NULL
json_template longtext Yes NULL
json_data_sourc
e

```
longtext Yes NULL
```
json_field_descr
iption

```
longtext Yes NULL Descrição dos Campos Select
```
priority int Yes 0
max_time int Yes NULL Tempo Máximo de Espera


instruction_ope
nai

```
varchar(204
8)
```
```
Yes NULL
```
whatsapp_bot varchar(64) Yes NULL
whatsapp_flow varchar(64) Yes NULL
sending_platfor
m

```
enum('TWILI
O', 'META',
'NONE')
```
```
No
```
avaliable_until datetime(6) Yes NULL
id_plataform varchar(256
)

```
Yes NULL
```
token_platafor
m

```
varchar(256
)
```
```
Yes NULL
```
whatsapp_no_cr
edit

```
varchar(102
4)
```
```
Yes NULL
```
whatsapp_autor
esponse

```
varchar(102
4)
```
```
Yes NULL
```
whatsapp_temp
late_service

```
longtext Yes NULL
```
whatsapp_welc
ome

```
varchar(102
4)
```
```
Yes NULL
```
whatsapp_wait varchar(102
4)

```
Yes NULL
```
whatsapp_finish varchar(102
4)

```
Yes NULL
```
whatsapp_shar
e

```
varchar(204
8)
```
```
Yes NULL
```
video_url_templ
ate

```
varchar(128
)
```
```
Yes NULL
```
thumb_url varchar(256
)

```
Yes NULL
```
video_url_exam
ple

```
varchar(128
)
```
```
Yes NULL
```
render_avg_tim
e

```
int Yes 1
```
videos_per_mon
th

```
int Yes NULL
```
videos_per_day int Yes NULL
number_of_item
s

```
int Yes NULL
```
render_main_url varchar(128
)

```
Yes NULL
```
whatsapp_bot_
welcome_media

```
varchar(256
)
```
```
Yes NULL
```
is_csv_render bit(1) No b'0'
is_active bit(1) Yes NULL
min_price double Yes NULL
max_price double Yes NULL


coupons_requir
ed

```
int No 1
```
pay_max_time int Yes 23 Tempo para pagamento do boleto
password_hash varchar(60) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 58 project_render_group_name

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
render_id bigint No -> project_render.id
ON UPDATE CASCADE
ON DELETE CASCADE

ibge_name_gro
up_id

```
bigint Yes NULL -> ibge__name_group.id
ON UPDATE CASCADE
ON DELETE CASCADE
```
name varchar(22) No Remover este campo ele é redundante do ID

record_status enum('APPR
OVED', 'SUB
SCRIBED',
'BACKUP',
'DECLINED',
'REPLACED')

```
No
```
is_active bit(1) No b'1'
created_date timestamp No CURRENT_TI
MESTAMP

### DEFAULT_GENE

### RATED

last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 59 project_render_item

Creation: Apr 29, 2026 at 12:02 PM
Last update: May 12, 2026 at 01:03 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
render_slug varchar(64) No
render_status varchar(64) Yes NULL
person_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE SET_NULL

render_project_i
d

```
bigint Yes NULL -> project_render.id
ON UPDATE CASCADE
ON DELETE RESTRICT
```
render_uid varchar(64) Yes NULL
render_count int Yes 0
type varchar(64) Yes default
origin varchar(128
)

```
Yes NULL
```
tracking varchar(512
)

```
Yes NULL
```
priority int Yes 0
name varchar(64) Yes NULL
description varchar(102
4)

```
Yes NULL
```
email varchar(128
)

```
Yes NULL
```
whatsapp varchar(64) Yes NULL
whatsapp_statu
s

```
enum('ERRO
R',
'DELIVERED'
, 'INVITED',
'WATING',
'CANCELED',
'EXPIRED')
```
```
Yes NULL
```
whatsapp_sent_
date

```
datetime(6) Yes NULL
```
render_progres
s

```
int Yes 0
```
encode_progres
s

```
int Yes 0
```
error varchar(256
)

```
Yes NULL
```

workpath varchar(256
)

```
Yes NULL
```
scriptfile varchar(256
)

```
Yes NULL
```
resultname varchar(128
)

```
Yes NULL
```
is_name_check
ed

```
bit(1) Yes b'0' Se nome já foi checado
```
output varchar(256
)

```
Yes NULL
```
description_has
h

```
varchar(172
)
```
```
Yes NULL
```
json_data longtext Yes NULL
data_source longtext Yes NULL
delivery_max_ti
me

```
enum('EXPR
ESS',
'NORMAL',
'HOURS2',
'HOURS5',
'HOURS8',
'HOURS16')
```
```
No EXPRESS
```
scheduled_to datetime(6) Yes NULL
delivery_msg_js
on

```
text Yes NULL
```
start_render_da
te

```
datetime(6) Yes NULL
```
expected_rende
r_date

```
datetime(6) Yes NULL
```
exported_date datetime(6) Yes NULL
end_render_dat
e

```
datetime(6) Yes NULL
```
video_check_st
atus

```
enum('CHEC
KED', 'NOT_
CHECKED', '
AUTOCHECK
ED')
```
```
No AUTOCHECK
ED
```
bot_name varchar(64) Yes NULL
video_url varchar(512
)

```
Yes NULL
```
video_file_size bigint Yes NULL
thumb_url varchar(512
)

```
Yes NULL
```
frames longtext Yes NULL
ia_update_date datetime Yes NULL data de uso de IA
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```

error_at datetime(6) Yes NULL
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 60 project_render_log

Table comments: Start Product Pack
Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
uid varchar(64) Yes NULL
project_render_i
tem_id

```
bigint Yes NULL -> project_render_item.id
ON UPDATE CASCADE
ON DELETE CASCADE
```
description varchar(204
8)

```
Yes NULL
```
bot_name varchar(64) Yes NULL
is_active bit(1) Yes b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 61 project_render_user

Table comments: VIEW
Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
person_id bigint No 0
project_render_i
d

```
bigint No 0
```
render_slug varchar(64) Yes NULL


# 62 project_step

Table comments: ProjectStep/Etapa\nRepresentação de uma única etapa de um projeto\n@author [redacted]
Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
project_id bigint Yes NULL -> project.id
ON UPDATE CASCADE
ON DELETE CASCADE

step_id bigint Yes NULL -> schedule_step.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

schedule_name varchar(64) No principal
is_main_schedu
le

```
bit(1) Yes b'0'
```
name varchar(64) No
description varchar(512
)

```
Yes NULL
```
item_index int No
days_freela int Yes NULL
days_extra int No 0
days_approv int No 0
days_total int No 0
start_date_expe
cted

```
timestamp Yes NULL
```
start_date datetime(6) Yes NULL
end_date_expec
ted

```
datetime(6) Yes NULL
```
end_date datetime(6) Yes NULL
is_active bit(1) Yes NULL
change_number int No 0
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 63 publication_task

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
publication_sou
rce_id

```
bigint Yes NULL -> publications_source.id
ON UPDATE RESTRICT
ON DELETE RESTRICT
```
publication_use
r_id

```
bigint Yes NULL
```
todo varchar(64) No
assistant varchar(64) Yes NULL
quantity int Yes NULL
render_news_ty
pe

```
varchar(64) Yes NULL
```
extra longtext Yes NULL
project_render_i
tem_id

```
bigint Yes NULL
```
status varchar(32) Yes NULL
attempts int Yes NULL
next_run_at datetime Yes NULL
priority int No
lock_until bigint Yes NULL
locked_by varchar(64) Yes NULL
start_date datetime Yes NULL
end_date datetime Yes NULL
error_message longtext Yes NULL
created_date datetime Yes NULL
last_modified_d
ate

```
datetime Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 64 publications

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
publications_so
urce_id

```
bigint Yes NULL -> publications_source.id
ON UPDATE CASCADE
ON DELETE CASCADE
```
source_type varchar(64) Yes NULL
platform varchar(64) Yes NULL
cache_post_use
r

```
longtext Yes NULL
```
url varchar(512
)

```
Yes NULL
```
json_data longtext No
news_time varchar(64) Yes NULL
is_active bit(1) No b'1'
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) No
```
created_by varchar(64) No
last_modified_b
y

```
varchar(64) No
```

# 65 publications_complete

Table comments: VIEW
Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No 0
publications_so
urce_id

```
bigint Yes NULL
```
source_type varchar(64) Yes NULL
platform varchar(64) Yes NULL
json_data longtext No
url varchar(512
)

```
Yes NULL
```
news_time varchar(64) Yes NULL
published_at datetime(6) Yes NULL
title varchar(256
)

```
Yes NULL
```
main_image varchar(256
)

```
Yes NULL
```
tags text Yes NULL


# 66 publications_source

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
title varchar(256
)

```
No
```
to_do longtext Yes NULL
status enum('CREA
TED',
'FINISHED', '
ALL_STARTE
D', 'ERROR',
'FINISHED_E
RROR',
'STARTED', '
PRECREATE
D',
'CANCELED')

```
Yes NULL
```
check_status enum('CHEC
KED', 'NOT_
CHECKED', '
AUTOCHECK
ED')

```
No NOT_CHECK
ED
```
images longtext Yes NULL
published_at datetime(6) Yes NULL
author_id bigint Yes NULL
content longtext Yes NULL
source_type varchar(64) Yes NULL
main_image varchar(256
)

```
Yes NULL
```
project_render_i
tem_ids

```
varchar(256
)
```
```
Yes NULL
```
section varchar(64) Yes NULL
section_slug varchar(64) Yes NULL
link varchar(512
)

```
Yes NULL
```
type varchar(64) No
json_data longtext No
attempt_count int No 0


is_active bit(1) No b'1'
cached_tags varchar(512
)

```
Yes NULL
```
person_id bigint Yes NULL
message_error longtext Yes NULL
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) No
```
created_by varchar(64) No
last_modified_b
y

```
varchar(64) No
```

# 67 publications_source__tags

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
tags_id bigint No -> tag.id
ON UPDATE CASCADE
ON DELETE CASCADE

publication_sou
rce_id

```
bigint No -> publications_source.id
ON UPDATE CASCADE
ON DELETE CASCADE
```
created_date timestamp No CURRENT_TI
MESTAMP

### DEFAULT_GENE

### RATED


# 68 publications_source__type_users

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
person_id bigint No -> person.id
ON UPDATE CASCADE
ON DELETE CASCADE

publication_sou
rce_type

```
enum('ECO
MMERCE', 'C
ONTABILIDA
DE', 'G1',
'ESTETICA', '
CONSTRUCA
O',
'FARMACIA',
'FINANCENE
WS')
```
```
No
```
is_active tinyint(1) No 1
created_date datetime(6) Yes NULL
created_by varchar(64) No
last_modified_b
y

```
varchar(64) No
```
last_modified_d
ate

```
datetime(6) Yes NULL
```

# 69 publications_user

Creation: Apr 28, 2026 at 11:50 PM
Last update: May 04, 2026 at 03:27 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
to_do longtext Yes NULL
requester_id bigint No
owner_id bigint Yes NULL -> putz_user.id
ON UPDATE CASCADE
ON DELETE SET_NULL

publication_id bigint Yes NULL -> publications.id
ON UPDATE CASCADE
ON DELETE CASCADE

project_render_i
tem_id

```
bigint Yes NULL -> project_render_item.id
ON UPDATE CASCADE
ON DELETE CASCADE
```
post_id varchar(64) Yes NULL
status varchar(64) No
publication_dat
e

```
datetime(6) Yes NULL
```
json_publication longtext Yes NULL
error_descriptio
n

```
longtext Yes NULL
```
app_id varchar(128
)

```
Yes NULL
```
page_id varchar(128
)

```
Yes NULL
```
access_token varchar(128
)

```
Yes NULL
```
platform varchar(64) Yes NULL
is_active bit(1) No b'1'
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 70 putz_authority

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
name varchar(50) No
description varchar(102
4)

```
Yes NULL
```

# 71 putz_persistent_audit_event

Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
event_id bigint No auto_increment
principal varchar(50) No
event_date timestamp Yes NULL
event_type varchar(255
)

```
Yes NULL
```

# 72 putz_persistent_audit_evt_data

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
event_id bigint No -> putz_persistent_audit_even
t.event_id
ON UPDATE RESTRICT
ON DELETE RESTRICT

name varchar(150
)

```
No
```
value varchar(255
)

```
Yes NULL
```

# 73 putz_user

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 29, 2026 at 12:01 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
login varchar(50) No
first_name varchar(50) Yes NULL
last_name varchar(50) Yes NULL
email varchar(191
)

```
No
```
provider varchar(64) Yes local
provider_id varchar(128
)

```
Yes NULL
```
image_url varchar(256
)

```
Yes NULL
```
password_hash varchar(60) No
danger_pass varchar(128
)

```
Yes NULL
```
activated bit(1) No
lang_key varchar(10) Yes NULL
activation_key varchar(20) Yes NULL
reset_key varchar(60) Yes NULL
created_by varchar(50) No
created_date timestamp Yes NULL
reset_date timestamp Yes NULL
last_modified_b
y

```
varchar(50) Yes NULL
```
last_modified_d
ate

```
timestamp Yes NULL
```
old_id varchar(128
)

```
Yes NULL Antigo ID c#
```
old_passhash varchar(128
)

```
Yes NULL Antiga PassHash
```

# 74 putz_user_authority

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
user_id bigint No -> putz_user.id
ON UPDATE CASCADE
ON DELETE CASCADE

authority_name varchar(50) No -> putz_authority.name
ON UPDATE CASCADE
ON DELETE RESTRICT


# 75 question

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) Yes NULL
description varchar(512
)

```
Yes NULL
```
content_value varchar(64) Yes NULL
question_type varchar(255
)

```
No
```
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 76 rel_product_type__groups

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
groups_id bigint No -> product_group.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

product_type_id bigint No -> product_type.id
ON UPDATE RESTRICT
ON DELETE RESTRICT


# 77 rel_product_type__tags

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
tags_id bigint No -> tag.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

product_type_id bigint No -> product_type.id
ON UPDATE RESTRICT
ON DELETE RESTRICT


# 78 render_item_resume

Table comments: VIEW
Creation: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No 0
render_slug varchar(64) No
render_status varchar(64) Yes NULL
NAME varchar(64) Yes NULL
description varchar(102
4)

```
Yes NULL
```
whatsapp varchar(64) Yes NULL
data_source longtext Yes NULL
video_url varchar(512
)

```
Yes NULL
```

# 79 satisfaction_survey

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) Yes NULL
description varchar(512
)

```
Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```
project_id bigint Yes NULL -> project.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

question_id bigint Yes NULL -> question.id
ON UPDATE RESTRICT
ON DELETE RESTRICT


# 80 schedule

Table comments: Schedule/Cronograma\nRepresentação de um modelo de cronograma com etapas\n@author [redacted]
Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) Yes NULL
description varchar(512
)

```
Yes NULL
```
days int Yes NULL
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 81 schedule_step

Table comments: Step/ConfiguracaoEtapa\nEtapa de cronograma modelo\n@author [redacted]
Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
schedule_id bigint Yes NULL -> schedule.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

name varchar(64) No
description varchar(512
)

```
Yes NULL
```
item_index int No
icon_url varchar(128
)

```
Yes NULL
```
icon_progress_u
rl

```
varchar(128
)
```
```
Yes NULL
```
icon_finish_url varchar(128
)

```
Yes NULL
```
is_active bit(1) Yes NULL
days int Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 82 smart_websummit_rio

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id varchar(128
)

```
No
```
name varchar(102
4)

```
Yes NULL
```
avatar_url_large varchar(102
4)

```
Yes NULL
```
avatar_url_medi
um

```
varchar(102
4)
```
```
Yes NULL
```
country varchar(64) Yes NULL
elevatorPitch varchar(102
4)

```
Yes NULL
```
track varchar(16) Yes NULL
industry varchar(64) Yes NULL


# 83 subscription_plans

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
plan_name varchar(100
)

```
No
```
plan_category enum('SPON
SOR', 'OLD',
'CUSTOMER'
, 'ACCOUNTI
NG',
'OTHERS')

```
No
```
publication_sou
rce_type

```
enum('ECO
MMERCE', 'C
ONTABILIDA
DE', 'G1',
'ESTETICA', '
CONSTRUCA
O',
'FARMACIA',
'FINANCENE
WS')
```
```
Yes NULL
```
description varchar(204
8)

```
No
```
description_sho
rt

```
varchar(64) Yes NULL
```
description_ite
ms

```
varchar(102
4)
```
```
Yes NULL
```
auto_renew tinyint(1) Yes 0
credit_days int No
meses int No
is_active tinyint(1) No 1
json_credit_det
ails

```
varchar(204
8)
```
```
No
```
json_payment_d
etails

```
varchar(204
8)
```
```
No
```
amount_paid decimal(10,
2)

```
No
```
discount decimal(10,
2)

```
Yes 0.00
```

id_external varchar(128
)

```
Yes NULL
```
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 84 subscriptions

Creation: Apr 28, 2026 at 11:50 PM
Last update: May 16, 2026 at 05:00 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
user_id bigint No -> putz_user.id
ON UPDATE RESTRICT
ON DELETE CASCADE

subscription_pla
n_id

```
bigint No -> subscription_plans.id
ON UPDATE CASCADE
ON DELETE CASCADE
```
plan_name varchar(100
)

```
No
```
auto_renew tinyint(1) Yes 0
start_date date No
end_date date No
is_active tinyint(1) No 1
amount_credits varchar(204
8)

```
Yes 0
```
amount_paid decimal(10,
2)

```
No
```
discount decimal(10,
2)

```
Yes 0.00
```
transaction_id bigint Yes NULL -> transaction.id
ON UPDATE RESTRICT
ON DELETE SET_NULL

subscription_id_
external

```
varchar(128
)
```
```
Yes NULL
```
subscription_sta
tus

```
enum('ACTI
VE',
'EXPIRED',
'CANCELED',
'PENDING')
```
```
Yes PENDING
```
created_date datetime(6) No
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 85 tag

Table comments: Start Product Pack
Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
name varchar(64) No
description varchar(512
)

```
Yes NULL
```
tag_type varchar(32) No OTHER
is_active bit(1) Yes NULL
relevance int No 0 Campo Calculado com o úmero de vezes que
a tag foi usada
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 86 timeline_attachment

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
event_id bigint Yes NULL -> timeline_event.id
ON UPDATE CASCADE
ON DELETE CASCADE

name varchar(256
)

```
No
```
extension varchar(128
)

```
Yes NULL
```
link varchar(256
)

```
Yes NULL
```
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 87 timeline_comment

Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
event_id bigint Yes NULL -> timeline_event.id
ON UPDATE CASCADE
ON DELETE CASCADE

description varchar(102
4)

```
No
```
is_visible bit(1) Yes NULL
is_active bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL -> putz_user.login
ON UPDATE CASCADE
ON DELETE RESTRICT

last_modified_b
y

```
varchar(64) Yes NULL
```
root_comment_i
d

```
bigint Yes NULL -> timeline_comment.id
ON UPDATE CASCADE
ON DELETE RESTRICT
```

# 88 timeline_event

Table comments: Start TimeLine Pack
Creation: Apr 28, 2026 at 11:50 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
title varchar(64) No
project_step_id bigint Yes NULL -> project_step.id
ON UPDATE CASCADE
ON DELETE CASCADE

project_item_id bigint Yes NULL -> project_item.id
ON UPDATE CASCADE
ON DELETE RESTRICT

description varchar(204
8)

```
Yes NULL
```
event_type enum('TOPI
C',
'COMMIT',
'REQUEST',
'SOLVED',
'APPROVED',
'PARTIAL')

```
No COMMIT
```
is_visible bit(1) Yes b'1'
is_active bit(1) Yes b'1'
conclusion_date datetime(6) Yes NULL
conclusion_title varchar(64) Yes NULL
conclusion_desc
ription

```
varchar(307
2)
```
```
Yes NULL
```
customer_rate int Yes NULL
is_approved bit(1) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```
root_event_id bigint Yes NULL -> timeline_event.id
ON UPDATE CASCADE
ON DELETE RESTRICT


# 89 transaction

Creation: Apr 28, 2026 at 11:50 PM
Last update: May 06, 2026 at 04:00 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
transaction_id varchar(256
)

```
Yes NULL Id único
```
person_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE CASCADE

amount double No
project_id bigint Yes NULL -> project.id
ON UPDATE CASCADE
ON DELETE SET_NULL

project_item_id bigint Yes NULL -> project_item.id
ON UPDATE CASCADE
ON DELETE RESTRICT

subscription_id bigint Yes NULL -> subscriptions.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

payment_motiv
ation

```
varchar(64) Yes NULL
```
qtd int Yes NULL
payment varchar(32) Yes NULL
status enum('WAIT
ING_PAYME
NT',
'SUCCESS',
'NO_PAY',
'SCHEDULE
D', 'ERROR')

```
No
```
is_active bit(1) No b'1'
description varchar(256
)

```
Yes NULL
```
description_sho
rt

```
varchar(64) Yes NULL
```
operation enum('CRED
IT', 'DEBIT')

```
Yes NULL
```
methods_paym
ent

```
enum('LYTE
X', 'TICKET',
'PUTZ')
```
```
Yes NULL
```
entry_date datetime(6) Yes NULL


expiration_date datetime(6) Yes NULL
finished_codes bit(1) No
related_transac
tion_id

```
bigint Yes NULL -> transaction.id
ON UPDATE CASCADE
ON DELETE RESTRICT
```
transaction_has
h

```
varchar(256
)
```
```
Yes NULL
```
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 90 transaction_coupon

Creation: Apr 28, 2026 at 11:50 PM
Last update: May 16, 2026 at 02:00 AM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
person_owner_i
d

```
bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE SET_NULL
```
```
Pessoa que Comprou o Cupom, não
necessariamente quem usou
```
person_id bigint Yes NULL -> person.id
ON UPDATE CASCADE
ON DELETE CASCADE

```
Pessoa que usou o cupom
```
code_hash varchar(16) No
discount_perce
ntual

```
decimal(8,2) Yes NULL
```
discount_absolu
te

```
decimal(8,2) Yes NULL
```
coupon_type enum('STOR
IES_VIDEOS'
, 'FEED_VID
EOS',
'OTHER',
'NATAL')

```
No OTHER
```
transaction_id bigint Yes NULL -> transaction.id
ON UPDATE RESTRICT
ON DELETE RESTRICT

project_render_i
d

```
bigint Yes NULL -> project_render.id
ON UPDATE RESTRICT
ON DELETE RESTRICT
```
project_id bigint Yes NULL -> project.id
ON UPDATE RESTRICT
ON DELETE RESTRICT


code_status enum('AVAI
LABLE', 'PR
OMOTIONAL
', 'WAITING_
PAYMENT',
'USED',
'GIFT_CODE'
, 'EXPIRED',
'WAITING_VI
DEO',
'OTHER')

```
No
```
reference_coup
om

```
varchar(128
)
```
```
Yes NULL
```
project_render_i
tem_id

```
bigint Yes NULL -> project_render_item.id
ON UPDATE CASCADE
ON DELETE RESTRICT
```
publications_us
er_id

```
bigint Yes NULL -> publications_user.id
ON UPDATE CASCADE
ON DELETE RESTRICT
```
is_active bit(1) No b'1'
expiration_date datetime(6) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 91 transaction_coupon_remover

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
person_owner_i
d

```
bigint Yes NULL Pessoa que Comprou o Cupom, não
necessariamente quem usou
```
person_id bigint Yes NULL Pessoa que usou o cupom
code_hash varchar(16) No
discount_perce
ntual

```
decimal(8,2) Yes NULL
```
discount_absolu
te

```
decimal(8,2) Yes NULL
```
transaction_id bigint Yes NULL
project_render_i
d

```
bigint Yes NULL
```
project_id bigint Yes NULL
code_status enum('AVAI
LABLE', 'PR
OMOTIONAL
', 'WAITING_
PAYMENT',
'USED',
'GIFT_CODE'
, 'EXPIRED',
'WAITING_VI
DEO',
'OTHER')

```
No
```
reference_coup
om

```
varchar(128
)
```
```
Yes NULL
```
project_render_i
tem_id

```
bigint Yes NULL
```
is_active bit(1) No b'1'
expiration_date datetime(6) Yes NULL
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

# 92 transaction_remover

Creation: Apr 28, 2026 at 11:49 PM
Last update: Apr 28, 2026 at 11:49 PM

```
Column Type Attributes Null Default Extra Links to Comments MIME
```
id bigint No auto_increment
transaction_id varchar(256
)

```
Yes NULL Id único
```
person_id bigint Yes NULL
amount double No
project_id bigint Yes NULL
project_item_id bigint Yes NULL
payment_motiv
ation

```
varchar(64) Yes NULL
```
qtd int Yes NULL
payment varchar(32) Yes NULL
status enum('WAIT
ING_PAYME
NT',
'SUCCESS',
'NO_PAY',
'SCHEDULE
D', 'ERROR')

```
No
```
is_active bit(1) No b'1'
description varchar(256
)

```
Yes NULL
```
operation enum('CRED
IT', 'DEBIT')

```
Yes NULL
```
methods_paym
ent

```
enum('LYTE
X', 'TICKET',
'PUTZ')
```
```
Yes NULL
```
entry_date datetime(6) Yes NULL
expiration_date datetime(6) Yes NULL
finished_codes bit(1) No
related_transac
tion_id

```
bigint Yes NULL
```
created_date datetime(6) Yes NULL
last_modified_d
ate

```
datetime(6) Yes NULL
```
created_by varchar(64) Yes NULL
last_modified_b
y

```
varchar(64) Yes NULL
```

```
DATABASECHANGELOG ID
AUTHOR FILENAME
DATEEXECUTED ORDEREXECUTED
EXECTYPE MD5SUM
DESCRIPTION COMMENTS
TAG LIQUIBASE
CONTEXTS LABELS
DEPLOYMENT_ID
```
```
DATABASECHANGELOGLOCK ID
LOCKED LOCKGRANTED
LOCKEDBY
```
```
id asset_category
name slug
root_category_id category_type
description is_public
is_active created_date
last_modified_date created_by
last_modified_by
```
```
asset_category__users categories_id
person_id
```
```
id asset_item
name lettering
small_description phonetic
item_order slug
video_check_status json_data
description resource_url
resource_type is_active
created_date last_modified_date
created_by last_modified_by
```
```
asset_item__categories category_id
asset_item_id
```
```
asset_item__voice_overs voice_overs_id
asset_item_id
```
```
asset_retail_product id
name small_description
phonetic slug
json_data default_unit_id
default_supplier_id description
resource_type resource_url
scene_type is_active
created_date last_modified_date
created_by last_modified_by
```
```
asset_retail_product__categories categories_id
asset_retail_product_id
```
```
asset_retail_product__voice_overs voice_overs_id
asset_retail_product_id
```
```
asset_retail_supplier id
name phonetic
slug description
image_url image_alt_url
is_active created_date
last_modified_date created_by
last_modified_by
```
```
asset_retail_unit id
name slug
lettering description
is_active created_date
last_modified_date created_by
last_modified_by
```
```
id asset_startup
appearance_id pitch_deck_url
track company_id
company_name elevator_pitch
country_name logo_url
homepage_url instagram_url
linkedin_url facebook_url
category_id industry_id
industry_name stand_number
time_json team_1_id
team_1_name team_1_avatar
team_1_job team_2_id
team_2_name team_2_avatar
team_2_job team_3_id
team_3_name team_3_avatar
team_3_job team_4_id
team_4_name team_4_avatar
team_4_job team_5_id
team_5_name team_5_avatar
team_5_job team_6_id
team_6_name team_6_avatar
team_6_job team_7_id
team_7_name team_7_avatar
team_7_job is_active
created_date last_modified_date
created_by last_modified_by
```
```
asset_voice_speaker id
name slug
description eleven_labs_id
is_active created_date
last_modified_date created_by
last_modified_by
```
```
asset_voice_voiceover id
name description
slug speaker_id
category_id phonetic
voiceover_time voiceover_time_raw
voiceover_time_type voiceover_url
audiobitrate is_active
created_date last_modified_date
created_by last_modified_by
```
```
id competence
name description
icon_url is_active
created_date last_modified_date
created_by last_modified_by
```
```
competence_guide id
competence_id level
name slug
description mark_down
html_page file_link
file file_content_type
is_active is_verified
created_date last_modified_date
created_by last_modified_by
```
```
id config_params
name slug
description config_params_type
value json_value
is_active created_date
last_modified_date created_by
last_modified_by
```
```
id franquias
nome nome_fantasia
razao_social segmento_id
rede_id data_coleta
ultima_atualizacao
```
```
franquias__expansao_interesse id
franquia_id estado
cidade prioridade
status
```
```
franquias__investimentos_franquia id
franquia_id tipo_investimento
valor_minimo valor_maximo
descricao data_atualizacao
```
```
franquias__premiacoes id
franquia_id nome_premiacao
instituicao ano
categoria colocacao
```
```
franquias__redes_franquia id
nome cnpj
ano_fundacao ano_inicio_franchising
site_oficial descricao
```
```
franquias__redes_sociais id
franquia_id tipo
url usuario
```
```
franquias__requisitos_franquia id
franquia_id area_minima
area_maxima quantidade_minima_funcionarios
experiencia_previa exclusividade
prazo_contrato
```
```
franquias__segmentos id
nome descricao
```
```
franquias__sub_segmentos id
segmento_id nome
descricao
```
```
franquias__taxas_franquia id
franquia_id taxa_franquia
royalties_percentual royalties_valor
taxa_publicidade_percentual taxa_publicidade_valor
outras_taxas
```
```
franquias__unidades id
franquia_id tipo
estado cidade
data_inauguracao status
```
```
id ibge__city
name latitude
longitude is_capital
uf_id siafi_id
ddd time_zone
is_active created_date
last_modified_date created_by
last_modified_by
```
```
id ibge__name
first_name classification
frequency_female frequency_male
frequency_total name_group_id_calc
name_group_id is_perfect_group
is_name_checked frequency_group
request_counter name_type
ratio is_active
created_date last_modified_date
created_by last_modified_by
```
```
ibge__name_frequency id
name_id name_id_calc
gender uf_id
f_frequency f_rank
f_total f_1930
f_19301940 f_19401950
f_19501960 f_19601970
f_19701980 f_19801990
f_19902000 f_20002010
is_active created_date
last_modified_date created_by
last_modified_by
ibge__name_group id
name phonetic
group_type classification
frequency_female frequency_male
frequency_total ratio
names is_active
created_date last_modified_date
created_by last_modified_by
```
```
ibge__name_render id
name project_render_id
counter ibge_name_id
ibge_name_id_calc is_active
created_date last_modified_date
created_by last_modified_by
```
```
id ibge__uf
uf id_ibge
name latitude
longitude region
is_active created_date
last_modified_date created_by
last_modified_by
```
```
ibge_name_group_sum id
name gender
frequency_female frequency_male
frequency_total ratio
names
```
```
ibge_names_and_frequency first_name
f_frequency f_male
f_female gender
ratio
```
```
notification_whatsapp id
putz_hash sid
name body
notification_direction phone_from
phone_to reference
reference_chatbot notification_type
answer reply
whatsapp_msg_type error_message
error_code price_unit
price uri
account_sid notification_status
messaging_service_sid api_version
media_url date_scheduled
date_queued date_sent
date_failed date_delivered
date_read date_answer
date_updated person_id
data_source time_line_event_id
project_render_item_id is_active
created_date created_by
last_modified_date last_modified_by
retry_count last_attempt_date
```
```
openai_assistants id
name slug
assistants_id model
temperature top_p
max_output_tokens response_schema
instruction is_active
created_date last_modified_date
created_by last_modified_by
```
```
openai_conclusions id
sid openai_function
ask slug
is_active user_id
description json_conclusion
created_date last_modified_date
created_by last_modified_by
```
```
id page_faq
ask slug
answer item_index
page_type is_active
created_date created_by
last_modified_date last_modified_by
```
```
id person
name slug
email current_balance
is_active company_id
company_type name_fantasy
cpf_cnpj rg_doc
birthday lastaccess
avatar avatar_content_type
person_type gender
pix_key pix_key_type
thread_id active_chat
instruction_openai phone
phone_cel phone_whatsapp
phone_whatsapp_verification address_zip_code
address_location address_number
address_complement address_district
address_city address_uf
address_country social_linkedin
social_web social_instagram
social_pinterest reference
commission created_date
last_modified_date created_by
last_modified_by
```
```
person_references id
person_id reference_name
reference_value reference_extra
is_active created_date
last_modified_date created_by
last_modified_by
```
```
id portfolio
person_id competence_id
level name
description rank_agility
rank_creativity rank_deadline
rank_quality rank_remaking
file_link file
file_content_type is_active
request_status created_date
last_modified_date created_by
last_modified_by
```
```
portfolio__tags tags_id
portfolio_id
```
```
id product
product_type_id rd_id
level name
description price
is_active created_date
last_modified_date created_by
last_modified_by
```
```
product_competence id
competence_id product_type_id
is_active created_date
last_modified_date created_by
last_modified_by
```
```
id product_group
name description
is_active created_date
last_modified_date created_by
last_modified_by
```
```
id product_type
name description
unit default_step_index
is_active is_extra_item
price_factor created_date
last_modified_date created_by
last_modified_by
```
```
id project
name slug
description internal_description
project_status approved_date_by_client
approved_date_by_putz is_active
video_time days
change_max_number agreement_pdf_link
start_date canceled_date
end_date end_date_calc_preview
difficulty_level video_url_low_res
video_url_hi_res priority_type
priority_percent profit_target_percent
insurance_type insurance_percent
agency_commission_percent vendor_commission_percent
sdr_commission_percent tribute_percent
quantity tribute_ancine
payment_type payment_factor_percent
rebate_subscriber_percent rebate_subscriber_time
rebate_subscriber_plan rebate_credits_percent
rebate_watermark_percent negotiation_rebate_percent
rebate_commission_percent is_render
payment_plan_id agency_id
cancel_user_id manager_id
vendor_id client_id
sdr_id root_project_id
rd_id created_by
created_date last_modified_by
last_modified_date
```
```
project__tags tags_id
project_id
```
```
id project_calc
tribute_value agency_commission_base_value
agency_commission_rebate_value agency_commission_final_value
vendor_commission_base_value vendor_commission_rebate_value
vendor_commission_final_value sdr_commission_base_value
sdr_commission_rebate_value sdr_commission_final_value
priority_value insurance_value
video_time_partial_percent resume_commis_tax_profit_sum_percent
items_sum items_base_sum
items_extra_base_sum items_sum_with_priority
items_sum_with_priority_plus_insurance items_cost_percentage
payment_factor_value rebate_subscriber_value
resume_total_agency_putz_rebate_percent rebate_credits_value
rebate_watermark_value resume_total_agency_rebate_percent
final_extra_budget final_price
final_costs final_profit
profit_final_percent is_active
created_date last_modified_date
created_by last_modified_by
```
```
id project_case
name details
problem solution
item_index service_area_type
is_active is_online
video_url video_thumbs
customer_name customer_company
customer_experience created_date
last_modified_date created_by
last_modified_by
```
```
id project_item
project_id rd_id
project_step_id product_id
name description
freelancer_id item_index
is_extra_item price_factor
is_checked is_active
is_public quantity
value_freela value_base
start_date first_commit_date
expected_date end_date
close_date customer_rate
manager_rate manager_comment
invoice_pdf invoice_xml
created_date last_modified_date
created_by last_modified_by
project_item_request id
freelancer_id project_item_id
description freela_approved
is_active request_status
created_date last_modified_date
created_by last_modified_by
project_payment id
project_id description
is_active item_index
payment_date payment_value
payment_type is_checke
created_date last_modified_date
created_by last_modified_by
```
```
id project_render
name short_description
description user_payment_type
delivery_max_time delivery_msg_json
render_slug project_id
owner_id json_template
json_data_source json_field_description
priority max_time
instruction_openai whatsapp_bot
whatsapp_flow sending_platform
avaliable_until id_plataform
token_plataform whatsapp_no_credit
whatsapp_autoresponse whatsapp_template_service
whatsapp_welcome whatsapp_wait
whatsapp_finish whatsapp_share
video_url_template thumb_url
video_url_example render_avg_time
videos_per_month videos_per_day
number_of_items render_main_url
whatsapp_bot_welcome_media is_csv_render
is_active min_price
max_price coupons_required
pay_max_time password_hash
created_date last_modified_date
created_by last_modified_by
```
```
project_render_group_name id
render_id ibge_name_group_id
name record_status
is_active created_date
last_modified_date created_by
last_modified_by
```
```
project_render_item id
render_slug render_status
person_id render_project_id
render_uid render_count
type origin
tracking priority
name description
email whatsapp
whatsapp_status whatsapp_sent_date
render_progress encode_progress
error workpath
scriptfile resultname
is_name_checked output
description_hash json_data
data_source delivery_max_time
scheduled_to delivery_msg_json
start_render_date expected_render_date
exported_date end_render_date
video_check_status bot_name
video_url video_file_size
thumb_url frames
ia_update_date created_date
last_modified_date error_at
created_by last_modified_by
id project_render_log
uid project_render_item_id
description bot_name
is_active created_date
last_modified_date created_by
last_modified_by
```
```
project_render_user person_id
project_render_id render_slug
```
```
id project_step
project_id step_id
schedule_name is_main_schedule
name description
item_index days_freela
days_extra days_approv
days_total start_date_expected
start_date end_date_expected
end_date is_active
change_number created_date
last_modified_date created_by
last_modified_by
```
```
id publication_task
publication_source_id publication_user_id
todo assistant
quantity render_news_type
extra project_render_item_id
status attempts
next_run_at priority
lock_until locked_by
start_date end_date
error_message created_date
last_modified_date created_by
last_modified_by
```
```
id publications
publications_source_id source_type
platform cache_post_user
url json_data
news_time is_active
created_date last_modified_date
created_by last_modified_by
```
```
publications_complete id
publications_source_id source_type
platform json_data
url news_time
published_at title
main_image tags
```
```
publications_source id
title to_do
status check_status
images published_at
author_id content
source_type main_image
project_render_item_ids section
section_slug link
type json_data
attempt_count is_active
cached_tags person_id
message_error created_date
last_modified_date created_by
last_modified_by
```
```
publications_source__tags tags_id
publication_source_id created_date
```
```
publications_source__type_users id
person_id publication_source_type
is_active created_date
created_by last_modified_by
last_modified_date
```
```
id publications_user
to_do requester_id
owner_id publication_id
project_render_item_id post_id
status publication_date
json_publication error_description
app_id page_id
access_token platform
is_active created_date
last_modified_date created_by
last_modified_by
```
```
putz_authority name
description
```
```
putz_persistent_audit_event event_id
principal event_date
event_type
putz_persistent_audit_evt_data event_id
name value
```
```
id putz_user
login first_name
last_name email
provider provider_id
image_url password_hash
danger_pass activated
lang_key activation_key
reset_key created_by
created_date reset_date
last_modified_by last_modified_date
old_id old_passhash
```
```
putz_user_authority user_id
authority_name
```
```
id question
name description
content_value question_type
is_active created_date
last_modified_date created_by
last_modified_by
```
```
rel_product_type__groups groups_id
product_type_id
```
```
rel_product_type__tags tags_id
product_type_id
```
```
render_item_resume id
render_slug render_status
NAME description
whatsapp data_source
video_url
```
```
satisfaction_survey id
name description
is_active created_date
last_modified_date created_by
last_modified_by project_id
question_id
```
```
id schedule
name description
days is_active
created_date last_modified_date
created_by last_modified_by
```
```
id schedule_step
schedule_id name
description item_index
icon_url icon_progress_url
icon_finish_url is_active
days created_date
last_modified_date created_by
last_modified_by smart_websummit_rio id
name avatar_url_large
avatar_url_medium country
elevatorPitch track
industry
```
```
id subscription_plans
plan_name plan_category
publication_source_type description
description_short description_items
auto_renew credit_days
meses is_active
json_credit_details json_payment_details
amount_paid discount
id_external created_date
last_modified_date created_by
last_modified_by
```
```
id subscriptions
user_id subscription_plan_id
plan_name auto_renew
start_date end_date
is_active amount_credits
amount_paid discount
transaction_id subscription_id_external
subscription_status created_date
last_modified_date created_by
last_modified_by
```
```
id tag
name description
tag_type is_active
relevance created_date
last_modified_date created_by
last_modified_by
```
```
timeline_attachment id
event_id name
extension link
is_active created_date
last_modified_date created_by
last_modified_by
```
```
timeline_comment id
event_id description
is_visible is_active
created_date last_modified_date
created_by last_modified_by
root_comment_id
```
```
id timeline_event
title project_step_id
project_item_id description
event_type is_visible
is_active conclusion_date
conclusion_title conclusion_description
customer_rate is_approved
created_date last_modified_date
created_by last_modified_by
root_event_id
```
```
id transaction
transaction_id person_id
amount project_id
project_item_id subscription_id
payment_motivation qtd
payment status
is_active description
description_short operation
methods_payment entry_date
expiration_date finished_codes
related_transaction_id transaction_hash
created_date last_modified_date
created_by last_modified_by
```
```
id transaction_coupon
person_owner_id person_id
code_hash discount_percentual
discount_absolute coupon_type
transaction_id project_render_id
project_id code_status
reference_coupom project_render_item_id
publications_user_id is_active
expiration_date created_date
last_modified_date created_by
last_modified_by
```
```
transaction_coupon_remover id
person_owner_id person_id
code_hash discount_percentual
discount_absolute transaction_id
project_render_id project_id
code_status reference_coupom
project_render_item_id is_active
expiration_date created_date
last_modified_date created_by
last_modified_by
```
```
transaction_remover id
transaction_id person_id
amount project_id
project_item_id payment_motivation
qtd payment
status is_active
description operation
methods_payment entry_date
expiration_date finished_codes
related_transaction_id created_date
last_modified_date created_by
last_modified_by
```
Powered by TCPDF (www.tcpdf.org)

Page number: 116/116 May 16, 2026 at 09:27 PM