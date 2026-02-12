import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { pool } from '../db.js';

export const loginUser = async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password required' });
  }

  try {
    // 1️⃣ Check normal users
    let result = await pool.query(
      `SELECT id, email, password_hash
       FROM normal_users
       WHERE email = $1`,
      [email]
    );

    if (result.rows.length > 0) {
      const user = result.rows[0];

      const match = await bcrypt.compare(password, user.password_hash);
      if (!match) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      const token = jwt.sign(
        { userId: user.id, role: 'normal_user' },
        process.env.JWT_SECRET,
        { expiresIn: '7d' }
      );

      return res.json({
        message: 'Login successful',
        role: 'normal_user',
        userId: user.id,
        token,
        dashboard: 'NormalUserDashboard',
      });
    }

    // 2️⃣ Check organisation users
    result = await pool.query(
      `SELECT id, email, password_hash
       FROM organisation_users
       WHERE email = $1`,
      [email]
    );

    if (result.rows.length > 0) {
      const user = result.rows[0];

      const match = await bcrypt.compare(password, user.password_hash);
      if (!match) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      const token = jwt.sign(
        { userId: user.id, role: 'organisation_user' },
        process.env.JWT_SECRET,
        { expiresIn: '7d' }
      );

      return res.json({
        message: 'Login successful',
        role: 'organisation_user',
        userId: user.id,
        token,
        dashboard: 'OrganisationUserDashboard',
      });
    }

    // 3️⃣ Check HR users
    result = await pool.query(
      `SELECT id, email, password_hash
       FROM hr_users
       WHERE email = $1`,
      [email]
    );

    if (result.rows.length > 0) {
      const user = result.rows[0];

      const match = await bcrypt.compare(password, user.password_hash);
      if (!match) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      const token = jwt.sign(
        { userId: user.id, role: 'hr' },
        process.env.JWT_SECRET,
        { expiresIn: '7d' }
      );

      return res.json({
        message: 'Login successful',
        role: 'hr',
        userId: user.id, 
        token,
        dashboard: 'HrDashboard',
      });
    }

    // No user found
    return res.status(404).json({ error: 'User not found' });

  } catch (err) {
    console.error('Login error:', err.message);
    res.status(500).json({ error: 'Server error' });
  }
};
