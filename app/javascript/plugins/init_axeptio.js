const initAxeptio = () => {
  window.axeptioSettings = {
    clientId: "5fca4e9fde1c8731d1892986",
    cookiesVersion: "robin_des_fermes-base",
  };

  (function(d, s) {
    var t = d.getElementsByTagName(s)[0], e = d.createElement(s);
    e.async = true; e.src = "//static.axept.io/sdk.js";
    t.parentNode.insertBefore(e, t);
  })(document, "script");

  function launchFB(){
    !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
    n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
    n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
    t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
    document,'script','https://connect.facebook.net/en_US/fbevents.js');

    fbq('init', '159702201342042');
    fbq('set','agent','tmgoogletagmanager', '159702201342042');
    fbq('track', "PageView");
  }
  function launchGoogleAnalytics(){
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');
      ga('create', 'UA-00000000-1', 'auto');
      ga('send', 'pageview');
  }

  void 0 === window._axcb && (window._axcb = []);
  window._axcb.push(function(axeptio) {
   axeptio.on("cookies:complete", function(choices) {
     if(choices.facebook_pixel) {
       launchFB();
     }
     if(choices.google_analytics) {
       launchGoogleAnalytics();
     }
    });
  });
};

export { initAxeptio};
