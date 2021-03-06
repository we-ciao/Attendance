﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ApplyHolidy.aspx.cs" Inherits="Attendance.Manage.ApplyHolidy" %>

<%@ Register Src="~/UserControl/ControlTemplate.ascx" TagPrefix="uc1" TagName="ControlTemplate" %>


<asp:Content ID="Head" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <title>Attendance - ApplyHolidy</title>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="templatemo-content-widget white-bg">
        <h2 class="text-uppercase">查看 / 审批</h2>
        <div class="panel-body">
            <div class="templatemo-flex-row flex-content-row">
                <div class="col-1">
                    <div id="timeline_div" class="templatemo-chart"></div>
                    <div class="row form-group">
                        <div class="col-lg-1 col-md-2 form-group">
                        </div>
                        <div class="col-lg-3 col-md-2 form-group">
                            <asp:TextBox ID="txtSearchTitle" runat="server" CssClass="form-control margin-bottom-5" placeholder="标题" Style="float: left"></asp:TextBox>
                            <asp:TextBox ID="txtsearchUser" runat="server" CssClass="form-control margin-bottom-5" placeholder="申请人" Style="float: left" onclick="WdatePicker()"></asp:TextBox>
                        </div>
                        <div class="col-lg-3 col-md-2 form-group">
                            <asp:TextBox ID="txtSearchStar" runat="server" CssClass="form-control margin-bottom-5" placeholder="申请起始时间" Style="float: left" onclick="WdatePicker()"></asp:TextBox>
                            <asp:TextBox ID="txtSearchEnd" runat="server" CssClass="form-control" placeholder="申请结束时间" Style="float: left" onclick="WdatePicker()"></asp:TextBox>
                        </div>
                        <div class="col-lg-3 col-md-4 form-group">
                            <p>请假单状态：</p>
                            <asp:RadioButtonList ID="rblStatus" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Value="0"><span></span>待审批</asp:ListItem>
                                <asp:ListItem Value="1"><span></span>归档</asp:ListItem>
                                <asp:ListItem Value="" Selected="True"><span></span>全部</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="col-lg-2 col-md-12  form-group" style="padding-top: 18px">
                            <asp:Button ID="btnSearch" runat="server" Text="查询" CssClass="templatemo-blue-button"
                                OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="tem0platemo-content-widget no-padding">
        <div class="panel panel-default table-responsive">
            <asp:GridView ID="gdvinfo" CssClass="table table-striped table-bordered templatemo-user-table gdvinfo" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                AllowPaging="True" OnSorting="gdvinfo_Sorting" Style="text-align: center" AllowCustomPaging="True">
                <EmptyDataTemplate>
                    <div style="text-align: center">没有查询到数据，请检查查询条件是否正确</div>
                </EmptyDataTemplate>
                <Columns>
                    <asp:TemplateField HeaderText='请假单ID' InsertVisible="False">
                        <ItemStyle />
                        <ItemTemplate>
                            <asp:Label ID="LabelID" runat="server" Text='<%# Bind("ApproveID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">申请人<span class="caret"></span></div>' SortExpression="UserName">
                        <ItemTemplate>
                            <asp:Label ID="LabelName" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='标题'>
                        <ItemTemplate>
                            <asp:Label ID="LabelTitle" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">起始时间<span class="caret"></span></div>' SortExpression="BeginDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelBeginDate" runat="server" Text='<%# Convert.ToDateTime( Eval("BeginDate")).ToString("yyyy-MM-dd HH:mm")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">结束时间<span class="caret"></span></div>' SortExpression="EndDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelEndDate" runat="server" Text='<%# Convert.ToDateTime( Eval("EndDate")).ToString("yyyy-MM-dd HH:mm") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText='<div style="width:100%;text-align :center">申请时间<span class="caret"></span></div>' SortExpression="ApplyDate">
                        <ItemTemplate>
                            <asp:Label ID="LabelApplyDate" runat="server" Text='<%# Convert.ToDateTime( Eval("ApplyDate")).ToString("yyyy-MM-dd HH:mm") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="statusname" HeaderText="请假单状态" />
                    <asp:TemplateField HeaderText="" ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="lbtnView" runat="server" CssClass="InfoView" OnClientClick="return false">查看</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle BackColor="#39ADB4" CssClass="white-text templatemo-sort-by" ForeColor="White" />
                <PagerSettings Mode="Numeric" />
            </asp:GridView>
            <uc1:ControlTemplate runat="server" ID="ControlTemplate" OnDateBind="Bind" />
        </div>
    </div>
</asp:Content>

