using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for CronogramaSafraCooperativa
/// </summary>
public class CronogramaSafraCooperativa
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CronogramaSafraCooperativa()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
	}

    #region Métodos

    public string Incluir(int cdCronogramaSafraSEQ, int cdCooperativaSEQ, int cdIndicadorSituacaoCooperativa, string wkCronogramaSafraCooperativa, int cdUsuarioUltimaAlteracao)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraCooperativa");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CronogramaSafraCooperativa";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCronogramaSafraCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraCooperativaSEQ"].Value = (object)DBNull.Value;            

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;

            loSqlCommand.Parameters.Add("@cdIndicadorSituacaoCooperativa", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorSituacaoCooperativa"].Value = cdIndicadorSituacaoCooperativa.Equals(0) ? (object)DBNull.Value : cdIndicadorSituacaoCooperativa;

            loSqlCommand.Parameters.Add("@wkCronogramaSafraCooperativa", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCronogramaSafraCooperativa"].Value = string.IsNullOrEmpty(wkCronogramaSafraCooperativa) ? (object)DBNull.Value : wkCronogramaSafraCooperativa;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";

        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraCooperativa");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(int cdCronogramaSafraCooperativaSEQ, int cdIndicadorSituacaoCooperativa, string wkCronogramaSafraCooperativa, int cdUsuarioUltimaAlteracao)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraCooperativa");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_CronogramaSafraCooperativa";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraCooperativaSEQ"].Value = cdCronogramaSafraCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraCooperativaSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdPessoaSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdIndicadorSituacaoCooperativa", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorSituacaoCooperativa"].Value = cdIndicadorSituacaoCooperativa.Equals(0) ? (object)DBNull.Value : cdIndicadorSituacaoCooperativa;

            loSqlCommand.Parameters.Add("@wkCronogramaSafraCooperativa", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCronogramaSafraCooperativa"].Value = string.IsNullOrEmpty(wkCronogramaSafraCooperativa) ? (object)DBNull.Value : wkCronogramaSafraCooperativa;

            loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

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
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraCooperativa", loSqlConnection);

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

    public DataTable Obter(Int64 cdCronogramaSafraCooperativaSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraCooperativa", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraCooperativaSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraCooperativaSEQ"].Value = cdCronogramaSafraCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraCooperativaSEQ;


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
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraCooperativa", loSqlConnection);

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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraCooperativa");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CronogramaSafraCooperativa";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCronogramaSafraCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraCooperativaSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraCooperativa");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public bool Existe(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraCooperativaExiste", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdPessoaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);       
        
    }

    public bool ExisteCarga(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraCooperativaExisteCarga", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);

    }

    public bool ExistePedido(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CronogramaSafraCooperativaPedidoExiste", loSqlConnection);

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
