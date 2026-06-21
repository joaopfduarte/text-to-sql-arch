---
description: Inventário anonimizado das 92 entidades da massa de teste.
tags:
  - dados
---

# Schema e massa de teste (laboratório)

!!! info "Recomendado para leitura prévia"
    - **[Glossário de anonimização](../00-glossario-anonimizacao.md)** — vocabulário genérico obrigatório.
    - **[Banco laboratorial](banco-laboratorio-dominio.md)** — domínios genéricos, entidades-âncora e FKs.
    - **[Carga no cluster](carga-cluster-laboratorio.md)** — pipeline de ingestão da massa `massa_teste_laboratorio`.
    - **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica e metadados no cluster.


### Decisão

A massa de avaliação corresponde a **92 entidades** com identificadores opacos (`tbl_*`). O export relacional completo permanece **offline**, fora deste repositório.

### Regras da massa

- O schema é fixado antes das corridas finais e versionado em `datasetVersion`.
- Alteração do schema exposto exige nova versão e ADR.
- Dados sensíveis são mascarados na carga conforme [Carga no cluster](carga-cluster-laboratorio.md).

### Inventário completo (92 entidades)

| # | Entidade | Domínio |
|---|----------|---------|
| 1 | `tbl_d58bb5a4` | domínio de mídia |
| 2 | `tbl_cca22dd2` | domínio de mídia |
| 3 | `tbl_a6e2174e` | domínio de mídia |
| 4 | `tbl_c311310d` | domínio de mídia |
| 5 | `tbl_69fab9c0` | domínio de mídia |
| 6 | `tbl_0bd3e50a` | domínio de mídia |
| 7 | `tbl_0cd4d531` | domínio de mídia |
| 8 | `tbl_98bbd86f` | domínio de mídia |
| 9 | `tbl_f248ec25` | domínio de mídia |
| 10 | `tbl_38b14384` | domínio de mídia |
| 11 | `tbl_e0a11ad9` | domínio de mídia |
| 12 | `tbl_9288f22d` | domínio de mídia |
| 13 | `tbl_2210dca4` | domínio de mídia |
| 14 | `tbl_5e464b14` | apoio operacional |
| 15 | `tbl_cef676c5` | apoio operacional |
| 16 | `tbl_bb1c74b7` | apoio operacional |
| 17 | `tbl_d1cb73f6` | controle de migração |
| 18 | `tbl_b7dfbbcb` | controle de migração |
| 19 | `tbl_162cf7be` | domínio comercial principal |
| 20 | `tbl_93460c22` | domínio comercial principal |
| 21 | `tbl_54c1256a` | domínio comercial principal |
| 22 | `tbl_254c881e` | domínio comercial principal |
| 23 | `tbl_4c8d7ae5` | domínio comercial principal |
| 24 | `tbl_05dc6f7a` | domínio comercial principal |
| 25 | `tbl_fada6213` | domínio comercial principal |
| 26 | `tbl_8991e9dc` | domínio comercial principal |
| 27 | `tbl_95a1e6e1` | domínio comercial principal |
| 28 | `tbl_40b45933` | domínio comercial principal |
| 29 | `tbl_973ec6fa` | domínio comercial principal |
| 30 | `tbl_23a8dee5` | domínio geográfico de referência |
| 31 | `tbl_f64a1c03` | domínio geográfico de referência |
| 32 | `tbl_2c1fc4f7` | domínio geográfico de referência |
| 33 | `tbl_0c30d74e` | domínio geográfico de referência |
| 34 | `tbl_bd01b86d` | domínio geográfico de referência |
| 35 | `tbl_c6092460` | domínio geográfico de referência |
| 36 | `tbl_e78e1fac` | domínio geográfico de referência |
| 37 | `tbl_c78eb7ee` | domínio geográfico de referência |
| 38 | `tbl_9b02bb2c` | domínio de conectores |
| 39 | `tbl_d94d1042` | domínio de conectores |
| 40 | `tbl_508411b3` | domínio de conectores |
| 41 | `tbl_a63ac3ee` | apoio operacional |
| 42 | `tbl_f193a446` | domínio de identidade |
| 43 | `tbl_ae0a73d5` | domínio de identidade |
| 44 | `tbl_f0944b44` | domínio de catálogo |
| 45 | `tbl_ea9d95de` | domínio de catálogo |
| 46 | `tbl_891b1fc9` | domínio de catálogo |
| 47 | `tbl_feb88f1f` | domínio de catálogo |
| 48 | `tbl_97a28ae4` | domínio de catálogo |
| 49 | `tbl_ed8b2873` | domínio de catálogo |
| 50 | `tbl_363ae7e9` | domínio operacional de entregas |
| 51 | `tbl_b8f84c29` | domínio operacional de entregas |
| 52 | `tbl_fb0188bb` | domínio operacional de entregas |
| 53 | `tbl_3a2c56ff` | domínio operacional de entregas |
| 54 | `tbl_73f0363b` | domínio operacional de entregas |
| 55 | `tbl_6696932f` | domínio operacional de entregas |
| 56 | `tbl_21eee00c` | domínio operacional de entregas |
| 57 | `tbl_6b78d7ab` | domínio operacional de entregas |
| 58 | `tbl_e019dc9e` | domínio operacional de entregas |
| 59 | `tbl_68110fc1` | domínio operacional de entregas |
| 60 | `tbl_086b56bc` | domínio operacional de entregas |
| 61 | `tbl_e9e0d929` | domínio operacional de entregas |
| 62 | `tbl_35a31063` | domínio operacional de entregas |
| 63 | `tbl_4e5786c9` | domínio de conteúdo externo |
| 64 | `tbl_03f58275` | domínio de conteúdo externo |
| 65 | `tbl_ed7e8f08` | domínio de conteúdo externo |
| 66 | `tbl_0f03f20e` | domínio de conteúdo externo |
| 67 | `tbl_9705264a` | domínio de conteúdo externo |
| 68 | `tbl_06d78b0c` | domínio de conteúdo externo |
| 69 | `tbl_58680eab` | domínio de conteúdo externo |
| 70 | `tbl_d1556a76` | domínio de acesso e auditoria |
| 71 | `tbl_a4806350` | domínio de acesso e auditoria |
| 72 | `tbl_a707320d` | domínio de acesso e auditoria |
| 73 | `tbl_c127eea9` | domínio de acesso e auditoria |
| 74 | `tbl_54cf92bb` | domínio de acesso e auditoria |
| 75 | `tbl_bd19ace7` | apoio operacional |
| 76 | `tbl_e34fa50f` | domínio de catálogo |
| 77 | `tbl_db4293e4` | domínio de catálogo |
| 78 | `tbl_ae9df279` | domínio operacional de entregas |
| 79 | `tbl_0b894724` | apoio operacional |
| 80 | `tbl_77034db9` | domínio operacional de entregas |
| 81 | `tbl_4cde28f3` | domínio operacional de entregas |
| 82 | `tbl_cc639883` | apoio operacional |
| 83 | `tbl_6cf5e405` | domínio financeiro |
| 84 | `tbl_6cc6cc99` | domínio financeiro |
| 85 | `tbl_7933f344` | tags e classificação |
| 86 | `tbl_50ff81ac` | domínio operacional de entregas |
| 87 | `tbl_b5c51241` | domínio operacional de entregas |
| 88 | `tbl_0bd88855` | domínio operacional de entregas |
| 89 | `tbl_c066178a` | domínio financeiro |
| 90 | `tbl_6b881dfd` | domínio financeiro |
| 91 | `tbl_365b81cc` | domínio financeiro |
| 92 | `tbl_63f841a0` | domínio financeiro |

