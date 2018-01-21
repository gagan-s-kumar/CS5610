function alterFunction() {
  alert(document.getElementById("h1").textContent);
}

function incrementFunction() {
  var newValue = parseInt(document.getElementById("h1").textContent) + 1;
  document.getElementById("h1").innerText = newValue;
}

function appendFunction() {
  var para = document.createElement("p");
  var node = document.createTextNode(document.getElementById("h1").textContent);
  para.appendChild(node);
  var element = document.getElementById("div1");
  element.appendChild(para);
}
