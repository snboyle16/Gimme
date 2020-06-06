// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Cloud Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });


//   exports.writeToFirestore = functions.firestore
//   .document('users/{userID}')
//   .onWrite((change, context) => {
//     const changedUser = change.after.id
//     db.collection('users').doc(changedUser).set({notification: "new follower for you"},{merge: true});
//   });

  exports.addNotify = functions.https.onCall((data, context) => {
    console.log(context.auth.uid);
    db.collection('users').doc(data.userID).set({notification: data.message},{merge:true});
  });

  exports.joinGiveaway = functions.https.onCall((data, context) => {
      db.collection('users').doc(data.userID).update({joinedGimmes : admin.firestore.FieldValue.arrayUnion(data.giveawayID)});
  });

  exports.addUserToDB = functions.https.onCall((data,context) => {
      console.log(context.auth.uid);
      let userData = {username: data.username};
      db.collection('users').doc(context.auth.uid).set(userData);
  });

  exports.identifyExpiredGiveaways = functions.https.onCall((data, context) => {
      let allGiveaway = db.collection('giveaways').get()
        .then(snapshot => {
            snapshot.forEach(doc => {
                var currentTimeStamp = admin.firestore.FieldValue.serverTimestamp();
                docData = doc.data();
                var expirationTimeStamp = docData.expirationTime;
                if (currentTimeStamp > expirationTimeStamp) {
                    db.collection('giveaways').doc(doc.id).update({isExpired: true},{merge: true});
                }
                // console.log(docData.expirationTime < currentTimeStamp);
            });
            return;
        })
        .catch(err => {
        console.log('Error getting documents', err);
        });
  });


  

