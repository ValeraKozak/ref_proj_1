CREATE DATABASE OnlineSurveys;
USE OnlineSurveys;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE SurveyStatus (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE Surveys (
    survey_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_id INT,
    FOREIGN KEY (status_id) REFERENCES SurveyStatus(status_id) ON DELETE RESTRICT
);

CREATE TABLE Questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT,
    question_text TEXT NOT NULL,
    question_type ENUM('одиночний вибір', 'множинний вибір', 'текст') NOT NULL,
    FOREIGN KEY (survey_id) REFERENCES Surveys(survey_id) ON DELETE CASCADE
);

CREATE TABLE Answers (
    answer_id INT AUTO_INCREMENT PRIMARY KEY,
    question_id INT,
    answer_text VARCHAR(255),
    FOREIGN KEY (question_id) REFERENCES Questions(question_id) ON DELETE CASCADE
);

CREATE TABLE Responses (
    response_id INT AUTO_INCREMENT PRIMARY KEY,
    survey_id INT,
    user_id INT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (survey_id) REFERENCES Surveys(survey_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE UserAnswers (
    user_answer_id INT AUTO_INCREMENT PRIMARY KEY,
    response_id INT,
    answer_id INT,
    text_answer TEXT,
    FOREIGN KEY (response_id) REFERENCES Responses(response_id) ON DELETE CASCADE,
    FOREIGN KEY (answer_id) REFERENCES Answers(answer_id) ON DELETE SET NULL
);

CREATE TABLE SurveyCategories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE SurveyCategoryAssignments (
    survey_id INT,
    category_id INT,
    PRIMARY KEY (survey_id, category_id),
    FOREIGN KEY (survey_id) REFERENCES Surveys(survey_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES SurveyCategories(category_id) ON DELETE CASCADE
);

INSERT INTO Users (username, email, password) VALUES 
('ivan_kozak', 'ivan@gmail.com', 'hashed_password1'),
('oksana_petrova', 'oksana@gmail.com', 'hashed_password2'),
('admin_user', 'admin@gmail.com', 'hashed_password3'),
('volodymyr_koval', 'volodymyr@gmail.com', 'hashed_password4');

INSERT INTO SurveyStatus (status_name) VALUES
('активне'),
('архівне');

INSERT INTO Surveys (title, description, status_id) VALUES 
('Оцінка задоволеності клієнтів', 'Опитування для оцінки задоволеності клієнтів', 1),
('Зворотній зв’язок про продукт', 'Ваші враження про наш новий продукт', 1),
('Опитування залученості працівників', 'Опитування для оцінки залученості працівників', 1);

INSERT INTO Questions (survey_id, question_text, question_type) VALUES
(1, 'Наскільки ви задоволені нашим сервісом?', 'одиночний вибір'),
(1, 'Чи часто ви користуєтеся нашим сервісом?', 'одиночний вибір'),
(1, 'Чи рекомендували б ви наш сервіс друзям?', 'одиночний вибір'),
(1, 'Ваші додаткові коментарі:', 'текст'),
(2, 'Як би ви оцінили якість нашого продукту?', 'одиночний вибір'),
(2, 'Як часто ви купуєте наші продукти?', 'одиночний вибір'),
(2, 'Які функції ви б хотіли бачити в майбутньому?', 'текст'),
(2, 'Що вам не подобається у продукті?', 'текст'),
(3, 'Наскільки ви відчуваєте себе залученим у роботу?', 'одиночний вибір'),
(3, 'Чи відчуваєте ви підтримку від колег?', 'одиночний вибір'),
(3, 'Чи є можливість для професійного росту?', 'одиночний вибір'),
(3, 'Що б ви змінили в робочому процесі?', 'текст');

INSERT INTO Answers (question_id, answer_text) VALUES
(1, 'Дуже задоволений'),
(1, 'Задоволений'),
(1, 'Нейтрально'),
(1, 'Незадоволений'),
(1, 'Дуже незадоволений'),
(2, 'Щодня'),
(2, 'Щотижня'),
(2, 'Щомісяця'),
(2, 'Рідко'),
(3, 'Так'),
(3, 'Ні'),
(5, 'Відмінно'),
(5, 'Добре'),
(5, 'Задовільно'),
(5, 'Погано'),
(6, 'Дуже часто'),
(6, 'Часто'),
(6, 'Іноді'),
(6, 'Ніколи'),
(9, 'Повністю залучений'),
(9, 'Частково залучений'),
(9, 'Не залучений'),
(10, 'Так'),
(10, 'Ні'),
(11, 'Так'),
(11, 'Ні');

INSERT INTO Responses (survey_id, user_id) VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 3);

INSERT INTO UserAnswers (response_id, answer_id, text_answer) VALUES
(1, 1, NULL),
(1, 6, NULL),
(1, 3, NULL),
(1, NULL, 'Ви молодці!'),
(2, 3, NULL),
(2, 8, NULL),
(2, 10, NULL),
(2, NULL, 'Можна покращити сервіс.'),
(3, 6, NULL),
(3, 7, NULL),
(3, NULL, 'Додайте більше різних варіантів.'),
(3, NULL, 'Продукт надто дорогий'),
(4, 9, NULL),
(4, 10, NULL),
(4, 11, NULL),
(4, NULL, 'Покращити координацію між відділами.');

INSERT INTO SurveyCategories (category_name) VALUES
('Клієнтський досвід'),
('Зворотній зв’язок'),
('Залученість працівників');

INSERT INTO SurveyCategoryAssignments (survey_id, category_id) VALUES
(1, 1),
(2, 2),
(3, 3);
