IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_Gerar_Template_SP_S_Historico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_Gerar_Template_SP_S_Historico]
END
GO

CREATE PROCEDURE [dbo].[SP_Gerar_Template_SP_S_Historico]
	@NomeTabela		varchar(255)
AS

print 'set ANSI_NULLS ON'
print 'set QUOTED_IDENTIFIER ON'

print ''

print '/******************************************************************************'
print '**		File: SP_S_' + @NomeTabela + 'Historico.sql'
print '**		Name: SP_S_' + @NomeTabela + 'Historico'
print '**		Desc: Obtem um de registro da tabela ' + @NomeTabela + 'Historico'
print '**'
print '**		Auth: Convergence'
print '**		Date: ' + convert(varchar, getdate(), 103)
print '*******************************************************************************'
print '**		Change History'
print '*******************************************************************************'
print '**		Date:			Author:					Description:'
print '**'
print '*******************************************************************************/'

print ''

print 'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[SP_S_' + @NomeTabela + 'Historico]''))'
print 'BEGIN'
print '	DROP PROCEDURE [dbo].[SP_S_' + @NomeTabela + 'Historico]'
print 'END'
print 'GO'

print ''

print 'CREATE PROCEDURE [dbo].[SP_S_' + @NomeTabela + 'Historico]'

declare
	 @Nome			varchar(255)
	,@Tipo			varchar(255)
	,@Tamanho		int
	,@Escala		int
	,@Obrigatorio	int
	,@Contador		int
	,@Linha			varchar(max)
	,@LinhaAux		varchar(max)
	,@Chave			varchar(max)

select
	@Contador = 0

--cursor dos campos
DECLARE Cursor_Campos CURSOR FOR 
	select 
		 syscolumns.name		as Nome
		,systypes.name			as Tipo
		,syscolumns.prec		as Tamanho
		,syscolumns.scale		as Escala
		,syscolumns.isnullable	as Obrigatorio

	from 
		 syscolumns
		,sysobjects
		,systypes
	where 
		upper(sysobjects.name) = upper(@NomeTabela + 'historico')
	and sysobjects.id = syscolumns.id
	and (sysobjects.xtype='U' or sysobjects.xtype='S')
	and syscolumns.xtype = systypes.xtype
	and syscolumns.colid = 1

OPEN Cursor_Campos

FETCH NEXT FROM Cursor_Campos 
INTO 
	 @Nome
	,@Tipo
	,@Tamanho
	,@Escala
	,@Obrigatorio

WHILE @@FETCH_STATUS = 0
BEGIN
    
	select
		 @Linha = '	 @' + @Nome
		,@Chave = @Nome
	
	select
		 @Tipo = upper(@Tipo)
		,@Linha = @Linha + '	' + upper(@Tipo)

	print @Linha


	select
		@Contador = @Contador + 1

    FETCH NEXT FROM Cursor_Campos 
    INTO 
		 @Nome
		,@Tipo
		,@Tamanho
		,@Escala
		,@Obrigatorio
END 
CLOSE Cursor_Campos
DEALLOCATE Cursor_Campos

print ''

print 'AS'
print ''

print '	--seleção'

print '	SELECT'
declare
	 @Campos		varchar(max)
	,@LinhaCampos	varchar(max)



select
	 @LinhaCampos	= ''
	,@Contador		= 0


--cursor dos campos
DECLARE Cursor_Campos CURSOR FOR 
	select 
		 syscolumns.name		as Nome
		,systypes.name			as Tipo
		,syscolumns.prec		as Tamanho
		,syscolumns.scale		as Escala
		,syscolumns.isnullable	as Obrigatorio

	from 
		 syscolumns
		,sysobjects
		,systypes
	where 
		upper(sysobjects.name) = upper(@NomeTabela + 'historico')
	and sysobjects.id = syscolumns.id
	and (sysobjects.xtype='U' or sysobjects.xtype='S')
	and syscolumns.xtype = systypes.xtype
	order by
		syscolumns.colid

OPEN Cursor_Campos

FETCH NEXT FROM Cursor_Campos 
INTO 
	 @Nome
	,@Tipo
	,@Tamanho
	,@Escala
	,@Obrigatorio

WHILE @@FETCH_STATUS = 0
BEGIN
    
	if @Contador > 0
	begin
		select
			 @Campos = '		,HIS.' + @Nome
	end
	else
	begin
		select
			 @Campos = '		 HIS.' + @Nome

			
	end
	
	select
		@LinhaCampos = @LinhaCampos + @Campos + char(13)


	select
		@Contador = @Contador + 1

    FETCH NEXT FROM Cursor_Campos 
    INTO 
		 @Nome
		,@Tipo
		,@Tamanho
		,@Escala
		,@Obrigatorio
END 
CLOSE Cursor_Campos
DEALLOCATE Cursor_Campos


print @LinhaCampos 

print'		,('
print'			CASE cdTipoEventoHistorico '
print'				WHEN 1 THEN ''Inclusão'''
print'				ELSE ''Alteração'''
print'			END	'
print'		)	as dsTipoEventoHistorico '

print char(13)

print'		,('
print'			SELECT '
print'				USU.dsLoginPessoa'
print'			FROM'
print'				dbo.Pessoa	USU	(nolock)'
print'			WHERE'
print'				USU.cdPessoaSEQ = HIS.cdUsuarioOcorrenciaHistorico'
print'		)	as nmUsuario'

print char(13)
print '	FROM' + char(13) + '		' + @NomeTabela + 'Historico	HIS		(nolock)	' + char(13)
print '	WHERE ' + char(13) + '		' + @Chave + ' = @' + @Chave



