/******************************************************************************
**		File: TR_PrincipioAtivo.sql
**		Name: TR_PrincipioAtivo
**		Desc: Trigger de históricos 
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 06/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_PrincipioAtivo]'))
BEGIN
	DROP TRIGGER [dbo].[TR_PrincipioAtivo]
END
GO
 
CREATE TRIGGER [dbo].[TR_PrincipioAtivo] ON dbo.CooperativaPrincipioAtivo

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
 	
	INSERT INTO CooperativaPrincipioAtivoHistorico
	(		
		cdCronogramaSafraSEQ,
		cdCooperativaPrincipioAtivoSEQ,
		cdCooperativaSEQ,
		cdFornecedorPrincipioAtivo,		
		wkCooperativaPrincipioAtivo,
		dtOcorrenciaHistorico,
		cdUsuarioOcorrenciaHistorico,
		cdTipoEventoHistorico,
		cdTipoProduto
	)
	SELECT	
		cdCronogramaSafraSEQ,
		cdCooperativaPrincipioAtivoSEQ,
		cdCooperativaSEQ,
		cdFornecedorPrincipioAtivo,		
		wkCooperativaPrincipioAtivo,
		GetDate(),
		cdUsuarioUltimaAlteracao,
		@cdTipoEventoHistorico,
		cdTipoProduto
	FROM
		inserted
