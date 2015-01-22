set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_I_TipoCultura_Produto.sql
**		Name: SP_I_TipoCultura_Produto
**		Desc: Insere registros na tabela ProdutoTipoCultura no momento da inclusão de uma Cultura
**
**		Auth: Roberto Chaparro
**		Date: Mar 19 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_TipoCultura_Produto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_TipoCultura_Produto]
END
GO

CREATE PROCEDURE [dbo].[SP_I_TipoCultura_Produto]
	 @cdTipoCulturaSEQ			bigint
	,@cdUsuarioUltimaAlteracao	bigint

AS

declare
	@cdProdutoSEQ	bigint


DECLARE Cursor_Produtos CURSOR FOR 
	select 
		cdProdutoSEQ
	from 
		dbo.Produto
	where 
		cdIndicadorLiberadoPedidoProduto = 1 --Sim
	

OPEN Cursor_Produtos

FETCH NEXT FROM Cursor_Produtos 
INTO 
	@cdProdutoSEQ


WHILE @@FETCH_STATUS = 0
BEGIN

	--inserção
	INSERT INTO ProdutoTipoCultura
	(
	 cdProdutoSEQ
	,cdTipoCulturaSEQ
	,cdIndicadorStatusProdutoTipoCultura
	,wkProdutoTipoCultura
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	)
	VALUES
	(
	 @cdProdutoSEQ
	,@cdTipoCulturaSEQ
	,2 -- Inativo
	,null
	,getdate()
	,@cdUsuarioUltimaAlteracao
	)



    FETCH NEXT FROM Cursor_Produtos 
    INTO 
		@cdProdutoSEQ

END 
CLOSE Cursor_Produtos
DEALLOCATE Cursor_Produtos



SET QUOTED_IDENTIFIER OFF

