set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: TR_CooperativaCessaoCredito.sql
**		Name: TR_CooperativaCessaoCredito
**		Desc: Trigger de históricos da tabela CooperativaCessaoCredito
**
**		Auth: Convergence
**		Date: 05/05/2011
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TR_CooperativaCessaoCredito]'))
BEGIN
	DROP TRIGGER [dbo].[TR_CooperativaCessaoCredito]
END
GO
 
CREATE TRIGGER [dbo].[TR_CooperativaCessaoCredito] ON CooperativaCessaoCredito
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
	INSERT INTO CooperativaCessaoCreditoHistorico
	(
	
		 cdCooperativaCessaoCreditoSEQ
		,cdCronogramaSafraSEQ
		,cdPessoaSEQ
		,cdIndicadorCessaoCredito
		,wkCooperativaCessaoCredito

		,cdTipoEventoHistorico
		,dtOcorrenciaHistorico
		,cdUsuarioOcorrenciaHistorico
		
		,cdIndicadorPedidoNormal
		,cdIndicadorPedidoContaOrdem
	)
	SELECT
	
		 cdCooperativaCessaoCreditoSEQ
		,cdCronogramaSafraSEQ
		,cdCooperativaSEQ
		,cdIndicadorCessaoCredito
		,wkCooperativaCessaoCredito
		
		,@cdTipoEventoHistorico
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		
		,cdIndicadorPedidoNormal
		,cdIndicadorPedidoContaOrdem
		
	FROM
		inserted

