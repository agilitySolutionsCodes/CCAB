set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_I_Produto_TipoCultura.sql
**		Name: SP_I_Produto_TipoCultura
**		Desc: Insere registros na tabela ProdutoTipoCultura no momento da alteração do Produto
**
**		Auth: Roberto Chaparro
**		Date: Mar 19 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_Produto_TipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_Produto_TipoCultura]
END
GO

CREATE PROCEDURE [dbo].[SP_I_Produto_TipoCultura]
	 @cdProdutoSEQ				bigint
	,@cdUsuarioUltimaAlteracao	bigint

AS

declare
	@cdTipoCulturaSEQ	bigint


DECLARE Cursor_Culturas CURSOR FOR 
	select 
		cdTipoCulturaSEQ
	from 
		dbo.TipoCultura
	where 
		cdIndicadorStatusTipoCultura = 1 -- Ativo
	

OPEN Cursor_Culturas

FETCH NEXT FROM Cursor_Culturas 
INTO 
	@cdTipoCulturaSEQ


WHILE @@FETCH_STATUS = 0
BEGIN

	IF not EXISTS	
				(
				SELECT 
					* 
				FROM 
					ProdutoTipoCultura 
				WHERE 
					cdProdutoSEQ		= @cdProdutoSEQ
				AND	cdTipoCulturaSEQ	= @cdTipoCulturaSEQ	
				)
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
	END





    FETCH NEXT FROM Cursor_Culturas 
    INTO 
		@cdTipoCulturaSEQ

END 
CLOSE Cursor_Culturas
DEALLOCATE Cursor_Culturas



SET QUOTED_IDENTIFIER OFF

