module ApplicationHelper
  def google_analytics_js
    '<script type="text/javascript">
       var _gaq = _gaq || [];
       _gaq.push([\'_setAccount\', \'UA-38755224-1\']);
       _gaq.push([\'_trackPageview\']);

      (function() {
        var ga = document.createElement(\'script\'); ga.type = \'text/javascript\'; ga.async = true;
        ga.src = (\'https:\' == document.location.protocol ? \'https://ssl\' : \'http://www\') + \'.google-analytics.com/ga.js\';
        var s = document.getElementsByTagName(\'script\')[0]; s.parentNode.insertBefore(ga, s);
      })();
    </script>'
  end

  def facebook_iframe
    '<iframe src="//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2Fpages%2FSzkolne-Memy%2F155102317977846&amp;width=700&amp;height=290&amp;show_faces=true&amp;colorscheme=light&amp;stream=false&amp;border_color&amp;header=true&amp;appId=438027702944655" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:700px; height:290px;" allowTransparency="true"></iframe>'
  end

  def twitter_timeline
    '<a class="twitter-timeline" href="https://twitter.com/szkolnememy" data-widget-id="305379134018830336">Tweets by @szkolnememy</a>
<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>'
  end

  def facebook_sdk
    '<div id="fb-root"></div>
     <script>
       window.fbAsyncInit = function() {
       // init the FB JS SDK
       FB.init({
         appId: \'438027702944655\', // App ID from the App Dashboard
         channelUrl: \'www.szkolnememy.pl\', // Channel File for x-domain communication
         status: true, // check the login status upon init?
         cookie: true, // set sessions cookies to allow your server to access the session?
         xfbml: true  // parse XFBML tags on this page?
       });

       // Additional initialization code such as adding Event Listeners goes here

     };

     // Load the SDK\'s source Asynchronously
     // Note that the debug version is being actively developed and might 
     // contain some type checks that are overly strict. 
     // Please report such bugs using the bugs tool.
     (function(d, debug){
       var js, id = \'facebook-jssdk\', ref = d.getElementsByTagName(\'script\')[0];
       if (d.getElementById(id)) {return;}
       js = d.createElement(\'script\'); js.id = id; js.async = true;
       js.src = "//connect.facebook.net/pl_PL/all" + (debug ? "/debug" : "") + ".js";
       ref.parentNode.insertBefore(js, ref);
     }(document, /*debug*/ false));
     </script>'
  end
end
