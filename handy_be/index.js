const express = require('express');
const app = express();
const port = 3000;
const expressSwagger = require('express-swagger-generator')(app);

const url = 'mongodb://localhost:27017';
const MongoClient = require('mongodb').MongoClient;

let options = {
  swaggerDefinition: {
    info: {
      description: 'This is a sample server',
      title: 'Swagger',
      version: '3.0.3',
    },
    host: 'localhost:3000',
    basePath: '/v1',
    produces: ['application/json', 'application/xml'],
    schemes: ['http', 'https'],
    securityDefinitions: {
      JWT: {
        type: 'apiKey',
        in: 'header',
        name: 'Authorization',
        description: '',
      },
    },
  },
  basedir: __dirname, //app absolute path
  files: ['./routes/**/*.js'], //Path to the API handle folder
};
expressSwagger(options);

app.get('/events', (req, res) => {
  dbConnect((db, dbClose) => {
    const events = db
      .collection('events')
      .find(
        req.query.participantUser ? { participantUsers: { $elemMatch: { userId: req.query.participantUser } } } : {}
      )
      .project({ participantUsers: 0 })
      .toArray()
      .then((events) => {
        console.log(events);
        res.send(events);
      });
  });
});

app.put('events/:id/subscribe', (req, res) => {});

app.put('events/:id/unsubscribe', (req, res) => {});

app.listen(port, () => console.log(`Handy backend listening at http://localhost:${port}`));

function dbConnect(query) {
  MongoClient.connect(url, { useUnifiedTopology: true }, (err, db) => {
    if (err) return console.error(err);
    var dbo = db.db('handy_events');
    query(dbo, () => {
      db.close();
    });
  });
}
