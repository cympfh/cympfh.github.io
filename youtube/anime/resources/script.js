// YouTube Data API
var API_KEY = 'AIzaSyB83MKuf7spjfIYmCpXzTOu4jBuQSv3480';

var xhr = false;
var err;
function get(url, cont) {
  if (!xhr) {
    xhr = new XMLHttpRequest();
  }
  if (cont) { //async
    xhr.open('GET', url, true);
    xhr.onreadystatechange = function() {
      if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
        cont(xhr.responseText);
      }
    };
    xhr.send();
    return;
  }
  // sync
  xhr.open('GET', url, false);
  xhr.send();
  return xhr.responseText;
}

function search(keyword, cont) {
  var n = 3;
  var url = `https://www.googleapis.com/youtube/v3/search?key=${API_KEY}&part=snippet&q=${keyword}&safeSearch=none&type=video&videoDimension=2d&maxResults=${n}`;
  get(url, function(response) {
    try {
      var json = JSON.parse(response);
      return cont(json);
    } catch (e) {
      err = e;
      console.warn(e);
      return cont(null);
    }
  });
}

// YouTube IFrame API
var player;
function initPlayer() {
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/iframe_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
}

function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '195',
    width: '320',
    videId: ''
  });
}

function play(id) {
  player.cueVideoById(id, 0, 'large');
  player.playVideo();
}

// show the search results
function show(keyword) {
  /*
    .items[].id.videoId
    .items[].snippet.title
    .items[].snippet.thumbnails.high.url
  */
  function indent(obj) {
    var ret = [];
    for (var i = 0; i < obj.items.length; ++i) {
      var id = obj.items[i].id.videoId;
      var title = obj.items[i].snippet.title;
      var url = obj.items[i].snippet.thumbnails.high.url;
      ret[i] = {id: id, title: title, url: url};
    }
    return ret;
  }

  var X = document.getElementById('result');
  X.innerHTML = '';

  function append(q) {
    q = encodeURIComponent(q);
    search(q, function (response) {
      var items = indent(response);
      var buf = '';
      for (var item of items) {
        buf += `<div class="item"><img width="350px" onclick="play('${item.id}')" src="${item.url}"><input type=text value="${item.id} ${item.title}" style="width:300px" readonly="readonly"></div>`;
      }
      X.innerHTML += buf;
    });
  }

  append(keyword);
  setTimeout(function() {
    append(keyword + ' OP', 'search_op');
  }, 1000);
  setTimeout(function() {
    append(keyword + ' ED', 'search_ed');
  }, 500);
}

// anime list menu
function make_menu() {
  path = `./db/list?${(Math.random() * 10000)|0}`
  get(path, function (lines) {
    lines = lines.split("\n").filter(function (line) { return line.length > 2 });
    var buf = '';
    var id = '';
    for (var line of lines) {
      if (line[0] === '#') {
        id = line.slice(2);
        buf += `<span class=Q onclick='toggle("${id}")'>${id}</span>`;
      } else {
        buf += `<span class="item ${id} closed" onclick='show("${line}")'>${line}</span>`;
      }
    }
    document.getElementById('menu').innerHTML = buf;
  });
}

// anime list menu toggle
function toggle(id) {
  var items = document.getElementsByClassName('item');
  for (var i = 0; i < items.length; ++i) {
    var item = items[i];
    var classes = item.className.split(' ');
    if (classes[1] != id) continue;
    classes[2] = classes[2] == 'closed' ? 'open' : 'closed';
    item.className = classes.join(' ');
  }
}
