<%@ Page Title="" Language="C#" MasterPageFile="~/LandingPages/LandingMaster.Master" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="TestArtSell.LandingPages.Contacts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false" type="text/javascript"></script>
    <script>
        var mapcode;
        var diag;
        function initialize() {
            mapcode = new google.maps.Geocoder();
            var lnt = new google.maps.LatLng(26.45, 82.85);
            var diagChoice = {
                zoom: 9,
                center: lnt,
                diagId: google.maps.MapTypeId.ROADMAP
            }
            diag = new google.maps.Map(document.getElementById('map_populate'), diagChoice);
        }
        function getmap() {
            var completeaddress = document.getElementById('txt_location').value;
            mapcode.geocode({ 'address': completeaddress }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    diag.setCenter(results[0].geometry.location);
                    var hint = new google.maps.Marker({
                        diag: diag,
                        position: results[0].geometry.location
                    });
                } else {
                    alert('Location Not Tracked. ' + status);
                }
            });
        }
        google.maps.event.addDomListener(window, 'load', initialize);
    </script>

    <style>
        .input-field {
            border:1px solid #808080;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section id="primary" class="content-full-width">
        <!-- **Primary Starts Here** -->
        <div class="fullwidth-section">
            <!-- Full-width section Starts Here -->
            <div class="container">
                <div class="main-title " data-animation="pullDown" data-delay="100">
                    <h3>Contact </h3>

                </div>
            </div>

            <div class="dt-sc-hr-invisible-toosmall"></div>
            <div class="container">
                <div class="dt-sc-three-fourth column first " data-animation="fadeInDown" data-delay="100">
                    <h3>How to find us</h3>

                    <div class="column dt-sc-one-third first">
                        <p class="input-text">
                           <h4>Artsell.xyx</h4>
                           <h5>House: 20, Road: 12, Shekertek</h5>
                           <h5>Mohammdpur, Dhaka-1207</h5>
                            <h5>Email: info@artsell.xyz</h5>
                            <h5>Mobile: +8801676083523</h5>
                        </p>
                    </div>
       

                </div>
                <div class="dt-sc-three-fourth column first " data-animation="fadeInDown" data-delay="100">
                    <h3>Get in Touch</h3>

                    <div class="column dt-sc-one-third first">
                        <p class="input-text">
                            <input runat="server" id="txtName" class="input-field" type="text" style="background-color: white; font-size: 15px; font-weight: bold; color: black" required="" name="txtname" title="Enter your Name" placeholder="Name *" />
                        </p>
                    </div>
                    <div class="column dt-sc-one-third">
                        <p class="input-text">
                            <input runat="server" id="txtEmail" class="input-field" type="email" style="background-color: white; font-size: 15px; font-weight: bold; color: black" required="" autocomplete="off" name="txtemail" title="Enter your valid id" placeholder="Email *" />
                        </p>
                    </div>
                    <div class="column dt-sc-one-third">
                        <p class="input-text">
                            <input runat="server" id="txtWebsite" class="input-field" type="text" style="background-color: white; font-size: 15px; font-weight: bold; color: black" autocomplete="off" placeholder="Website" />
                        </p>
                    </div>
                    <p class="input-text" style="padding: 15px 0px">
                        <textarea runat="server" id="txtMessage" class="input-field" style="background-color: white; font-size: 15px; font-weight: bold; color: black" required="" rows="3" cols="5" name="txtmessage" title="Enter your Message" placeholder="Message *"></textarea>
                    </p>

                    <p class="submit">
                        <input type="submit" runat="server" id="btnSubmit" value="Send" style="color:white" name="submit" class="dt-sc-button small type2" onserverclick="btnSubmit_Click" />
                    </p>


                </div>
                <div class="container">
                    <div class="main-title " data-animation="pullDown" data-delay="100">
                        <h3>Find Us </h3>

                    </div>
                </div>
                <div class="container" style="padding: 0px;">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d228.21020820230228!2d90.35528711365457!3d23.770072874659398!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755c19ec109ade3%3A0x385ed2fa6d2a2860!2sCha%20Bella!5e0!3m2!1sen!2sbd!4v1625400090225!5m2!1sen!2sbd" width="100%" height="450" frameborder="0" style="border: 0;" allowfullscreen=""></iframe>
                </div>51.153

            </div>
        </div>
        <!-- Full-width section Ends Here -->
    </section>
    <!-- **Primary Ends Here** -->
</asp:Content>
