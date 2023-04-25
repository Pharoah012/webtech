from flask import Flask, jsonify, request
import firebase_admin
from firebase_admin import credentials, firestore
import json
from google.cloud.firestore_v1 import SERVER_TIMESTAMP
from datetime import datetime
import smtplib
import ssl
from email.message import EmailMessage








# initialise firebase
cred = credentials.Certificate('social-project-144e7-firebase-adminsdk-v85r4-8f4d33c2d5.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

# -------------- FIREBASE REFERENCES -----------------
userRef = db.collection('Users')
postRef = db.collection('Posts')




app = Flask(__name__)

# create user code
# User Details needed:
# id, number, name, email, dob, year group, major, campus residence?, best food, best movie


# -------------- USER API CALLS -----------------

@app.route('/Users', methods=['POST'])
def createUser():
    email = request.json['email']
    user = {
        'userID': request.json['userID'],
        'phoneNumber': request.json['phoneNumber'],
        'email': request.json['email'],
        'dateOfBirth': request.json['dateOfBirth'],
        'userName': request.json['userName'],
        'campusResidence': request.json['campusResidence'],
        'yearGroup': request.json['yearGroup'],
        'major': request.json['major'],
        'favFood': request.json['favFood'],
        'favMovie': request.json['favMovie'],
    }
    # check if user exists
    if userRef.document(email).get().exists:
        return jsonify({'message':'User Already exists'}), 404
   


    # if user does not exist create new user
    
        # create user in firestore
    userRef.document(email).set(user)
    return jsonify({'user': 'user created'}), 201

    
        # return jsonify({'message': 'Something went wrong'}), 404,



# Get user details 
@app.route('/Users/<userEmail>', methods=['GET'])
def getUserDetails(userEmail):
    email = str(userEmail)
    # get user account and check whether it exists
    userAccount = userRef.document(email).get()
    if not userAccount.exists:
        return jsonify({'message':'Account does not exist'}), 404
    userInfo = userAccount.to_dict()
    return jsonify(userInfo), 201

# Get all user details 
@app.route('/Users', methods=['GET'])
def getAllUsers():
   
    # get user account and check whether it exists
    userAccount = userRef.get()
    users = [doc.to_dict() for doc in userAccount]
    return jsonify(users), 201



# update user details
@app.route('/Users/<userEmail>', methods=['POST'])
def updateUserDetails(userEmail):
    email = str(userEmail)
    
    # collect user data
    data = request.json

    if not userRef.document(email).get().exists:
        return jsonify({'User not found'}), 400

    # Update user in firestore 

    userRef.document(email).update(data)
    return jsonify({'Updated Successfully'}), 201




# -------------- POST API CALLS -----------------


@app.route('/Posts', methods=['POST'])
def createPost():
    post = {
        'PostId': request.json['PostID'],
        'userEmail': request.json['userEmail'],
        'userName': request.json['userName'],
        'message': request.json['message'],
        'newPost': True,
        'timeStamp': SERVER_TIMESTAMP
        
       
    }
    postID = request.json['PostID']

#  Create new post in firestore
    postRef.document(postID).set(post)
    return jsonify({'user': 'post created'}), 201





# Get all post details 
@app.route('/Posts', methods=['GET'])
def getPostDetails():
    posts = db.collection('Posts').order_by('timeStamp', direction=firestore.Query.DESCENDING).stream()
    results = []
    for post in posts:
        # Convert Firestore DocumentSnapshot to Python dictionary
        data = post.to_dict()
        
        # Convert the timestamp field to a datetime object
        # timestamp = data['timeStamp'].to_datetime()
        data['timeStamp'] = datetime.timestamp(data['timeStamp'])
        # Add document ID to dictionary
        data["PostID"] = post.id
        results.append(data)
    # Return posts as JSON response
    return json.dumps(results)



# Get post details of user
@app.route('/Posts/<userEmail>', methods=['GET'])
def getUserPostDetails(userEmail):
    email = str(userEmail)
    # get user account and check whether it exists
    posts = postRef.where('userEmail', '==', email).get()
    postlist = []
    for doc in posts:
        data= doc.to_dict()
        data['timeStamp'] = datetime.timestamp(data['timeStamp'])
        postlist.append(data)
    return jsonify(postlist), 201


# delete user post
@app.route('/Posts/<postID>', methods=['DELETE'])
def deletePost(postID):
    postid = str(postID)
    if not postRef.document(postid).get().exists:
        return jsonify({'error': 'user not found'}), 404

    # Delete user   
    postRef.document(postid).delete()
    return jsonify({'message': 'Post successful Deleted'})





# --------------------- SEND EMAIL ---------------------------

def listenNewPost(event, context):
    getPosts = postRef.document(event['PostID'])
    posts = getPosts.get().to_dict()
    postOwner = posts['userName']
    print('user')
    if posts['newPost']:
        sendEmail(postOwner)
        getPosts.update({'newPost':False})

def sendEmail(userName):
    users = userRef.stream()
    email_list = []
    for user in users:
        email = user.to_dict()['email']
        if email:
            email_list.append(email)
    for email in email_list:
        message = EmailMessage()
        message['From'] = 'odin12345678909@gmail.com'
        message['To'] = email,
        message['Subject'] = 'New post from '+ userName
        message.set_content('Hey there, check out the new post')

        context = ssl.create_default_context()

        with smtplib.SMTP_SSL('smtp.gmail.com',465,context=context) as smtp:
            smtp.login('odin12345678909@gmail.com','kpbkoainxaqtbjez')
            smtp.sendmail(
                from_addr= 'odin12345678909@gmail.com',
                to_addrs=email,
                msg= message.as_string()
                )
    
            # 'odin12345678909@gmail.com', 'aceexpofficial@gmail.com', message.as_string)

if __name__ == '__main__':
    app.run()
