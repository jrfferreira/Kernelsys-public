(function (window, document) {

    var layout   = document.getElementById('layout'),
        menu     = document.getElementById('menu'),
        menuLink = document.getElementById('menuLink');

    function toggleClass(element, className) {
        var classes = element.className.split(/\s+/),
            length = classes.length,
            i = 0;

        for(; i < length; i++) {
          if (classes[i] === className) {
            classes.splice(i, 1);
            break;
          }
        }
        // The className is not found
        if (length === classes.length) {
            classes.push(className);
        }

        element.className = classes.join(' ');
    }

    menuLink.onclick = function (e) {
        var active = 'active';

        e.preventDefault();
        toggleClass(layout, active);
        toggleClass(menu, active);
        toggleClass(menuLink, active);
    };

    Array.prototype.forEach.call(document.getElementsByTagName("td"), function(el){
      el.addEventListener("input", function() {
          el.parentElement.classList.add('edited');
      }, false);
    });

    document.getElementById('add-line').addEventListener('click',function(){
      var scope = document.querySelector('tbody.list'),
          newTr = document.createElement('tr'),
          addLineButton = document.getElementById('add-line'),
          newId = parseInt(addLineButton.attributes['data-seq'].value,10)+1;;

          newTr.innerHTML = document.getElementById('node-element').innerHTML;

          newTr.id = addLineButton.attributes['data-seq'].value = newId;

          newTr.querySelector('[name=seq]').innerHTML = newTr.id;
          newTr.classList.add('new');
          newTr.classList.add('line');

          scope.appendChild(newTr);

          window.scrollTo(0, newTr.offsetTop);
    });

    document.getElementById('save').addEventListener('click',function(){
      var json = { row: [] };

      Array.prototype.forEach.call(document.querySelectorAll('.line'),function(el){
        var row = {
                    '@' : { "seq" : el.id }
                  };

        Array.prototype.forEach.call(el.querySelectorAll('td'), function(td){
          row[td.className] = td.innerHTML;
        });
        json.row.push(row);
      });

      var http = new XMLHttpRequest();
      var url = window.location;
      var params = 'data='+ JSON.stringify(json);
      http.open("POST", url, true);

      //Send the proper header information along with the request
      http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

      http.onreadystatechange = function() {//Call a function when the state changes.
          if(http.readyState == 4 && http.status == 200) {
              alert(http.responseText);
          }
      }
      http.send(params);

    });

}(this, this.document));
