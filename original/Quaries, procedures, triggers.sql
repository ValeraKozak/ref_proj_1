-- Запити

SELECT Surveys.title, COUNT(Questions.question_id) AS question_count FROM Surveys
JOIN Questions ON Surveys.survey_id = Questions.survey_id
GROUP BY Surveys.title;

SELECT Questions.question_text FROM Questions
JOIN Surveys ON Questions.survey_id = Surveys.survey_id
WHERE Surveys.title = 'Оцінка задоволеності клієнтів' AND Questions.question_type = 'одиночний вибір';

SELECT Users.username, COUNT(Responses.response_id) AS total_surveys FROM Users
JOIN Responses ON Users.user_id = Responses.user_id
GROUP BY Users.username
ORDER BY total_surveys DESC
LIMIT 1;

SELECT Answers.answer_text, COUNT(UserAnswers.answer_id) AS total_answers
FROM Answers
JOIN UserAnswers ON Answers.answer_id = UserAnswers.answer_id
JOIN Questions ON Answers.question_id = Questions.question_id
JOIN Surveys ON Questions.survey_id = Surveys.survey_id
JOIN SurveyStatus ON Surveys.status_id = SurveyStatus.status_id
GROUP BY Answers.answer_text
ORDER BY total_answers DESC
LIMIT 1;

SELECT DISTINCT Users.username, UserAnswers.text_answer
FROM Users
JOIN Responses ON Users.user_id = Responses.user_id
JOIN UserAnswers ON Responses.response_id = UserAnswers.response_id
WHERE UserAnswers.text_answer LIKE '%покращити%';

-- Процедури
DELIMITER //
CREATE PROCEDURE CreateUser (
    IN p_username VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE email = p_email) THEN
        INSERT INTO Users (username, email, password)
        VALUES (p_username, p_email, p_password);
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Користувач з таким email вже існує.';
    END IF;
END //
DELIMITER ;

CALL CreateUser('Іван_Петренко', 'ivan@gmail.com', 'пароль123');

DELIMITER //
CREATE PROCEDURE GetSurveyStatistics()
BEGIN
    SELECT 
        Surveys.survey_id,
        Surveys.title AS survey_title,
        Surveys.description AS survey_description,
        SurveyStatus.status_name AS survey_status,
        COUNT(DISTINCT Questions.question_id) AS total_questions,
        COUNT(DISTINCT Responses.response_id) AS total_responses
    FROM Surveys
    LEFT JOIN SurveyStatus ON Surveys.status_id = SurveyStatus.status_id
    LEFT JOIN Questions ON Surveys.survey_id = Questions.survey_id
    LEFT JOIN Responses ON Surveys.survey_id = Responses.survey_id
    GROUP BY Surveys.survey_id, Surveys.title, Surveys.description, SurveyStatus.status_name;
END //
DELIMITER ;

CALL GetSurveyStatistics();

-- Тригери
DELIMITER //
CREATE TRIGGER UpdateUserTimestamp
BEFORE UPDATE ON Users
FOR EACH ROW
BEGIN
    SET NEW.created_at = CURRENT_TIMESTAMP;
END //
DELIMITER ;

UPDATE Users 
SET username = 'Іван' 
WHERE email = 'ivan@gmail.com';

SELECT username, email, created_at FROM Users 
WHERE email = 'ivan@gmail.com';


DELIMITER //
CREATE TRIGGER PreventFewQuestions
BEFORE DELETE ON Questions
FOR EACH ROW
BEGIN
    DECLARE question_count INT;
    SELECT COUNT(*) INTO question_count
    FROM Questions
    WHERE survey_id = OLD.survey_id;
    IF question_count < 4 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'В опитуванні має бути щонайменше 3 питання.';
    END IF;
END //
DELIMITER ;

INSERT INTO Surveys (title, description, status_id) 
VALUES ('Тестове опитування', 'Це тестове опитування для перевірки', 1);

INSERT INTO Questions (survey_id, question_text, question_type) 
VALUES (4, 'Питання 1', 'одиночний вибір'), 
       (4, 'Питання 2', 'текст'), 
       (4, 'Питання 3', 'множинний вибір');
       
DELETE FROM Questions WHERE question_id = 14; 

SHOW PROCEDURE STATUS WHERE Db = 'OnlineSurveys';
