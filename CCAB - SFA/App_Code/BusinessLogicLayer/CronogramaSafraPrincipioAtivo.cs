using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for CronogramaSafraPrincipioAtivo
/// </summary>
public class CronogramaSafraPrincipioAtivo
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CronogramaSafraPrincipioAtivo()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
	}

    #region Métodos

    public string Incluir(int cdCronogramaSafraSEQ, int cdCooperativaSEQ, int cdFornecedorPrincipioAtivo, int cdIndicadorPrincipioAtivo, int cdIndicadorProdutoAcabado, string wkCooperativaPrincipioAtivo, int cdUsuarioUltimaAlteracao, int cdTipoProduto)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }            

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaPrincipioAtivo");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CooperativaPrincipioAtivo";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaPrincipioAtivoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaPrincipioAtivoSEQ"].Value = (object)DBNull.Value;            

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;

            loSqlCommand.Parameters.Add("@cdFornecedorPrincipioAtivo", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdFornecedorPrincipioAtivo"].Value = cdFornecedorPrincipioAtivo.Equals(0) ? (object)DBNull.Value : cdFornecedorPrincipioAtivo;

            loSqlCommand.Parameters.Add("@cdIndicadorPrincipioAtivo", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorPrincipioAtivo"].Value = cdIndicadorPrincipioAtivo.Equals(0) ? (object)DBNull.Value : cdIndicadorPrincipioAtivo;

            loSqlCommand.Parameters.Add("@cdIndicadorProdutoAcabado", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorProdutoAcabado"].Value = cdIndicadorProdutoAcabado.Equals(0) ? (object)DBNull.Value : cdIndicadorProdutoAcabado;

            loSqlCommand.Parameters.Add("@wkCooperativaPrincipioAtivo", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaPrincipioAtivo"].Value = string.IsNullOrEmpty(wkCooperativaPrincipioAtivo) ? (object)DBNull.Value : wkCooperativaPrincipioAtivo;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdTipoProduto", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdTipoProduto"].Value = cdTipoProduto;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(int cdCooperativaPrincipioAtivoSEQ, int cdIndicadorPrincipioAtivo, int cdIndicadorProdutoAcabado, string wkCooperativaPrincipioAtivo, int cdUsuarioUltimaAlteracao, int cdTipoProduto)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {
            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;

            //Consistências
            if (cdUsuarioUltimaAlteracao == 0)
            {
                return "Usuário" + moPadrao.MensagemObrigatorio;
            }

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaPrincipioAtivo");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_CooperativaPrincipioAtivo";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCooperativaPrincipioAtivoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaPrincipioAtivoSEQ"].Value = cdCooperativaPrincipioAtivoSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaPrincipioAtivoSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdFornecedorPrincipioAtivo", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdFornecedorPrincipioAtivo"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdIndicadorPrincipioAtivo", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorPrincipioAtivo"].Value = cdIndicadorPrincipioAtivo.Equals(0) ? (object)DBNull.Value : cdIndicadorPrincipioAtivo;

            loSqlCommand.Parameters.Add("@cdIndicadorProdutoAcabado", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorProdutoAcabado"].Value = cdIndicadorProdutoAcabado.Equals(0) ? (object)DBNull.Value : cdIndicadorProdutoAcabado;

            loSqlCommand.Parameters.Add("@wkCooperativaPrincipioAtivo", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaPrincipioAtivo"].Value = string.IsNullOrEmpty(wkCooperativaPrincipioAtivo) ? (object)DBNull.Value : wkCooperativaPrincipioAtivo;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.Parameters.Add("@cdTipoProduto", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdTipoProduto"].Value = cdTipoProduto;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraVencimento");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }
    
    public DataTable ObterLista(Int64 cdCronogramaSafraSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaPrincipioAtivo", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;


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

    public DataTable Obter(Int64 cdCooperativaPrincipioAtivoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaPrincipioAtivo", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaPrincipioAtivoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaPrincipioAtivoSEQ"].Value = cdCooperativaPrincipioAtivoSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaPrincipioAtivoSEQ;


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

    public int ObterTipoProduto(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaPrincipioAtivo", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        if (!loDataTable.Rows.Count.Equals(0))
        {
            return Convert.ToInt32(loDataTable.Rows[0]["cdTipoProduto"]);
        }
        else
        {
            return 0;
        }

        
    }

    public string Excluir(Int64 cdCronogramaSafraVencimentoSEQ)
    {
        SqlTransaction loSqlTransaction = null;

        try
        {

            SqlConnection loSqlConnection = null;
            SqlCommand loSqlCommand = null;
   

            loSqlConnection = new SqlConnection(msStringConexao);
            loSqlConnection.Open();
            loSqlCommand = loSqlConnection.CreateCommand();
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraPricipioAtivo");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CronogramaSafraPricipioAtivo";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaPrincipioAtivoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaPrincipioAtivoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraPricipioAtivo");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public bool Existe(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaPrincipioExiste", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);       
        
    }

    #endregion Métodos
}