#### Resumo por domínio

| Domínio | Quantidade |
|---------|------------|
| apoio operacional | 7 |
| controle de migração | 2 |
| domínio comercial principal | 11 |
| domínio de acesso e auditoria | 5 |
| domínio de catálogo | 8 |
| domínio de conectores | 3 |
| domínio de conteúdo externo | 7 |
| domínio de identidade | 2 |
| domínio de mídia | 13 |
| domínio financeiro | 6 |
| domínio geográfico de referência | 8 |
| domínio operacional de entregas | 19 |
| tags e classificação | 1 |
| **Total** | **92** |

### Relacionamentos (FK lógicas)

Notação: `tbl_origem.col_origem -> tbl_destino.col_destino`.

| Origem | Coluna | Destino |
|--------|--------|---------|
| `tbl_d58bb5a4` | `col_7c65d453` | `tbl_d58bb5a4.col_d7247819` |
| `tbl_cca22dd2` | `col_a4e129cb` | `tbl_d58bb5a4.col_d7247819` |
| `tbl_cca22dd2` | `col_3e19be2e` | `tbl_c127eea9.col_d7247819` |
| `tbl_c311310d` | `col_00b5fea0` | `tbl_a6e2174e.col_d7247819` |
| `tbl_c311310d` | `col_d75580b3` | `tbl_d58bb5a4.col_d7247819` |
| `tbl_69fab9c0` | `col_00b5fea0` | `tbl_a6e2174e.col_d7247819` |
| `tbl_69fab9c0` | `col_3d7dc4fa` | `tbl_2210dca4.col_d7247819` |
| `tbl_0bd3e50a` | `col_73a8ac66` | `tbl_f248ec25.col_d7247819` |
| `tbl_0bd3e50a` | `col_79c804ae` | `tbl_38b14384.col_d7247819` |
| `tbl_0cd4d531` | `col_026426a8` | `tbl_0bd3e50a.col_d7247819` |
| `tbl_0cd4d531` | `col_a4e129cb` | `tbl_d58bb5a4.col_d7247819` |
| `tbl_98bbd86f` | `col_026426a8` | `tbl_0bd3e50a.col_d7247819` |
| `tbl_98bbd86f` | `col_3d7dc4fa` | `tbl_2210dca4.col_d7247819` |
| `tbl_e0a11ad9` | `col_d75580b3` | `tbl_d58bb5a4.col_d7247819` |
| `tbl_2210dca4` | `col_d75580b3` | `tbl_d58bb5a4.col_d7247819` |
| `tbl_2210dca4` | `col_56b2d112` | `tbl_9288f22d.col_d7247819` |
| `tbl_cef676c5` | `col_58e38856` | `tbl_5e464b14.col_d7247819` |
| `tbl_162cf7be` | `col_2cd9416d` | `tbl_8991e9dc.col_d7247819` |
| `tbl_162cf7be` | `col_1d3e13bf` | `tbl_4c8d7ae5.col_d7247819` |
| `tbl_93460c22` | `col_0bee3ba9` | `tbl_162cf7be.col_d7247819` |
| `tbl_54c1256a` | `col_0bee3ba9` | `tbl_162cf7be.col_d7247819` |
| `tbl_254c881e` | `col_0bee3ba9` | `tbl_162cf7be.col_d7247819` |
| `tbl_05dc6f7a` | `col_0bee3ba9` | `tbl_162cf7be.col_d7247819` |
| `tbl_fada6213` | `col_0bee3ba9` | `tbl_162cf7be.col_d7247819` |
| `tbl_95a1e6e1` | `col_2cd9416d` | `tbl_8991e9dc.col_d7247819` |
| `tbl_40b45933` | `col_0bee3ba9` | `tbl_162cf7be.col_d7247819` |
| `tbl_973ec6fa` | `col_0bee3ba9` | `tbl_162cf7be.col_d7247819` |
| `tbl_2c1fc4f7` | `col_7e317139` | `tbl_c78eb7ee.col_d7247819` |
| `tbl_0c30d74e` | `col_451e2dea` | `tbl_c6092460.col_d7247819` |
| `tbl_bd01b86d` | `col_7e317139` | `tbl_c78eb7ee.col_d7247819` |
| `tbl_bd01b86d` | `col_30e09710` | `tbl_0c30d74e.col_d7247819` |
| `tbl_e78e1fac` | `col_77d5e6dc` | `tbl_0c30d74e.col_d7247819` |
| `tbl_e78e1fac` | `col_c1b6250a` | `tbl_21eee00c.col_d7247819` |
| `tbl_9b02bb2c` | `col_84fa40f1` | `tbl_0bd88855.col_d7247819` |
| `tbl_9b02bb2c` | `col_3e19be2e` | `tbl_f193a446.col_d7247819` |
| `tbl_9b02bb2c` | `col_0c0112b1` | `tbl_e019dc9e.col_d7247819` |
| `tbl_f193a446` | `col_35f9c31c` | `tbl_f193a446.col_d7247819` |
| `tbl_ae0a73d5` | `col_3e19be2e` | `tbl_f193a446.col_d7247819` |
| `tbl_f0944b44` | `col_58e38856` | `tbl_5e464b14.col_d7247819` |
| `tbl_f0944b44` | `col_3e19be2e` | `tbl_f193a446.col_d7247819` |
| `tbl_ea9d95de` | `col_b23d42a3` | `tbl_f0944b44.col_d7247819` |
| `tbl_ea9d95de` | `col_678f2787` | `tbl_7933f344.col_d7247819` |
| `tbl_891b1fc9` | `col_b80b7e90` | `tbl_ed8b2873.col_d7247819` |
| `tbl_feb88f1f` | `col_58e38856` | `tbl_5e464b14.col_d7247819` |
| `tbl_feb88f1f` | `col_b80b7e90` | `tbl_ed8b2873.col_d7247819` |
| `tbl_363ae7e9` | `col_3b2a644b` | `tbl_f193a446.col_d7247819` |
| `tbl_363ae7e9` | `col_d8136f0b` | `tbl_f193a446.col_d7247819` |
| `tbl_363ae7e9` | `col_b8a29b43` | `tbl_f193a446.col_d7247819` |
| `tbl_363ae7e9` | `col_45d948af` | `tbl_f193a446.col_d7247819` |
| `tbl_363ae7e9` | `col_8557139b` | `tbl_363ae7e9.col_d7247819` |
| `tbl_363ae7e9` | `col_876094d5` | `tbl_f193a446.col_d7247819` |
| `tbl_b8f84c29` | `col_d7247819` | `tbl_363ae7e9.col_d7247819` |
| `tbl_fb0188bb` | `col_d7247819` | `tbl_363ae7e9.col_d7247819` |
| `tbl_3a2c56ff` | `col_4fb11656` | `tbl_f193a446.col_d7247819` |
| `tbl_3a2c56ff` | `col_1d6a5428` | `tbl_891b1fc9.col_d7247819` |
| `tbl_3a2c56ff` | `col_170f453c` | `tbl_363ae7e9.col_d7247819` |
| `tbl_3a2c56ff` | `col_8eb927db` | `tbl_e9e0d929.col_d7247819` |
| `tbl_73f0363b` | `col_4fb11656` | `tbl_f193a446.col_d7247819` |
| `tbl_73f0363b` | `col_cde4e6eb` | `tbl_3a2c56ff.col_d7247819` |
| `tbl_6696932f` | `col_170f453c` | `tbl_363ae7e9.col_d7247819` |
| `tbl_6b78d7ab` | `col_17727451` | `tbl_c6092460.col_d7247819` |
| `tbl_6b78d7ab` | `col_ca66fbb5` | `tbl_21eee00c.col_d7247819` |
| `tbl_e019dc9e` | `col_3e19be2e` | `tbl_f193a446.col_d7247819` |
| `tbl_e019dc9e` | `col_a9bacc85` | `tbl_21eee00c.col_d7247819` |
| `tbl_68110fc1` | `col_0c0112b1` | `tbl_e019dc9e.col_d7247819` |
| `tbl_e9e0d929` | `col_170f453c` | `tbl_363ae7e9.col_d7247819` |
| `tbl_e9e0d929` | `col_a8d455f3` | `tbl_4cde28f3.col_d7247819` |
| `tbl_35a31063` | `col_170f453c` | `tbl_363ae7e9.col_d7247819` |
| `tbl_35a31063` | `col_678f2787` | `tbl_7933f344.col_d7247819` |
| `tbl_4e5786c9` | `col_7f2d060f` | `tbl_ed7e8f08.col_d7247819` |
| `tbl_0f03f20e` | `col_e42eac70` | `tbl_ed7e8f08.col_d7247819` |
| `tbl_0f03f20e` | `col_678f2787` | `tbl_7933f344.col_d7247819` |
| `tbl_9705264a` | `col_3e19be2e` | `tbl_f193a446.col_d7247819` |
| `tbl_06d78b0c` | `col_0c0112b1` | `tbl_e019dc9e.col_d7247819` |
| `tbl_06d78b0c` | `col_cd1bfaa5` | `tbl_4e5786c9.col_d7247819` |
| `tbl_06d78b0c` | `col_208355af` | `tbl_c127eea9.col_d7247819` |
| `tbl_58680eab` | `col_e42eac70` | `tbl_ed7e8f08.col_d7247819` |
| `tbl_a707320d` | `col_f847332a` | `tbl_a4806350.col_f847332a` |
| `tbl_54cf92bb` | `col_3d8dba03` | `tbl_d1556a76.col_903c5b86` |
| `tbl_54cf92bb` | `col_a0feb70e` | `tbl_c127eea9.col_d7247819` |
| `tbl_e34fa50f` | `col_3f2ef352` | `tbl_97a28ae4.col_d7247819` |
| `tbl_e34fa50f` | `col_b80b7e90` | `tbl_ed8b2873.col_d7247819` |
| `tbl_db4293e4` | `col_b80b7e90` | `tbl_ed8b2873.col_d7247819` |
| `tbl_db4293e4` | `col_678f2787` | `tbl_7933f344.col_d7247819` |
| `tbl_0b894724` | `col_170f453c` | `tbl_363ae7e9.col_d7247819` |
| `tbl_0b894724` | `col_9b7a10b8` | `tbl_bd19ace7.col_d7247819` |
| `tbl_4cde28f3` | `col_fe23f0dd` | `tbl_77034db9.col_d7247819` |
| `tbl_6cf5e405` | `col_a0feb70e` | `tbl_c127eea9.col_d7247819` |
| `tbl_6cf5e405` | `col_d6dfb874` | `tbl_c066178a.col_d7247819` |
| `tbl_6cf5e405` | `col_40f9020a` | `tbl_6cc6cc99.col_d7247819` |
| `tbl_50ff81ac` | `col_f847332a` | `tbl_0bd88855.col_d7247819` |
| `tbl_b5c51241` | `col_4e482a93` | `tbl_c127eea9.col_45c646de` |
| `tbl_b5c51241` | `col_f847332a` | `tbl_0bd88855.col_d7247819` |
| `tbl_b5c51241` | `col_688b1fc1` | `tbl_b5c51241.col_d7247819` |
| `tbl_0bd88855` | `col_cde4e6eb` | `tbl_3a2c56ff.col_d7247819` |
| `tbl_0bd88855` | `col_8eb927db` | `tbl_e9e0d929.col_d7247819` |
| `tbl_0bd88855` | `col_bce88e4b` | `tbl_0bd88855.col_d7247819` |
| `tbl_c066178a` | `col_3e19be2e` | `tbl_f193a446.col_d7247819` |
| `tbl_c066178a` | `col_170f453c` | `tbl_363ae7e9.col_d7247819` |
| `tbl_c066178a` | `col_cde4e6eb` | `tbl_3a2c56ff.col_d7247819` |
| `tbl_c066178a` | `col_db393dd8` | `tbl_c066178a.col_d7247819` |
| `tbl_c066178a` | `col_9b74c635` | `tbl_6cf5e405.col_d7247819` |
| `tbl_6b881dfd` | `col_3e19be2e` | `tbl_f193a446.col_d7247819` |
| `tbl_6b881dfd` | `col_63d4aedd` | `tbl_f193a446.col_d7247819` |
| `tbl_6b881dfd` | `col_170f453c` | `tbl_363ae7e9.col_d7247819` |
| `tbl_6b881dfd` | `col_39130e55` | `tbl_06d78b0c.col_d7247819` |
| `tbl_6b881dfd` | `col_c1b6250a` | `tbl_21eee00c.col_d7247819` |
| `tbl_6b881dfd` | `col_0c0112b1` | `tbl_e019dc9e.col_d7247819` |
| `tbl_6b881dfd` | `col_d6dfb874` | `tbl_c066178a.col_d7247819` |

### Volume da massa `massa_teste_laboratorio`

Volume observado ~1388 MB (fixo, sem amplificação sintética no MVP).

### Artefatos esperados

- Export relacional anonimizado (offline).
- Script de carga: [Carga no cluster](carga-cluster-laboratorio.md).
- Bateria e gabarito em [Índice de ADRs](../evidence/README.md).

!!! tip "Recomendado para leitura posterior"
    Seguinte: **[Catálogo Atlas](catalogo-atlas.md)** — camada semântica e metadados no cluster.
