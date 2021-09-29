<%@ Page Language="C#" MasterPageFile="~/General/UserMaster.Master"  AutoEventWireup="true" CodeBehind="SellerDashboard.aspx.cs" Inherits="TestArtSell.Seller.SellerDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .card {
            border-radius:10px;
            text-align:center;
        }
        .card:hover {
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Selling Target</div>
                            <div class="row no-gutters align-items-center">
                                <div class="col-auto">
                                    <asp:Label ID="lblPercentage" CssClass="h5 mb-0 mr-3 font-weight-bold text-gray-800" runat="server" Text="Label"></asp:Label>

                                </div>
                                <div class="col">
                                    <div class="progress progress-sm mr-2">
                                        <div class="progress-bar bg-info" role="progressbar" runat="server" id="lblprog" style="width: 80%" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Worth</div>
                                        <asp:Label ID="lblAmount" runat="server" CssClass="h5 mb-0 font-weight-bold text-gray-800" Text="0"></asp:Label>
                                        <%--      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>--%>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Sold</div>
                                        <asp:Label ID="lblSold" runat="server" CssClass="h5 mb-0 font-weight-bold text-gray-800" Text="0"></asp:Label>
                                        <%--      <div class="h5 mb-0 font-weight-bold text-gray-800">18</div>--%>
                                    </div>
                                    <div class="col-auto">
                                        <i class="fas fa-comments fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Order Requests</div>
                      <asp:Label ID="lblOrderReq" runat="server" CssClass="h5 mb-0 font-weight-bold text-gray-800" Text="18"></asp:Label>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-comments fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

    <br />

     <div >
                <div class="card">
                    <div class="card-body">
                        Your <i>Insights</i> feature will be added soon.
                        <br />
                        <br />
                        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-graph-up" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M0 0h1v15h15v1H0V0zm10 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-1 0V4.9l-3.613 4.417a.5.5 0 0 1-.74.037L7.06 6.767l-3.656 5.027a.5.5 0 0 1-.808-.588l4-5.5a.5.5 0 0 1 .758-.06l2.609 2.61L13.445 4H10.5a.5.5 0 0 1-.5-.5z"/>
</svg>
                    </div>
                </div>
                
               
            </div>
            <%--CHART PART--%>
            <div class="row" style="visibility:hidden">
                <div class="col-md-6">
                    <div class="card card-info">
                        <div class="card-header" style="background-color: #66cc99; color: black">
                            <i class="fa fa-pie-chart"></i><strong>Current Month Sell Summary</strong>
                        </div>
                        <div class="card-body" style="background-color:white">
                            <canvas id="pie-chart" width="800" height="450"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card card-info">
                        <div class="card-header" style="background-color: #66cc99; color: black">
                            <i class="fa fa-bar-chart"></i><strong>Monthly Sell Chart</strong>
                        </div>
                        <div class="card-body" style="background-color:white">
                            <canvas id="bar-chart" width="800" height="450"></canvas>
                        </div>
                    </div>
                </div>
            </div>

           
      
     <div>
            <asp:HiddenField ID="lblJan" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblFeb" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblMar" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblApr" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblMay" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblJun" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblJul" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblAug" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblSep" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblOct" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblNov" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblDec" runat="server" Value="25"></asp:HiddenField>
            <asp:HiddenField ID="lblEMpIDS" runat="server"></asp:HiddenField>
    
        </div>


        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
      
    <script>
    //NOTIFICATION BADGE 
    function myFunctionbday() {
        var x = document.getElementById("todaysBday");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";

        }
    }
    //FOR PIE CHART 
    var n1 = 5;
    var n2 = 13;
    var n3 = 50;

    new Chart(document.getElementById("pie-chart"), {

        type: 'pie',
        data: {
            labels: ["Aclyric", "Abstract", "Mixed"],
            datasets: [{
                label: "Employee",
                backgroundColor: ["#00cc99", "#ffff99", "#ff8566"],
                data: [n1, n3, n2]
            }]
        },
        options: {
            title: {
                display: true,
                text: 'Total Item Summary'
            }
        }
    });

    // FOR BAR CHART

    var jan = document.getElementById('ContentPlaceHolder1_lblJan').value;
    var feb = document.getElementById('ContentPlaceHolder1_lblFeb').value;
    var mar = document.getElementById('ContentPlaceHolder1_lblMar').value;
    var apr = document.getElementById('ContentPlaceHolder1_lblApr').value;
    var may = document.getElementById('ContentPlaceHolder1_lblMay').value;
    var jun = document.getElementById('ContentPlaceHolder1_lblJun').value;
    var jul = document.getElementById('ContentPlaceHolder1_lblJul').value;
    var aug = document.getElementById('ContentPlaceHolder1_lblAug').value;
    var sep = document.getElementById('ContentPlaceHolder1_lblSep').value;
    var oct = document.getElementById('ContentPlaceHolder1_lblOct').value;
    var nov = document.getElementById('ContentPlaceHolder1_lblNov').value;
    var dec = document.getElementById('ContentPlaceHolder1_lblDec').value;

    //console.log(dec);
    var max = Math.max(jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec);
    var MaxLate = parseInt(max);
    //

    new Chart(document.getElementById("bar-chart"), {
        type: 'bar',
        data: {
            labels: ["Jan", "Feb", "Mar", "April", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            datasets: [
                {
                    label: "BDT",
                    backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850", "#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850", "#3e95cd", "#8e5ea2"],
                    data: [jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec]
                }]
        },
        options: {
            legend: { display: false },
            title: {
                display: true,
                text: 'Monthly Sell Chart'
            },
            scales: {
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,
                        labelString: 'Month'
                    }
                }],
                yAxes: [{
                    display: true,
                    ticks: {
                        min: 0,
                        max: MaxLate + 2,
                        stepSize: 2
                    }
                }]
            }
        }
    });

</script>
</asp:Content>



