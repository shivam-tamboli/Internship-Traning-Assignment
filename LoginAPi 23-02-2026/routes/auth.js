const express = require("express");
const router = express.Router();

// Dummy user (hardcoded)
const user = {
  username: "admin",
  password: "1234"
};

// POST Login API
router.post("/login", (req, res) => {
  const { username, password } = req.body;

  if (username === user.username && password === user.password) {
    return res.json({
      success: true,
      message: "Login successful"
    });
  } else {
    return res.status(401).json({
      success: false,
      message: "Invalid credentials"
    });
  }
});

module.exports = router;