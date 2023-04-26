const functions = require("firebase-functions");
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "odin12345678909@gmail.com",
    pass: "kpbkoainxaqtbjez",
  },
});

exports.sendNewPostEmail = functions.firestore
    .document("Posts/{PostId}")
    .onCreate( async (snap, context) => {
      const post = snap.data();
      const usersRef = admin.firestore().collection("Users");
      const usersSnapshot = await usersRef.get();
      usersSnapshot.forEach(async (userDoc) => {
        const userData = userDoc.data();
        const mailOptions = {
          from: "Ashesi Connect",
          to: userData.email,
          subject: "New post Created",
          text: `${post.userName} has created a new post`,
        };
        try {
          const info = await transporter.sendMail(mailOptions);
          console.log("Email Sent:", info.response);
        } catch (error) {
          console.log("Email Error:", error);
        }
      });
    });
