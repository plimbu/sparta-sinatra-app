$(function() {


  function generateRandomForBG() {
    var num = Math.floor(Math.random() * 3);
    return num;
  }
  setInterval(function() {
      var number = generateRandomForBG().toString();

      $("body").css("background-image", "url('../img/bg" + number + ".jpg')").fadeIn();
    }, 900
  )
});
