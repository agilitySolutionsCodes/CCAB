<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OnDemandSearch.ascx.cs" Inherits="_Comum_OnDemandSearch" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div style="text-align: left; position: relative; left: 0; top: 0;">
            <div style="position: relative; left: 0; top: 0; z-index: 10001; padding: 0">
                <asp:TextBox ID="TextBox1" runat="server" Height="15" />
                <%--<asp:ImageButton ID="ImageButton1" runat="server" 
                    ImageAlign="AbsMiddle" ImageUrl="DropArrow.gif" OnClick="Button_Click" />--%>
            </div>
            <div style="position: absolute; left: 0; top: 20; z-index: 10002">
                <asp:ListBox ID="ListBox1" runat="server" Visible="false"   
                    OnSelectedIndexChanged="SelectedIndexChanged" AutoPostBack="false" />            
            </div>
        </div>
    </ContentTemplate>
</asp:UpdatePanel>