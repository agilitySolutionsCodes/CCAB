/******************************************************************************
**		File: TR_ContaOrdem.SQL
**		Name: TR_ContaOrdem
**		Desc: Trigger de históricos 
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 24/05/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_ContaOrdem]'))
BEGIN
	DROP TRIGGER [dbo].[TR_ContaOrdem]
END
GO
 
CREATE TRIGGER [dbo].[TR_ContaOrdem] ON dbo.CooperativaContaOrdem

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
 	
	INSERT INTO CooperativaContaOrdemHistorico
	(		
		cdCronogramaSafraSEQ,
		cdCooperativaContaOrdemSEQ,
		cdCooperativaSEQ,		
		wkCooperativaContaOrdem,
		dtOcorrenciaHistorico,
		cdUsuarioOcorrenciaHistorico,
		cdTipoEventoHistorico,
		cdIndicadorContaOrdem
	)
	SELECT	
		cdCronogramaSafraSEQ,
		cdCooperativaContaOrdemSEQ,
		cdCooperativaSEQ,
		wkCooperativaContaOrdem,
		GetDate(),
		cdUsuarioUltimaAlteracao,
		@cdTipoEventoHistorico,
		cdIndicadorContaOrdem
	FROM
		inserted
