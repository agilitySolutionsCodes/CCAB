<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        
    }
    
    void Application_End(object sender, EventArgs e) 
    {
       
    }
        
    void Application_Error(object sender, EventArgs e) 
    {
        /*
        try
        {
            System.Exception ex = (System.Exception)Server.GetLastError().GetBaseException();
            Server.ClearError();
            Response.Redirect("~/Message.aspx?tp=err&msg=" + ex.Message.ToString());
        }
        catch 
        {
            //Server.Transfer("~/Message.aspx?tp=err&msg=Ocorreu uma exceção não documentada.");
        }
        */
    }

    void Session_Start(object sender, EventArgs e) 
    {
        
    }

    void Session_End(object sender, EventArgs e) 
    {
        
    }
       
</script>
