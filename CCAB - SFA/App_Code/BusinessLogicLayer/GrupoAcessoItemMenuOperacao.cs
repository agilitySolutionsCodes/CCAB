using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for GrupoAcessoItemMenuOperacao
/// </summary>
public class GrupoAcessoItemMenuOperacao
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares


	public GrupoAcessoItemMenuOperacao()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
    }

    #region Métodos

    public DataTable Obter(Int64 cdGrupoAcessoSEQ, Int64 cdItemMenuSEQ, int cdIndicadorTipoMenuOperacao)
    {

        try
        {

            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcessoItemMenuOperacao", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdGrupoAcessoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
            }

            if (cdItemMenuSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = cdItemMenuSEQ;
            }

            if (cdIndicadorTipoMenuOperacao != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = cdIndicadorTipoMenuOperacao;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterHistorico(Int64 cdGrupoAcessoItemMenuOperacaoHistoricoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_S_GrupoAcessoItemMenuOperacaoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdGrupoAcessoItemMenuOperacaoHistoricoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoItemMenuOperacaoHistoricoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoItemMenuOperacaoHistoricoSEQ"].Value = cdGrupoAcessoItemMenuOperacaoHistoricoSEQ;
            }


            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public DataTable ObterListaHistorico(Int64 cdGrupoAcessoSEQ, Int64 cdItemMenuSEQ, int cdIndicadorTipoMenuOperacao)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_GrupoAcessoItemMenuOperacaoHistorico", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;



            if (cdGrupoAcessoSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;
            }

            if (cdItemMenuSEQ != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
                loSqlDataAdapter.SelectCommand.Parameters["@cdItemMenuSEQ"].Value = cdItemMenuSEQ;
            }

            if (cdIndicadorTipoMenuOperacao != 0)
            {
                loSqlDataAdapter.SelectCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
                loSqlDataAdapter.SelectCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = cdIndicadorTipoMenuOperacao;
            }

            loSqlDataAdapter.Fill(loDataTable);

            loSqlConnection.Close();
            loSqlConnection = null;

            return loDataTable;

        }
        catch (Exception loException)
        {
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            throw new Exception(moPadrao.MensagemErroObtencao);
        }
    }

    public string Incluir(Int64 cdGrupoAcessoSEQ, Int64 cdItemMenuSEQ, int cdIndicadorTipoMenuOperacao, int cdIndicadorStatusGrupoAcessoItemMenuOperacao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransGrupoAcessoItemMenuOperacao");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_GrupoAcessoItemMenuOperacao";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

            loSqlCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdItemMenuSEQ"].Value = cdItemMenuSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = cdIndicadorTipoMenuOperacao;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusGrupoAcessoItemMenuOperacao", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusGrupoAcessoItemMenuOperacao"].Value = cdIndicadorStatusGrupoAcessoItemMenuOperacao;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;


            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransGrupoAcessoItemMenuOperacao");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(Int64 cdGrupoAcessoSEQ, Int64 cdItemMenuSEQ, int cdIndicadorTipoMenuOperacao, int cdIndicadorStatusGrupoAcessoItemMenuOperacao)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;


            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TransGrupoAcessoItemMenuOperacao");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_U_GrupoAcessoItemMenuOperacao";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdGrupoAcessoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdGrupoAcessoSEQ"].Value = cdGrupoAcessoSEQ;

            loSqlCommand.Parameters.Add("@cdItemMenuSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdItemMenuSEQ"].Value = cdItemMenuSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorTipoMenuOperacao", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorTipoMenuOperacao"].Value = cdIndicadorTipoMenuOperacao;

            loSqlCommand.Parameters.Add("@cdIndicadorStatusGrupoAcessoItemMenuOperacao", SqlDbType.Int);
            loSqlCommand.Parameters["@cdIndicadorStatusGrupoAcessoItemMenuOperacao"].Value = cdIndicadorStatusGrupoAcessoItemMenuOperacao;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = moUsuario.cdUsuario;


            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TransGrupoAcessoItemMenuOperacao");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroAlteracao;
        }
    }

    #endregion Métodos
}
