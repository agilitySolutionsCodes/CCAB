set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_GrupoProduto.sql
**		Name: SP_G_GrupoProduto
**		Desc: Obtem registros da tabela GrupoProduto
**
**		Auth: Convergence
**		Date: 13/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_GrupoProduto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_GrupoProduto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_GrupoProduto]
AS
 
	--seleção
	SELECT 
		 cdGrupoProdutoSEQ
		,cdGrupoProdutoERP
		,dsGrupoProduto
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao

	FROM
		GrupoProduto (nolock)
