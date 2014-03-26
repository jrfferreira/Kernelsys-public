
/*
 * GET home page.
 */

 (function(exports){

    var fs = require('fs'),
        list = [],
        files = fs.readdirSync('edu/');

    files.forEach(function(el){
      list.push({id: el, name: el.replace('.kernelsys.xml','')});
    });

    exports.index = function(red,res){
      res.redirect('/list');
    };

    exports.list = function(req, res){

      res.render('index', { title: 'Lista de Tabelas',tableList: list});
    };

    exports.file = function(req, res){
      var xml2js = require('xml2js'),
          fileName = req.params.table,
          nodeName = fileName.replace('.kernelsys.xml',''),
          parser = new xml2js.Parser();

      fs.readFile('edu/'+fileName, function(err, data) {
          parser.parseString(data);

      });

      parser.addListener('end', function(result) {
        var nodes = result.kernelsys[nodeName][0].row,
            keys = [],
            lastSeq = 1;

        if(nodes && nodes.length > 0){
          for(i in nodes[0]){
            if(i != '$'){
              keys.push(i);
            }
          }
          nodes.forEach(function(el){
            var newSeq = parseInt(el.seq[0],10);
            lastSeq = newSeq > lastSeq ? newSeq : lastSeq;
          });
        }
        res.render('file', { title: nodeName, tableList: list, nodes: nodes, keys: keys, lastSeq: lastSeq});

      });

    };

    exports.save = function(req,res){

      var js2xmlparser = require('js2xmlparser'),
          data = {};
          data[req.params.table.replace('.kernelsys.xml','')] = JSON.parse(req.body.data);

      content = js2xmlparser("kernelsys", data);

      fs.writeFile('edu/'+req.params.table,content);

      res.send(data);
    };


 })(exports);
