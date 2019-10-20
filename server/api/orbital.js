const express = require('express');
const path = require('path');
const router = express.Router();
const fs = require('fs');
const _ = require('lodash/core');

router.get("/", (req, res, next) => {
  let date = new Date();
  let dir = "scrap";
  let directoryPath = path.join(__dirname, dir);
  if (!fs.existsSync(directoryPath)){
    fs.mkdirSync(directoryPath);
  } else {
    fs.readdir(directoryPath, function (err, files) {
      if (err) {
          return console.log('Unable to scan directory: ' + err);
      }
      if (_.isEmpty(files)) {
        fs.writeFile(directoryPath + '/' + date.toISOString() + '.json','12345', function (err) {
          if (err) throw err;
          console.log('File is created successfully.');
        });
      }
      files.forEach(function (file) {
          console.log(file); 
      });
    });
  }

  // fs.writeFile('<fileName>',,callbackFunction);
  res.json({error:"Not found"});
});

router.get("/url", (req, res, next) => {
  res.json(["Tony","Lisa","Michael","Ginger","Food"]);
});

module.exports = router;