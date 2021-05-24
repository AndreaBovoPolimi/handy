const express = require('express');
const app = express();
const port = 3000;
const expressSwagger = require('express-swagger-generator')(app);

const url = 'mongodb://localhost:27017';
const { MongoClient } = require('mongodb');

app.use(express.json());

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
        description: 'apiKey',
      },
    },
  },
  basedir: __dirname, //app absolute path
  files: ['./routes/**/*.js'], //Path to the API handle folder
};
expressSwagger(options);

app.get('/events', (req, res) => {
  dbConnect((db) => {
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

app.post('/events', (req, res) => {
  const event = req.body;

  dbConnect((db) => {
    db.collection('events').insertOne(event);
    res.json({
      success: true,
      insertedEvent: req.body,
    });
  });
});

app.put('/events/:id/subscribe', (req, res) => {
  dbConnect((db) => {
    console.log(req.params.id);
    db.collection('events').updateOne(
      { _id: req.params.id },
      {
        $push: {
          participantUsers: {
            userId: req.body.userId,
            registeredAt: (Date.now() / 1000) | 0,
            payment: null,
          },
        },
      }
    );
    res.json({
      success: true,
    });
  });
});

app.put('/events/:id/unsubscribe', (req, res) => {
  dbConnect((db) => {
    db.collection('events').updateOne(
      { _id: req.params.id },
      {
        $pull: {
          participantUsers: {
            userId: req.body.userId,
          },
        },
      }
    );
    res.json({
      success: true,
    });
  });
});

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
