set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_CooperativaSafraVencimento_X_PessoaTabelaPrecoProduto.sql
**		Name: SP_S_CooperativaSafraVencimento_X_PessoaTabelaPrecoProduto
**		Desc: Obtem um registro da tabela CronogramaSafraVencimentoCooperativa
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_CooperativaSafraVencimento_X_PessoaTabelaPrecoProduto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_CooperativaSafraVencimento_X_PessoaTabelaPrecoProduto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_CooperativaSafraVencimento_X_PessoaTabelaPrecoProduto]
	 @cdCronogramaSafraVencimentoSEQ	BIGINT
	,@cdCooperativaSEQ bigint
 
 
AS
 
	--seleção
	SELECT 
		cdPessoaTabelaPrecoProdutoSEQ
	FROM
		dbo.PessoaTabelaPrecoProduto (nolock)
	WHERE 
		cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
	AND
		cdPessoaSEQ = @cdCooperativaSEQ
 
 

