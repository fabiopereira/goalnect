function postToFeed(url, title, return_url, image_container) {
  // calling the API ...
  var host = $('<a>').prop('href', url).prop('hostname');
  var imgSrc = host + $(image_container).find("img").attr("src");

  var obj = {
    method: 'feed',
    redirect_uri: return_url,
    link: url,
    picture: imgSrc,
    name: title
  };
  function callbackPostToFeed(response) {
    document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
  }
  FB.ui(obj, callbackPostToFeed);
}
