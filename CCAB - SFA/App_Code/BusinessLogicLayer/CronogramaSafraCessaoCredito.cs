using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
/// <summary>
/// Summary description for CronogramaSafraCessaoCredito
/// </summary>
public class CronogramaSafraCessaoCredito
{
    #region Variáveis Modulares

    HttpContext moHttpContext = HttpContext.Current;
    Usuario moUsuario = new Usuario();
    Padrao moPadrao = new Padrao();
    string msStringConexao;

    #endregion Variáveis Modulares

	public CronogramaSafraCessaoCredito()
	{
        moUsuario = (Usuario)moHttpContext.Session["Usuario"];
        msStringConexao = moPadrao.ObterStringConexao();
	}

    #region Métodos

    public string Incluir(int cdCronogramaSafraSEQ, int cdCooperativaSEQ, int cdIndicadorCessaoCredito, string wkCooperativaCessaoCredito, int cdUsuarioUltimaAlteracao, int cdIndicadorPedidoNormal, int cdIndicadorPedidoContaOrdem)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaCessaoCredito");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;


            loSqlCommand.CommandText = "SP_I_CooperativaCessaoCredito";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaCessaoCreditoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaCessaoCreditoSEQ"].Value = (object)DBNull.Value;            

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;
                        
            loSqlCommand.Parameters.Add("@cdIndicadorCessaoCredito", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorCessaoCredito"].Value = cdIndicadorCessaoCredito.Equals(0) ? (object)DBNull.Value : cdIndicadorCessaoCredito;

            loSqlCommand.Parameters.Add("@cdIndicadorPedidoNormal", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorPedidoNormal"].Value = cdIndicadorPedidoNormal.Equals(0) ? (object)DBNull.Value : cdIndicadorPedidoNormal;

            loSqlCommand.Parameters.Add("@cdIndicadorPedidoContaOrdem", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorPedidoContaOrdem"].Value = cdIndicadorPedidoContaOrdem.Equals(0) ? (object)DBNull.Value : cdIndicadorPedidoContaOrdem;

            loSqlCommand.Parameters.Add("@wkCooperativaCessaoCredito", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaCessaoCredito"].Value = string.IsNullOrEmpty(wkCooperativaCessaoCredito) ? (object)DBNull.Value : wkCooperativaCessaoCredito;

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
            loSqlTransaction.Rollback("TrCooperativaCessaoCredito");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroInclusao;
        }
    }

    public string Alterar(int cdCooperativaCessaoCreditoSEQ, int cdIndicadorCessaoCredito, string wkCooperativaCessaoCredito, int cdUsuarioUltimaAlteracao, int cdIndicadorPedidoNormal, int cdIndicadorPedidoContaOrdem)
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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCooperativaCessaoCredito");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_I_CooperativaCessaoCredito";
            loSqlCommand.CommandType = CommandType.StoredProcedure;

            loSqlCommand.Parameters.Add("@cdCooperativaCessaoCreditoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaCessaoCreditoSEQ"].Value = cdCooperativaCessaoCreditoSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaCessaoCreditoSEQ;

            loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = (object)DBNull.Value;

            loSqlCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaSEQ"].Value = (object)DBNull.Value;
                        
            loSqlCommand.Parameters.Add("@cdIndicadorCessaoCredito", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorCessaoCredito"].Value = cdIndicadorCessaoCredito.Equals(0) ? (object)DBNull.Value : cdIndicadorCessaoCredito;

            loSqlCommand.Parameters.Add("@cdIndicadorPedidoNormal", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorPedidoNormal"].Value = cdIndicadorPedidoNormal.Equals(0) ? (object)DBNull.Value : cdIndicadorPedidoNormal;

            loSqlCommand.Parameters.Add("@cdIndicadorPedidoContaOrdem", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdIndicadorPedidoContaOrdem"].Value = cdIndicadorPedidoContaOrdem.Equals(0) ? (object)DBNull.Value : cdIndicadorPedidoContaOrdem;


            loSqlCommand.Parameters.Add("@wkCooperativaCessaoCredito", SqlDbType.VarChar);
            loSqlCommand.Parameters["@wkCooperativaCessaoCredito"].Value = string.IsNullOrEmpty(wkCooperativaCessaoCredito) ? (object)DBNull.Value : wkCooperativaCessaoCredito;

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
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaCessaoCredito", loSqlConnection);

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

    public DataTable Obter(Int64 cdCooperativaCessaoCreditoSEQ)
    {

        try
        {
            DataTable loDataTable = new DataTable();

            SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
            SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaCessaoCredito", loSqlConnection);

            SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

            loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaCessaoCreditoSEQ", SqlDbType.BigInt);
            loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaCessaoCreditoSEQ"].Value = cdCooperativaCessaoCreditoSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaCessaoCreditoSEQ;


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
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaCessaoCredito", loSqlConnection);

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
            loSqlTransaction = loSqlConnection.BeginTransaction("TrCronogramaSafraCessaoCredito");
            loSqlCommand.Connection = loSqlConnection;
            loSqlCommand.Transaction = loSqlTransaction;

            loSqlCommand.CommandText = "SP_D_CronogramaSafraCessaoCredito";
            loSqlCommand.CommandType = CommandType.StoredProcedure;


            loSqlCommand.Parameters.Add("@cdCooperativaCessaoCreditoSEQ", SqlDbType.BigInt);
            loSqlCommand.Parameters["@cdCooperativaCessaoCreditoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

            loSqlCommand.ExecuteNonQuery();

            loSqlTransaction.Commit();

            loSqlConnection.Close();
            loSqlConnection = null;

            return "";
        }
        catch (Exception loException)
        {
            loSqlTransaction.Rollback("TrCronogramaSafraCessaoCredito");
            moPadrao.GravarLogErro(this.ToString(), loException.Message);
            return moPadrao.MensagemErroExclusao;
        }
    }

    public bool Existe(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaCessaoCreditoExiste", loSqlConnection);

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

    public bool ExisteCarga(int cdCronogramaSafraSEQ, int cdCooperativaSEQ, int tipo)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaCessaoCreditoExisteCarga", loSqlConnection);

        SqlCommand loSqlCommand = loSqlConnection.CreateCommand();

        loSqlDataAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ.Equals(0) ? (object)DBNull.Value : cdCronogramaSafraSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@cdCooperativaSEQ", SqlDbType.BigInt);
        loSqlDataAdapter.SelectCommand.Parameters["@cdCooperativaSEQ"].Value = cdCooperativaSEQ.Equals(0) ? (object)DBNull.Value : cdCooperativaSEQ;

        loSqlDataAdapter.SelectCommand.Parameters.Add("@Tipo", SqlDbType.Int);
        loSqlDataAdapter.SelectCommand.Parameters["@Tipo"].Value = tipo.Equals(0) ? (object)DBNull.Value : tipo;


        loSqlDataAdapter.Fill(loDataTable);

        loSqlConnection.Close();
        loSqlConnection = null;

        return Convert.ToBoolean(loDataTable.Rows[0][0]);

    }

    public bool ExistePedido(int cdCronogramaSafraSEQ, int cdCooperativaSEQ)
    {
        DataTable loDataTable = new DataTable();

        SqlConnection loSqlConnection = new SqlConnection(msStringConexao);
        SqlDataAdapter loSqlDataAdapter = new SqlDataAdapter("SP_G_CooperativaCessaoCreditoPedidoExiste", loSqlConnection);

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
