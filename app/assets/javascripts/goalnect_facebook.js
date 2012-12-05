function postToFeed(url, title, return_url, image_container) {
  // calling the API ...

  // imgSrc = image_container.find("img").attr("src");
  // alert(imgSrc);     

  var obj = {
    method: 'feed',
    redirect_uri: return_url,
    link: url,
    name: title
  };
  function callback(response) {
    document.getElementById('msg').innerHTML = "Post ID: " + response['post_id'];
  }
  FB.ui(obj, callback);
}
