import nodemailer from "nodemailer";
import "dotenv/config";

const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: process.env.EMAILPORT,
  secure: true, // Use SSL/TLS
  auth: {
    user: process.env.SENDeMAIL,
    pass: process.env.SENDMAILPASSWORD,
  },
});

const sendVerificationEmail = async (senderAddress, link) => {
  let error = false;

  try {
    await transporter.sendMail({
      from: process.env.SENDeMAIL,
      to: senderAddress,
      subject: "Verify Email",
      html: `
      
      <!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Verify your Account</title>
    <style>
      body {
        background-color: rgb(193, 212, 251);
      }
      h1 {
      
        text-align: center;
        margin-top: 50px;
        margin-bottom: 150px;
        font-size: 30px;
        color: rgb(7, 84, 132);
        font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI",
          Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue",
          sans-serif;
      }
      p {
        width: 1000px;
        margin-left: 20%;
        margin-bottom: 50px;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        color: rgb(32, 1, 1);
      }
      img {
        width: 500px;
        height: 300px;
        align-items: center;
        margin-left: 33%;
        margin-bottom: 80px;
 
      }
    </style>
  </head>
  <body>
    <h1>Please click the link to Verify your Account</h1>
    <a href="${link}"> <img src="https://p7.hiclipart.com/preview/867/950/447/computer-icons-email-icloud-email.jpg"/> </a>
    <p>
      Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
      voluptatibus doloribus quas beatae optio quidem excepturi. Aliquam,
      blanditiis? Eius, aliquam alias facilis illo dolorem quo ullam accusantium
      voluptatibus impedit blanditiis?
      <a href="${link}">Click Here</a>
    </p>
  </body>
</html>
      `,
    });
  } catch (e) {
    error = true;
  }

  return error;
};

const sendForgotPasswordEmail = async (senderAddress, link) => {
  let error = false;

  try {
    await transporter.sendMail({
      from:  process.env.SENDeMAIL,
      to: senderAddress,
      subject: "Reset Password",
      html: `Please reset your password by clicking <a href="${link}">here</a>.<br>This email is valid for two days.`,
    });
  } catch (e) {
    error = true;
  }

  return error;
};

export { sendVerificationEmail, sendForgotPasswordEmail };
