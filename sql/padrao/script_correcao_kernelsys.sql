ALTER TABLE abas ADD COLUMN usuaseq integer;
ALTER TABLE abas ADD COLUMN unidseq integer;
ALTER TABLE abas ADD COLUMN datacad date;
ALTER TABLE abas ADD COLUMN ativo integer;

ALTER TABLE blocos ADD COLUMN usuaseq integer;
ALTER TABLE blocos ADD COLUMN unidseq integer;
ALTER TABLE blocos ADD COLUMN datacad date;

ALTER TABLE blocos_x_abas ADD COLUMN usuaseq integer;
ALTER TABLE blocos_x_abas ADD COLUMN unidseq integer;
ALTER TABLE blocos_x_abas ADD COLUMN datacad date;
ALTER TABLE blocos_x_abas ADD COLUMN ativo integer;

ALTER TABLE campos ADD COLUMN usuaseq integer;
ALTER TABLE campos ADD COLUMN unidseq integer;
ALTER TABLE campos ADD COLUMN datacad date;

ALTER TABLE campos_x_blocos ADD COLUMN usuaseq integer;
ALTER TABLE campos_x_blocos ADD COLUMN unidseq integer;
ALTER TABLE campos_x_blocos ADD COLUMN datacad date;
ALTER TABLE campos_x_blocos ADD COLUMN ativo integer;

ALTER TABLE campos_x_propriedades ADD COLUMN usuaseq integer;
ALTER TABLE campos_x_propriedades ADD COLUMN unidseq integer;
ALTER TABLE campos_x_propriedades ADD COLUMN datacad date;

ALTER TABLE form_button ADD COLUMN usuaseq integer;
ALTER TABLE form_button ADD COLUMN unidseq integer;
ALTER TABLE form_button ADD COLUMN datacad date;

ALTER TABLE form_validacao ADD COLUMN usuaseq integer;
ALTER TABLE form_validacao ADD COLUMN unidseq integer;
ALTER TABLE form_validacao ADD COLUMN datacad date;
ALTER TABLE form_validacao ADD COLUMN ativo integer;

ALTER TABLE form_x_abas ADD COLUMN usuaseq integer;
ALTER TABLE form_x_abas ADD COLUMN unidseq integer;
ALTER TABLE form_x_abas ADD COLUMN datacad date;

ALTER TABLE form_x_tabelas ADD COLUMN usuaseq integer;
ALTER TABLE form_x_tabelas ADD COLUMN unidseq integer;
ALTER TABLE form_x_tabelas ADD COLUMN datacad date;

ALTER TABLE forms ADD COLUMN usuaseq integer;
ALTER TABLE forms ADD COLUMN unidseq integer;
ALTER TABLE forms ADD COLUMN datacad date;

ALTER TABLE info_empresa ADD COLUMN usuaseq integer;
ALTER TABLE info_empresa ADD COLUMN unidseq integer;
ALTER TABLE info_empresa ADD COLUMN datacad date;
ALTER TABLE info_empresa ADD COLUMN ativo integer;

ALTER TABLE lista_actions ADD COLUMN usuaseq integer;
ALTER TABLE lista_actions ADD COLUMN unidseq integer;
ALTER TABLE lista_actions ADD COLUMN datacad date;

ALTER TABLE lista_bnav ADD COLUMN usuaseq integer;
ALTER TABLE lista_bnav ADD COLUMN unidseq integer;
ALTER TABLE lista_bnav ADD COLUMN datacad date;
ALTER TABLE lista_bnav ADD COLUMN ativo integer;

ALTER TABLE lista_colunas ADD COLUMN usuaseq integer;
ALTER TABLE lista_colunas ADD COLUMN unidseq integer;
ALTER TABLE lista_colunas ADD COLUMN datacad date;

ALTER TABLE lista_fields ADD COLUMN usuaseq integer;
ALTER TABLE lista_fields ADD COLUMN unidseq integer;
ALTER TABLE lista_fields ADD COLUMN datacad date;

ALTER TABLE lista_form ADD COLUMN usuaseq integer;
ALTER TABLE lista_form ADD COLUMN unidseq integer;
ALTER TABLE lista_form ADD COLUMN datacad date;

ALTER TABLE menu_modulos ADD COLUMN usuaseq integer;
ALTER TABLE menu_modulos ADD COLUMN unidseq integer;
ALTER TABLE menu_modulos ADD COLUMN datacad date;

ALTER TABLE modulos_principais ADD COLUMN usuaseq integer;
ALTER TABLE modulos_principais ADD COLUMN unidseq integer;
ALTER TABLE modulos_principais ADD COLUMN datacad date;

ALTER TABLE tabelas ADD COLUMN usuaseq integer;
ALTER TABLE tabelas ADD COLUMN unidseq integer;
ALTER TABLE tabelas ADD COLUMN datacad date;