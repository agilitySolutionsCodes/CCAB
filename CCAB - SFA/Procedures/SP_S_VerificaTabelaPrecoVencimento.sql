set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaTabelaPrecoVencimento.sql
**		Name: SP_S_VerificaTabelaPrecoVencimento
**		Desc: Obtem um registro da tabela CronogramaSafraVencimento
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaTabelaPrecoVencimento]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaTabelaPrecoVencimento]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaTabelaPrecoVencimento]
	 @cdCronogramaSafraSEQ	BIGINT
 
 
AS
 
	--seleção
	SELECT 
		cdPessoaTabelaPrecoProdutoSEQ
	FROM
		dbo.PessoaTabelaPrecoProduto (nolock)
	WHERE 
		cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
 
 
