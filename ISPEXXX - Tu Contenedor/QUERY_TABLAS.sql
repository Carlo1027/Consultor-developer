USE [Inland]
GO

/*==============================================================*/
/* Table: linea                                                 */
/*==============================================================*/
create table tco.linea (
   linea_id             smallint             identity,
   nombre               varchar(100)         not null,
   estado               char(1)              not null default '1',
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   usuario_modificacion_id numeric              null,
   constraint PK_LINEA primary key (linea_id)
)
go

alter table tco.linea
   add constraint FK_LINEA_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table tco.linea
   add constraint FK_LINEA_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go


/*==============================================================*/
/* Table: empresa_alias                                         */
/*==============================================================*/
create table tco.empresa_alias (
   empresa_alias_id     numeric              identity,
   empresa_id           numeric              not null,
   linea_id             smallint             null,
   alias                varchar(30)          null,
   constraint PK_EMPRESA_ALIAS primary key (empresa_alias_id)
)
go

alter table tco.empresa_alias
   add constraint FK_CLIENTE_EMPRESA foreign key (empresa_id)
      references ges.empresa (empresa_id)
go

alter table tco.empresa_alias
   add constraint FK_EMPRESA_ALIAS_LINEA foreign key (linea_id)
      references tco.linea (linea_id)
go


/*==============================================================*/
/* Table: ciudad                                                */
/*==============================================================*/
create table tco.ciudad (
   ciudad_id            int                  not null,
   constraint PK_CIUDAD primary key (ciudad_id)
)
go

alter table tco.ciudad
   add constraint FK_CIUDAD_UBIGEO foreign key (ciudad_id)
      references ges.ubigeo (ubigeo_id)
go


/*==============================================================*/
/* Table: deposito                                              */
/*==============================================================*/
create table tco.deposito (
   deposito_id          smallint             identity,
   ciudad_id            int                  null,
   usuario_modificacion_id numeric              null,
   nombre               varchar(100)         not null,
   direccion            varchar(250)         null,
   estado               char(1)              not null default '1',
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   empresa_id           numeric              null,
   constraint PK_DEPOSITO primary key (deposito_id)
)
go

alter table tco.deposito
   add constraint FK_DEPOSITO_CIUDAD foreign key (ciudad_id)
      references tco.ciudad (ciudad_id)
go

alter table tco.deposito
   add constraint FK_DEPOSITO_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table tco.deposito
   add constraint FK_DEPOSITO_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go

alter table tco.deposito
   add constraint FK_DEPOSITO_REFERENCE_EMPRESA foreign key (empresa_id)
      references ges.empresa (empresa_id)
go


/*==============================================================*/
/* Table: deposito_alias                                        */
/*==============================================================*/
create table tco.deposito_alias (
   deposito_alias_id    numeric              identity,
   deposito_id          smallint             not null,
   linea_id             smallint             not null,
   alias                varchar(20)          not null,
   constraint PK_DEPOSITO_ALIAS primary key (deposito_alias_id)
)
go

alter table tco.deposito_alias
   add constraint FK_DEPOSITO_ALIAS_DEPOSITO foreign key (deposito_id)
      references tco.deposito (deposito_id)
go

alter table tco.deposito_alias
   add constraint FK_DEPOSITO_ALIAS_LINEA foreign key (linea_id)
      references tco.linea (linea_id)
go


/*==============================================================*/
/* Table: dropoff                                               */
/*==============================================================*/
create table tco.dropoff (
   dropoff_id           int                  identity,
   ciudad_id            int                  null,
   linea_id             smallint             not null,
   fecha_inicio         date                 not null,
   fecha_fin            date                 not null,
   comentario           varchar(255)         null,
   estado               char(1)              not null default '1',
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   usuario_modificacion_id numeric              null,
   empresa_id           numeric              null,
   constraint PK_DROPOFF primary key (dropoff_id)
)
go

alter table tco.dropoff
   add constraint FK_DROPOFF_CIUDAD foreign key (ciudad_id)
      references tco.ciudad (ciudad_id)
go

alter table tco.dropoff
   add constraint FK_DROPOFF_EMPRESA foreign key (empresa_id)
      references ges.empresa (empresa_id)
go

alter table tco.dropoff
   add constraint FK_DROPOFF_LINEA foreign key (linea_id)
      references tco.linea (linea_id)
go

alter table tco.dropoff
   add constraint FK_DROPOFF_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table tco.dropoff
   add constraint FK_DROPOFF_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go


