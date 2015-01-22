set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CooperativaPrincipioAtivo.sql
**		Name: TR_CooperativaPrincipioAtivo
**		Desc: Trigger de históricos da tabela CooperativaPrincipioAtivo
**
**		Auth: Convergence
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CooperativaPrincipioAtivo]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CooperativaPrincipioAtivo]
END
GO
 
CREATE TRIGGER [dbo].[TR_CooperativaPrincipioAtivo] ON CooperativaPrincipioAtivo
AFTER INSERT, UPDATE
AS
 
declare
	@cdTipoEventoHistorico		int
 
	IF EXISTS (SELECT * FROM deleted)	-- Alteração
	BEGIN
		select
			@cdTipoEventoHistorico	= 2
	END
	ELSE
	BEGIN
		select
			@cdTipoEventoHistorico	= 1
	END
 
	--inserção
	INSERT INTO CooperativaPrincipioAtivoHistorico
	(
		 cdCronogramaSafraSEQ
		,cdCooperativaPrincipioAtivoSEQ
		,cdCooperativaSEQ
		,cdFornecedorPrincipioAtivo
		,cdTipoProduto
		,wkCooperativaPrincipioAtivo
		,cdTipoEventoHistorico	
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
	)
	SELECT
		 cdCronogramaSafraSEQ
		,cdCooperativaPrincipioAtivoSEQ
		,cdCooperativaSEQ
		,cdFornecedorPrincipioAtivo
		,cdTipoProduto
		,wkCooperativaPrincipioAtivo
		,@cdTipoEventoHistorico
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		inserted