<asp:Content ID="Hide" ContentPlaceHolderID="ContentPlaceHolderHide" runat="server">
    <div id="diveditout" class="TipBoxComantion diveditout">
        <div class="templatemo-flex-row flex-content-row">
            <div class="col-2">
                <div class="panel panel-default margin-10">
                    <div class="panel-heading">
                        <h2 class="text-uppercase"><+>请假信息</h2>
                    </div>
                    <div class="panel-body" runat="server">
                        <div class="col-lg-6 col-md-6 form-group">
                            <label for="inputFirstName" style="float: left">请假单号：</label>
                            <asp:Label ID="LabViewID" runat="server" Text="???" Style="float: left"></asp:Label>
                        </div>
                        <div class="col-lg-6 col-md-6 form-group">
                            <label for="inputLastName">申请人：</label>
                            <asp:Label ID="LabViewName" runat="server" Text="???"></asp:Label>
                        </div>
                        <div class="col-lg-2 col-md-2 form-group" style="padding-top: 5px;">
                            <label for="inputFirstName" style="float: left"><span style='color: red;'>*</span>标题：</label>
                        </div>
                        <div class="col-lg-10 col-md-10 form-group">
                            <asp:TextBox ID="txtViewTitle" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-lg-6 col-md-6 form-group">
                            <label for="inputFirstName"><span style='color: red;'>*</span>起始时间：</label><br />
                            <asp:TextBox ID="txtViewStar" runat="server" class="form-control" Style="width: 60%; float: left" ReadOnly="true"></asp:TextBox>
                            <asp:DropDownList ID="drpViewStart" runat="server" CssClass="form-control" Style="width: 40%; float: left" Enabled="false">
                                <asp:ListItem Selected="True" Value="08:30:00">8:30</asp:ListItem>
                                <asp:ListItem Value="11:50:00">11:50</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-lg-6 col-md-6 form-group">
                            <label for="inputFirstName"><span style='color: red;'>*</span>结束时间：</label><br />
                            <asp:TextBox ID="txtViewEnd" runat="server" class="form-control" Style="width: 60%; float: left" ReadOnly="true"></asp:TextBox>
                            <asp:DropDownList ID="drpViewEnd" runat="server" CssClass="form-control" Style="width: 40%; float: left" Enabled="false">
                                <asp:ListItem Value="11:50:00">11:50</asp:ListItem>
                                <asp:ListItem Selected="True" Value="17:00:00">17:00</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-lg-12 col-md-10 form-group">
                            <label for="inputFirstName"><span style='color: red;'>*</span>请假原因：</label>
                            <asp:TextBox ID="txtViewRes" runat="server" class="form-control" Rows="2" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-1">
                <div class="panel panel-default margin-10">
                    <div class="panel-heading">
                        <h2 class="text-uppercase"><+>审批信息</h2>
                    </div>
                    <div class="panel-body" runat="server">
                        <div class="col-lg-12 col-md-12 form-group">
                            <label for="inputFirstName">请假时间：</label>
                            <asp:Label ID="LabHoliTime" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="col-lg-6 col-md-6 form-group" style="padding-top: 5px;">
                            <label for="inputFirstName"><span style='color: red;'>*</span>申请结果：</label>
                        </div>
                        <div class="col-lg-6 col-md-6 form-group">
                            <asp:DropDownList ID="ddlRes" runat="server" CssClass="form-control" Style="float: left">
                                <asp:ListItem Selected="True" Value="">请选择</asp:ListItem>
                                <asp:ListItem Value="1">同意</asp:ListItem>
                                <asp:ListItem Value="0">不同意</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-lg-12 col-md-10 form-group">
                            <label for="inputFirstName">审批人：</label>
                            <asp:Label ID="LabName" runat="server" Text=""></asp:Label>
                        </div>
                        <div class="col-lg-12 col-md-10 form-group">
                            <label for="inputFirstName">审批时间：</label>
                            <asp:Label ID="LabAppleTime" runat="server" Text=""></asp:Label>
                        </div>

                        <div class="col-lg-12 col-md-10 form-group">
                            <label for="inputFirstName">备注：</label>
                            <asp:TextBox ID="TxtText" runat="server" class="form-control" Rows="3" TextMode="MultiLine"></asp:TextBox>
                        </div>

                        <div class="row form-group" style="text-align: center;">
                            <div class="col-lg-12 col-md-12 form-group">
                                <asp:Label ID="Label3" runat="server" Text="" Style="display: none; color: #d7425c"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <asp:Button ID="btnSub" runat="server" Text="确定" OnClick="btnedit_Click" CssClass="templatemo-blue-button" />
                            <button class="templatemo-white-button" type="reset" onclick="TipClose()">关闭</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>




    <div id="addoutc" class="out"></div>

    <asp:HiddenField runat="server" ID="AppID" Value="" />