/*==============================================================*/
/* Table: servicio                                              */
/*==============================================================*/
create table tco.servicio (
   servicio_id          numeric              identity,
   unidad_negocio_id    numeric              null,
   nombre               varchar(100)         not null,
   indicador_especial   char(1)              not null default '0',
   estado               char(1)              not null default '1',
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   usuario_modificacion_id numeric              null,
   constraint PK_SERVICIO primary key (servicio_id)
)
go

alter table tco.servicio
   add constraint FK_SERVICIO_UNIDAD_NEGOCIO foreign key (unidad_negocio_id)
      references seg.unidad_negocio (unidad_negocio_id)
go

alter table tco.servicio
   add constraint FK_SERVICIO_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table tco.servicio
   add constraint FK_SERVICIO_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go


/*==============================================================*/
/* Table: tarifa                                                */
/*==============================================================*/
create table tco.tarifa (
   tarifa_id            int                  identity,
   servicio_id          numeric              null,
   linea_id             smallint             null,
   tipo_operacion       numeric              not null,
   valor                decimal(12,2)        not null,
   iva                  decimal(10,2)        not null,
   total                decimal(12,2)        not null,
   estado               char(1)              not null default '1',
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   usuario_modificacion_id numeric              null,
   constraint PK_TARIFA primary key (tarifa_id)
)
go

alter table tco.tarifa
   add constraint FK_TARIFA_CATALOGO_TIPO_TARIFA foreign key (tipo_operacion)
      references ges.catalogo (catalogo_id)
go

alter table tco.tarifa
   add constraint FK_TARIFA_LINEA foreign key (linea_id)
      references tco.linea (linea_id)
go

alter table tco.tarifa
   add constraint FK_TARIFA_SERVICIO foreign key (servicio_id)
      references tco.servicio (servicio_id)
go


/*==============================================================*/
/* Table: acuerdo                                               */
/*==============================================================*/
create table tco.acuerdo (
   acuerdo_id           numeric              identity,
   linea_id             smallint             null,
   servicio_id          numeric              null,
   fecha_inicio         date                 not null,
   fecha_fin            date                 not null,
   estado               char(1)              not null default '1',
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   usuario_modificacion_id numeric              null,
   empresa_id           numeric              null,
   constraint PK_ACUERDO primary key (acuerdo_id)
)
go

alter table tco.acuerdo
   add constraint FK_ACUERDO_EMPRESA foreign key (empresa_id)
      references ges.empresa (empresa_id)
go

alter table tco.acuerdo
   add constraint FK_ACUERDO_LINEA foreign key (linea_id)
      references tco.linea (linea_id)
go

alter table tco.acuerdo
   add constraint FK_ACUERDO_SERVICIO foreign key (servicio_id)
      references tco.servicio (servicio_id)
go

alter table tco.acuerdo
   add constraint FK_ACUERDO_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table tco.acuerdo
   add constraint FK_ACUERDO_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go


/*==============================================================*/
/* Table: condicion                                             */
/*==============================================================*/
create table tco.condicion (
   condicion_id         int                  identity,
   dropoff_id           int                  not null,
   contenedor_tipo      numeric              not null,
   contenedor_tamano    numeric              not null,
   indicador_ilimitado  char(1)              not null,
   cupo                 smallint             null,
   indicador_dropoff    char(1)              null,
   dropoff              decimal              null,
   tipo_moneda          numeric              not null,
   constraint PK_CONDICION primary key (dropoff_id, condicion_id)
)
go

alter table tco.condicion
   add constraint FK_CONDICIO_DROPOFF foreign key (dropoff_id)
      references tco.dropoff (dropoff_id)
go

alter table tco.condicion
   add constraint FK_CONDICION_CATALOGO_CONTENEDOR_TAMANO foreign key (contenedor_tamano)
      references ges.catalogo (catalogo_id)
go

alter table tco.condicion
   add constraint FK_CONDICION_CATALOGO_CONTENEDOR_TIPO foreign key (contenedor_tipo)
      references ges.catalogo (catalogo_id)
go

alter table tco.condicion
   add constraint FK_CONDICION_CATALOGO_TIPO_MONEDA foreign key (tipo_moneda)
      references ges.catalogo (catalogo_id)
go


/*==============================================================*/
/* Table: deposito_contacto                                     */
/*==============================================================*/
create table tco.deposito_contacto (
   deposito_contacto_id int                  identity,
   deposito_id          smallint             not null,
   correo               varchar(200)         not null,
   nombre               varchar(100)         null,
   constraint PK_DEPOSITO_CONTACTO primary key (deposito_contacto_id, deposito_id)
)
go

