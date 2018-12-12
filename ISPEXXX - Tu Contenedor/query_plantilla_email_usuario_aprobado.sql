USE [Inland]
GO

INSERT INTO [ges].[email_plantilla]
           ([email_plantilla_padre_id]
           ,[contenido]
           ,[titulo]
           ,[estado]
           ,[usuario_registro_id]
           ,[descripcion])
     VALUES
           (1
           ,'<p>Estimado <strong>${nombreCompleto}</strong>,</p>
<p>
  Se le comunica que ha sido APROBADA su cuenta asociada a la empresa <strong>${ruc}</strong> - <strong>${razonSocial}</strong>.
</p>
<p>
  Acceder al Portal Web para mayor detalle.
</p>
<ul style="list-style:none">
  <li>URL: <a href="${enlace}" target="_blank">${enlace}</a></li>
</ul><p>Atte.<br>APM Terminals Inland Services S.A.
</p>'
           ,'APMT IS - TU CONTENEDOR 360 - USUARIO APROBADO'
           ,'1'
           ,1
           ,'Tu Contenedor 360 - Aprobación de usuario')
GO


INSERT INTO [ges].[email_atributo]
           ([email_plantilla_id]
           ,[campo])
     VALUES
           (24
           ,'nombreCompleto'),
       (24
           ,'ruc'),
       (24
           ,'razonSocial'),
       (24
           ,'enlace')
GO


