set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaExclusaoCronogramaSafra.sql
**		Name: SP_S_VerificaExclusaoCronogramaSafra
**		Desc: Verifica Disponibilidade para cadastro de Compromisso
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaExclusaoCronogramaSafra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaExclusaoCronogramaSafra]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaExclusaoCronogramaSafra]
	 @cdCronogramaSafraSEQ bigint 
  
AS
 
		-- Verifica se já tem tabela de preco cadastrada para o cronograma safra
		SELECT 
			distinct cdCronogramaSafraSEQ
		FROM
			PessoaTabelaPrecoProduto (nolock)
		WHERE 
			cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ


	