alter table tco.deposito_contacto
   add constraint FK_DEPOSITO_CONTACTO_DEPOSITO foreign key (deposito_id)
      references tco.deposito (deposito_id)
go


USE [Inland]
GO


/*==============================================================*/
/* Table: impo_base                                             */
/*==============================================================*/
create table tco.impo_base (
   impo_base_id         int                  identity,
   adjunto_id           numeric              not null,
   usuario_registro_id  numeric              not null,
   fecha_registro       datetime             not null default current_timestamp,
   constraint PK_IMPO_BASE primary key (impo_base_id)
)
go

alter table tco.impo_base
   add constraint FK_IMPO_BASE_ADJUNTO foreign key (adjunto_id)
      references ges.adjunto (adjunto_id)
go

alter table tco.impo_base
   add constraint FK_IMPO_BASE_USUARIO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go


/*==============================================================*/
/* Table: doc_transporte                                        */
/*==============================================================*/
create table tco.doc_transporte (
   doc_transporte_id    numeric              identity,
   impo_base_id         int                  null,
   empresa_id           numeric              not null,
   linea_id             smallint             not null,
   tipo_operacion       numeric              not null,
   unidad_negocio_id    numeric              not null,
   numero_documento     varchar(100)          not null,
   nave                 varchar(10)          null,
   viaje                varchar(8)           null,
   rumbo                varchar(4)           null,
   puerto_descarga      varchar(100)         null,
   imo                  varchar(100)         null,
   temperatura          varchar(100)         null,
   estado               char(1)              not null,
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   usuario_modificacion_id numeric              null,
   constraint PK_DOC_TRANSPORTE primary key (doc_transporte_id)
)
go

alter table tco.doc_transporte
   add constraint FK_DOC_TRANSPORTE_CATALOGO_TIPO_OPERACION foreign key (tipo_operacion)
      references ges.catalogo (catalogo_id)
go

alter table tco.doc_transporte
   add constraint FK_DOC_TRANSPORTE_EMPRESA foreign key (empresa_id)
      references ges.empresa (empresa_id)
go

alter table tco.doc_transporte
   add constraint FK_DOC_TRANSPORTE_IMPO_BASE foreign key (impo_base_id)
      references tco.impo_base (impo_base_id)
go

alter table tco.doc_transporte
   add constraint FK_DOC_TRANSPORTE_LINEA foreign key (linea_id)
      references tco.linea (linea_id)
go

alter table tco.doc_transporte
   add constraint FK_DOC_TRANSPORTE_UNIDAD_NEGOCIO foreign key (unidad_negocio_id)
      references seg.unidad_negocio (unidad_negocio_id)
go

alter table tco.doc_transporte
   add constraint FK_DOC_TRANSPORTE_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table tco.doc_transporte
   add constraint FK_DOC_TRANSPORTE_USUARIO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go



/*==============================================================*/
/* Table: doc_transporte_detalle                                */
/*==============================================================*/
create table tco.doc_transporte_detalle (
   doc_transporte_detalle_id numeric              identity,
   doc_transporte_id    numeric              not null,
   contenedor           varchar(30)          null,
   contenedor_tipo      numeric              not null,
   contenedor_tamano    numeric              not null,
   deposito_id          smallint             null,
   altura               varchar(100)         null,
   commodity_name       varchar(500)         null,
   commodity_customer   varchar(500)         null,
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   constraint PK_DOC_TRANSPORTE_DETALLE primary key (doc_transporte_detalle_id)
)
go

alter table tco.doc_transporte_detalle
   add constraint FK_DOC_TRANSPORTE_DETALLE_DEPOSITO foreign key (deposito_id)
      references tco.deposito (deposito_id)
go

alter table tco.doc_transporte_detalle
   add constraint FK_DOC_TRANSPORTE_DETALLE_DOC_TRANSPORTE foreign key (doc_transporte_id)
      references tco.doc_transporte (doc_transporte_id)
go

alter table tco.doc_transporte_detalle
   add constraint FK_IMPO_CONTENEDOR_USUARIO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go



/*==============================================================*/
/* Table: liquidacion                                           */
/*==============================================================*/
create table tco.liquidacion (
   liquidacion_id       int                  identity,
   doc_transporte_id    numeric              null,
   estado               char(1)              not null,
   usuario_registro_id  numeric              not null,
   fecha_registro       datetime             not null default current_timestamp,
   usuario_modificacion_id numeric              null,
   fecha_modificacion   datetime             null,
   constraint PK_LIQUIDACION primary key (liquidacion_id)
)
go

alter table tco.liquidacion
   add constraint FK_LIQUIDACION_DOC_TRANSPORTE foreign key (doc_transporte_id)
      references tco.doc_transporte (doc_transporte_id)
