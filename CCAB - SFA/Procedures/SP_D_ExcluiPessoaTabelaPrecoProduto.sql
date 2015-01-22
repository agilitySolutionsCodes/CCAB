set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_ExcluiPessoaTabelaPrecoProduto
**		Name: SP_D_ExcluiPessoaTabelaPrecoProduto
**		Desc: Efetua a Exclusao do Pedido de Venda
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_ExcluiPessoaTabelaPrecoProduto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_ExcluiPessoaTabelaPrecoProduto]
END
GO	

CREATE PROCEDURE [dbo].[SP_D_ExcluiPessoaTabelaPrecoProduto]
	 @cdPessoaSEQ			bigint
	,@cdCronogramaSafraSEQ	bigint
AS

	-- Exclui PessoaTabelaPrecoProduto

	--PessoaTabelaPrecoProdutoHistorico
	DELETE	PessoaTabelaPrecoProdutoHistorico
	WHERE	cdPessoaSEQ = @cdPessoaSEQ
	AND     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ

	--PessoaTabelaPrecoProduto
	DELETE	PessoaTabelaPrecoProduto
	WHERE	cdPessoaSEQ = @cdPessoaSEQ
	AND     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ


SET QUOTED_IDENTIFIER OFF