</asp:Content>

<asp:Content ID="script" ContentPlaceHolderID="Script" runat="server">
    <script type="text/javascript">

        $(function () {

            $(".InfoView").click(function () {
                //display
                $(".diveditout").fadeIn(500);
                $("#addoutc").fadeIn(500);

                //getelement
                var obj = event.srcElement;
                while (obj.tagName != "TR") {
                    obj = obj.parentElement;
                }
                var userid = obj.children[0].innerText;
                $("#<%=LabViewID.ClientID %>").text(userid);
                $("#<%=AppID.ClientID %>").val(userid);
                $("#<%=LabViewName.ClientID %>").text(obj.children[1].innerText);
                $("#<%=txtViewTitle.ClientID %>").val(obj.children[2].innerText);
                $("#<%=LabHoliTime.ClientID %>").text(obj.children[5].innerText);

                var startime = obj.children[3].innerText;
                $("#<%=txtViewStar.ClientID %>").val(startime.substr(0, 10));
                for (var i = 0; i < document.getElementById("<%=drpViewStart.ClientID %>").options.length; i++) {
                    if (document.getElementById("<%=drpViewStart.ClientID %>").options[i].text == startime.substr(11, 5).trim())
                        document.getElementById("<%=drpViewStart.ClientID %>").options[i].selected = true;
                }

                var endtime = obj.children[4].innerText;
                $("#<%=txtViewEnd.ClientID %>").val(endtime.substr(0, 10));
                for (var i = 0; i < document.getElementById("<%=drpViewEnd.ClientID %>").options.length; i++) {
                    if (document.getElementById("<%=drpViewEnd.ClientID %>").options[i].text == endtime.substr(11, 5).trim())
                        document.getElementById("<%=drpViewEnd.ClientID %>").options[i].selected = true;
                }

                $.ajax({
                    type: "Post",
                    url: "ApplyHolidy.aspx/GetRes",
                    async: false,
                    data: "{'str':'" + userid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        document.getElementById("<%=txtViewRes.ClientID %>").value = data.d;
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                var status = obj.children[6].innerText
                if (status == "待审核") {
                    document.getElementById("<%=TxtText.ClientID %>").removeAttribute("readOnly");
                    document.getElementById("<%=ddlRes.ClientID %>").removeAttribute("disabled");
                    document.getElementById("<%=ddlRes.ClientID %>").options[0].selected = true;
                    $("#<%=LabName.ClientID %>").text("");
                    $("#<%=LabAppleTime.ClientID %>").text("");
                    $("#<%=TxtText.ClientID %>").val("");
                    $("#<%=btnSub.ClientID %>").show();
                } else {
                    $("#<%=btnSub.ClientID %>").hide();
                    // document.getElementById("<%=btnSub.ClientID %>").style.visibility = "hidden";
                    $.ajax({
                        type: "Post",
                        url: "ApplyHolidy.aspx/GetApply",
                        async: false,
                        data: "{'str':'" + userid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var ss = (data.d).split(",");
                            for (var i = 0; i < document.getElementById("<%=ddlRes.ClientID %>").options.length; i++) {
                                if (document.getElementById("<%=ddlRes.ClientID %>").options[i].value == ss[0])
                                    document.getElementById("<%=ddlRes.ClientID %>").options[i].selected = true;
                            }
                            $("#<%=LabName.ClientID %>").text(ss[1]);
                            $("#<%=LabAppleTime.ClientID %>").text(ss[2]);
                            $("#<%=TxtText.ClientID %>").val(ss[3]);
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    document.getElementById("<%=TxtText.ClientID %>").setAttribute("readOnly", "true");
                    document.getElementById("<%=ddlRes.ClientID %>").setAttribute("disabled", "false");
                }


            });




            $("#<%=btnSub.ClientID %>").click(function () {
                var obj = document.getElementById("<%=ddlRes.ClientID %>");
                if (obj.value == "") {
                    $(obj).parent().addClass("has-error");
                    return false;
                }
                else {
                    $(obj).parent().removeClass("has-error");
                    return true;
                }
            });

            $("#addoutc").click(function () {
                $("#addoutc").fadeOut(500);
                $("#exitout").fadeOut(500);
                $("#divaddout").fadeOut(500);
                $(".diveditout").fadeOut(500);
            });
        });
        function TipClose() {
            $("#addoutc").fadeOut(500);
            $("#divaddout").fadeOut(500);
            $(".diveditout").fadeOut(500);
        }


    </script>
</asp:Content>
