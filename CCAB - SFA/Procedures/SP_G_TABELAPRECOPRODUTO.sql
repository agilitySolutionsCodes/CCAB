/******************************************************************************
**		File: SP_G_TABELAPRECOPRODUTO.sql
**		Name: SP_G_TABELAPRECOPRODUTO
**		Desc: Obtem uma lista de registros da tabela ProdutoHistorico
**
**		Auth: Ronaldo Mega (Convergence)
**		Date: 12.05.2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_TABELAPRECOPRODUTO]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_TABELAPRECOPRODUTO]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_TABELAPRECOPRODUTO]
(
	@cdCronogramaSafraSEQ	bigint	
	@cdPessoaSEQ bigint
)	 
 
AS
 
	BEGIN
	
		SELECT
			COUNT(1)
		FROM
			PessoaTabelaPrecoProduto WITH(NOLOCK)
		WHERE
			cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ			
		AND cdPessoaSEQ = @cdPessoaSEQ
	
	END