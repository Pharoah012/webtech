from flask import Flask, jsonify, request
import firebase_admin
from firebase_admin import credentials, firestore




# initialise firebase
cred = credentials.Certificate('configuration/social-project-144e7-firebase-adminsdk-v85r4-8f4d33c2d5.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

# -------------- FIREBASE REFERENCES -----------------
notificationRef = db.collection('Notifications')




app = Flask(__name__)

# create user code
# User Details needed:
# id, number, name, email, dob, year group, major, campus residence?, best food, best movie


@app.route('/Notifications', methods=['POST'])
def createUser():
    notification = {
        'id': request.json['id'],
        'message': request.json['message'],
        'timeStamp': request.json['timeStamp'],
        
    }

    try:
        # create user in firestore
        notificationRef.set(notification)
        return jsonify({'Notification Created'}), 201

    except: 
        return jsonify({'message': 'Something went wrong'}), 404,



# Get user details 
@app.route('/Notifications', methods=['GET'])
def getUserDetails():
   
    # get user account and check whether it exists
    notifications = notificationRef.get()
    notifications = [doc.to_dict() for doc in notifications]
    return jsonify(notifications), 201



if __name__ == '__main__':
    app.run()
