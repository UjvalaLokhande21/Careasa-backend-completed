import bcrypt from 'bcrypt';
import { pool } from '../db.js';
import { response } from 'express';

export const signupOrganisationUser = async (req, res) => {
  console.log('📩 BODY RECEIVED:', req.body);

  const { fullName, email, password, organisationId } = req.body;

  if (!fullName || !email || !password || !organisationId) {
    return res.status(400).json({ error: 'Missing fields' });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      `INSERT INTO organisation_users
       (organisation_id, full_name, email, password_hash)
       VALUES ($1, $2, $3, $4)
       RETURNING id, email`,
      [organisationId, fullName, email, hashedPassword]
    );

    console.log('✅ INSERTED:', result.rows[0]);
    console.log(`Status Code From Signup :${response.statusCode}`)
    res.status(200).json({
      message: 'Organisation user created',
      userId: result.rows[0].id,
      email: result.rows[0].email,
    });
  } catch (err) {
    console.error('❌ DB ERROR:', err.message);
    res.status(500).json({ error: err.message });
  }
};
