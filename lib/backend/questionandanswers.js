import sql from './dbconn.js';

const questionsData = [
  {
    question_number: 2,
    question_text: "Over the past week, how would you describe your overall energy and mood?",
    question_type: "single_choice",
    category: "Mood",
    answers: [
      { text: "Drained", value: 1, order: 1 },
      { text: "Low", value: 2, order: 2 },
      { text: "Neutral", value: 3, order: 3 },
      { text: "Good", value: 4, order: 4 },
      { text: "Energetic", value: 5, order: 5 },
    ]
  }
];

async function seedQuestions() {
  for (const q of questionsData) {

    const question = await sql`
      INSERT INTO questions 
      (question_number, question_text, question_type, category)
      VALUES 
      (${q.question_number}, ${q.question_text}, ${q.question_type}, ${q.category})
      RETURNING question_id
    `;

    const questionId = question[0].question_id;

    for (const ans of q.answers) {
      await sql`
        INSERT INTO answers
        (question_id, answer_text, answer_value, display_order)
        VALUES
        (${questionId}, ${ans.text}, ${ans.value}, ${ans.order})
      `;
    }
  }

  console.log("Questions seeded successfully");
}

seedQuestions();
