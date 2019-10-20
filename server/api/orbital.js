const express = require('express');
const path = require('path');
const router = express.Router();
const fs = require('fs');
const axios = require('axios');
const _ = require('lodash/core');

router.get("/", (req, res, next) => {
  checkApi();
  res.json({error:"Not found"});
});

router.get("/url", (req, res, next) => {
  res.json(["Tony","Lisa","Michael","Ginger","Food"]);
});

function checkApi() {
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
        const getScrapMetal = () => {
          try {
            return axios.get('https://worldwind.arc.nasa.gov/spacebirds/data/TLE.json')
          } catch (error) {
            console.error(error)
          }
        }
        const scrapMetal = getScrapMetal();
        fs.writeFile(directoryPath + '/' + date.toISOString() + '.json', scrapMetal, function (err) {
          if (err) throw err;
          console.log('File is created successfully.');
        });
      } else {
        files.forEach(function (file) {
          let fileName = file.split(".");
          let fileDate = Date.parse(fileName[0]);
          console.log(file); 
        });
      }
    });
  }
}

module.exports = router;