go

alter table tco.liquidacion
   add constraint FK_LIQUIDACION_REFERENCE_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table tco.liquidacion
   add constraint FK_LIQUIDACION_REFERENCE_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go



/*==============================================================*/
/* Table: liquidacion_detalle                                   */
/*==============================================================*/
create table tco.liquidacion_detalle (
   liquidacion_detalle_id numeric              identity,
   liquidacion_id       int                  null,
   doc_transporte_detalle_id numeric              null,
   deposito_id          smallint             null,
   constraint PK_LIQUIDACION_DETALLE primary key (liquidacion_detalle_id)
)
go

alter table tco.liquidacion_detalle
   add constraint FK_LIQUIDACION_DETALLE_DEPOSITO foreign key (deposito_id)
      references tco.deposito (deposito_id)
go

alter table tco.liquidacion_detalle
   add constraint FK_LIQUIDACION_DETALLE_DOC_TRANSPORTE_DETALLE foreign key (doc_transporte_detalle_id)
      references tco.doc_transporte_detalle (doc_transporte_detalle_id)
go

alter table tco.liquidacion_detalle
   add constraint FK_LIQUIDACION_DETALLE_LIQUIDACION foreign key (liquidacion_id)
      references tco.liquidacion (liquidacion_id)
go


/*==============================================================*/
/* Table: factura                                               */
/*==============================================================*/
create table tco.factura (
   factura_id           integer              identity,
   liquidacion_id       int                  not null,
   serie                varchar(100)         not null,
   numero               varchar(100)         not null,
   constraint PK_FACTURA primary key (factura_id)
)
go

alter table tco.factura
   add constraint FK_FACTURA_LIQUIDACION foreign key (liquidacion_id)
      references tco.liquidacion (liquidacion_id)
go


/*==============================================================*/
/* Table: comodato                                              */
/*==============================================================*/
create table tco.comodato (
   comodato_id          int                  identity,
   liquidacion_id       int                  null,
   constraint PK_COMODATO primary key (comodato_id)
)
go

alter table tco.comodato
   add constraint FK_COMODATO_LIQUIDACION foreign key (liquidacion_id)
      references tco.liquidacion (liquidacion_id)
go


/*==============================================================*/
/* Table: faqs                                                  */
/*==============================================================*/
create table ges.faqs (
   faq_id               numeric              identity,
   menu_id              numeric              null,
   unidad_negocio_id    numeric              null,
   version              varchar(100)         not null,
   descripcion          TEXT                 not null,
   estado               char(1)              not null default '1',
   fecha_registro       datetime             not null default current_timestamp,
   usuario_registro_id  numeric              not null,
   fecha_modificacion   datetime             null,
   usuario_modificacion_id numeric              null,
   constraint PK_FAQS primary key (faq_id)
)
go

alter table ges.faqs
   add constraint FK_FAQS_MENU foreign key (menu_id)
      references seg.menu (menu_id)
go

alter table ges.faqs
   add constraint FK_FAQS_UNIDAD_NEGOCIO foreign key (unidad_negocio_id)
      references seg.unidad_negocio (unidad_negocio_id)
go

alter table ges.faqs
   add constraint FK_FAQS_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table ges.faqs
   add constraint FK_FAQS_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go


/*==============================================================*/
/* Table: termino                                               */
/*==============================================================*/
create table ges.termino (
   termino_id           numeric              identity,
   menu_id              numeric              not null,
   unidad_negocio_id    numeric              not null,
   version              varchar(100)         not null,
   descripcion          TEXT                 not null,
   estado               char(1)              not null default '1',
   usuario_registro_id  numeric              not null,
   fecha_registro       datetime             not null default current_timestamp,
   usuario_modificacion_id numeric              null,
   fecha_modificacion   datetime             null,
   constraint PK_TERMINO primary key (termino_id)
)
go

alter table ges.termino
   add constraint FK_TERMINO_MENU foreign key (menu_id)
      references seg.menu (menu_id)
go

alter table ges.termino
   add constraint FK_TERMINO_UNIDAD_NEGOCIO foreign key (unidad_negocio_id)
      references seg.unidad_negocio (unidad_negocio_id)
go

alter table ges.termino
   add constraint FK_TERMINO_USUARIO_MODIFICACION foreign key (usuario_modificacion_id)
      references seg.usuario (usuario_id)
go

alter table ges.termino
   add constraint FK_TERMINO_USUARIO_REGISTRO foreign key (usuario_registro_id)
      references seg.usuario (usuario_id)
go