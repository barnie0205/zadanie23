-- Tworzenie tabeli "pracownik"
CREATE TABLE employee (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          first_name VARCHAR(50),
                          last_name VARCHAR(50),
                          salary DECIMAL(10, 2),
                          birth_date DATE,
                          position VARCHAR(50)
);

-- Wstawianie przynajmniej 6 pracowników
INSERT INTO employee (first_name, last_name, salary, birth_date, position)
VALUES
    ('Jan', 'Kowalski', 5000.00, '1990-01-15', 'Junior Java Developer'),
    ('Anna', 'Nowak', 5500.00, '1985-08-25', 'SQL Specialist'),
    ('Amboży', 'Kleks', 12500.00, '1989-03-10', 'Scrum Master'),
    ('Karolina', 'Gaweł', 6000.00, '1992-11-30', 'In-house Lawyer'),
    ('Harry', 'Potter', 7500.00, '1980-07-31', 'Software Wizard'),
    ('Ron', 'Weasley', 7500.00, '1980-03-01', 'Software Wizard'),
    ('Hermiona', 'Granger', 7500.00, '1979-09-19', 'Software Wizard'),
    ('Krzysztof', 'Jerzyna', 15000.00, '1939-05-02', 'Boss of All Bosses');

-- Pobranie wszystkich pracowników i wyświetlenie ich w kolejności alfabetycznej po nazwisku
SELECT * FROM employee
ORDER BY last_name;

-- Pobiera pracowników na wybranym stanowisku
SELECT * FROM employee
WHERE position = 'Software Wizard';

-- Pobiera pracowników, którzy mają min. 30 lat
SELECT * FROM employee
WHERE birth_date <= CURDATE() - INTERVAL 30 YEAR;

-- Zwiększa wypłatę pracowników na wybranym stanowisku o 10%
UPDATE employee
SET salary = salary * 1.10
WHERE position = 'Boss of All Bosses';

-- Pobiera najmłodszego z pracowników (z uwzględnieniem sytuacji, w której kilku praconików urodziło się tego samego dnia)
SELECT * FROM employee
WHERE birth_date = (SELECT MAX(birth_date) FROM employee);

-- Usuwa tabelę "pracownik"
DROP TABLE employee;

-- Tworzy tabelę "stanowisko" (nazwa stanowiska, opis, wypłata na danym stanowisku)
CREATE TABLE position (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          position_name VARCHAR(50),
                          description TEXT,
                          salary DECIMAL(10, 2)
);

-- Tworzy tabelę "adres" (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
CREATE TABLE address (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         street_with_number VARCHAR(100),
                         postal_code VARCHAR(10),
                         city VARCHAR(50)
);

-- Tworzy tabelę "pracownik" (imię, nazwisko) + relacje do tabeli "stanowisko" i "adres"
CREATE TABLE employee (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          first_name VARCHAR(50),
                          last_name VARCHAR(50),
                          FOREIGN KEY (position_id) REFERENCES position(id),
                          FOREIGN KEY (address_id) REFERENCES address(id)
);

-- Dodaje dane testowe
INSERT INTO position (position_name, description, salary)
VALUES
    ('Junior Java Developer', 'Koduje w Javie, licząc, że Java Developer znajdzie i naprawi ewentualne błędy',
     5000.00),
    ('SQL Specialist', 'Dba o to, żeby bazy danych nie zawierały głupot',
     5500.00),
    ('Scrum Master', 'Nikt do końca nie wie, czym się zajmuje, ani dlaczego tyle zarabia',
     12500.00),
    ('In-house Lawyer', 'Dba o to, żeby pozwów było jak najmniej',
     6000.00),
    ('Software Wizard', 'Uprawia magie, dzięki której oprogramowanie tworzone peze firmę (na ogół) działą.',
     7500.00),
    ('Boss of All Bosses', 'Płaci całej reszcie',
     15000.00);

INSERT INTO address (street_with_number, postal_code, city)
VALUES
    ('ul. Leśna 15', '34-424', 'Szaflary'),
    ('ul. Królowej Jadwigi 10', '86-200', 'Chełmno'),
    ('ul. Górska 2A', '58-540', 'Karpacz'),
    ('ul. Rybacka 5', '84-150', 'Hel'),
    ('ul. Żeromskiego 8', '57-200', 'Ząbkowice Śląskie'),
    ('ul. Zamkowa 12', '11-440', 'Reszel'),
    ('ul. Zamkowa 6', '82-200', 'Malbork'),
    ('ul. Browarna 3', '34-300', 'Żywiec');

INSERT INTO employee (first_name, last_name, position_id, address_id)
VALUES
    ('Jan', 'Kowalski', 1, 1),
    ('Anna', 'Nowak', 2, 2),
    ('Amboży', 'Kleks', 3, 3),
    ('Karolina', 'Gaweł', 4, 4),
    ('Harry', 'Potter', 5, 5),
    ('Ron', 'Weasley', 5, 6),
    ('Hermiona', 'Granger', 5, 7),
    ('Krzysztof', 'Jerzyna', 6, 8);

-- Pobiera pełne informacje o pracowniku (imię, nazwisko, adres, stanowisko)
SELECT e.first_name, e.last_name, a.street_with_number, a.city, a.postal_code, p.position_name
FROM employee e
         JOIN address a ON e.address_id = a.id
         JOIN position p ON e.position_id = p.id;

-- Oblicza sumę wypłat dla wszystkich pracowników w firmie
SELECT SUM(salary) AS total_salary
FROM employee;

-- Pobiera pracowników mieszkających w lokalizacji z kodem pocztowym xx-yyy
SELECT e.first_name, e.last_name
FROM employee e
         JOIN address a ON e.address_id = a.id
WHERE a.postal_code = '34-300';