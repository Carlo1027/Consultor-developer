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
           ,'<p>Estimado(a) <strong>${nombreCompleto}</strong>,</p>
<p>
  Se le informa que ha sido registrado(a) en el Portal TuContenedor360 como usuario Máster de la Empresa ${razonSocial} con las siguientes credenciales:
</p>

<p>
  Usuario: <strong>${correo}</strong>
</p>
<p>
  Contraseña: <strong>${clave}</strong>
</p>

<p>
  Puede acceder al Portal, a través del link:
</p>
<ul style="list-style:none">
  <li>URL: <a href="${enlace}" target="_blank">${enlace}</a></li>
</ul>
<p>Atte.<br>
      <strong>HRPB</strong><br>
      INLAND SERVICES COLOMBIA S.A.S.
</p>'
           ,'TU CONTENEDOR 360 - REGISTRO USUARIO MÁSTER'
           ,'1'
           ,1
           ,'Tu Contenedor 360 - Registro de usuario máster')
GO


INSERT INTO [ges].[email_atributo]
           ([email_plantilla_id]
           ,[campo])
     VALUES
           (30
           ,'nombreCompleto'),
		   (30
           ,'correo'),
		   (30
           ,'clave'),
		   (30
           ,'enlace'),
		   (30
           ,'razonSocial')
GO





