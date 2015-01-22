set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_tmpCompromissoCompra
**		Name: SP_D_tmpCompromissoCompra
**		Desc: Exclui o registro da tabela tmpCompromissoCompra
**
**		Auth: Roberto Chaparro
**		Date: Abr 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_tmpCompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_tmpCompromissoCompra]
END
GO

CREATE PROCEDURE [dbo].[SP_D_tmpCompromissoCompra]
	 @tmpCompromissoCompraSEQ			bigint
AS

	-- Exclui a Tabela TMP de Itens
	DELETE
		dbo.tmpCompromissoCompraItem
	WHERE
		tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ

	-- Exclui a Tabela TMP de Compromisso
	DELETE 
		dbo.tmpCompromissoCompra
	WHERE
		tmpCompromissoCompraSEQ =  @tmpCompromissoCompraSEQ





