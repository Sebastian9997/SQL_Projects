-- Keep a log of any SQL queries you execute as you solve the mystery.
-- check what is inside crime_scene_report
SELECT * FROM crime_scene_reports LIMIT 5;
-- looking for report of CS50 duck theft
SELECT * FROM crime_scene_reports WHERE street = 'Humphrey Street' AND month = 7 AND day = 28;
-- check for interviews of witnesses
SELECT * FROM interviews WHERE month = 7 AND day = 28 AND transcript LIKE '%bakery%';
-- check for license plate of cars leaving bakery parking lot at a given time period
SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit';
-- check owners of cars leaving bakery at a time of theft
SELECT name
    FROM people
    JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
    WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
        AND bakery_security_logs.activity = 'exit';
-- look for an account_number of a person withdrawing money before theft
SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw';
-- find bank account owners
SELECT people.name, bank_accounts.person_id, bank_accounts.account_number FROM bank_accounts
    JOIN people ON bank_accounts.person_id = people.id
    WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
    AND people.name IN (SELECT name
    FROM people
    JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
    WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
        AND bakery_security_logs.activity = 'exit');
-- check phone calls register
SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60;
-- check who caller was
SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60);
-- narrow down the search for a thief
SELECT people.id FROM bank_accounts
    JOIN people ON bank_accounts.person_id = people.id
    WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
    AND people.name IN (SELECT name FROM people
    JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
    WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
        AND bakery_security_logs.activity = 'exit')
        AND people.id IN (SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60));
-- look for a flight of a potential thief
SELECT flight_id FROM passengers
    WHERE passport_number IN (
        SELECT people.passport_number FROM bank_accounts
            JOIN people ON bank_accounts.person_id = people.id
            WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
            AND people.name IN (SELECT name FROM people
            JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
            WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
                AND bakery_security_logs.activity = 'exit')
                AND people.id IN (SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60)));

-- find the right flight
SELECT id FROM flights
WHERE id IN(
    SELECT flight_id FROM passengers
    WHERE passport_number IN (
        SELECT people.passport_number FROM bank_accounts
            JOIN people ON bank_accounts.person_id = people.id
            WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
            AND people.name IN (SELECT name FROM people
            JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
            WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
                AND bakery_security_logs.activity = 'exit')
                AND people.id IN (SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60))))
AND month = 7 AND day = 29
ORDER BY hour ASC
LIMIT 1;
-- find thief passport number
SELECT passport_number FROM passengers
    WHERE passport_number IN (
        SELECT people.passport_number FROM bank_accounts
            JOIN people ON bank_accounts.person_id = people.id
            WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
            AND people.name IN (SELECT name FROM people
            JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
            WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
                AND bakery_security_logs.activity = 'exit')
                AND people.id IN (SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60)))
    AND flight_id = (SELECT id FROM flights
WHERE id IN(
    SELECT flight_id FROM passengers
    WHERE passport_number IN (
        SELECT people.passport_number FROM bank_accounts
            JOIN people ON bank_accounts.person_id = people.id
            WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
            AND people.name IN (SELECT name FROM people
            JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
            WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
                AND bakery_security_logs.activity = 'exit')
                AND people.id IN (SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60))))
AND month = 7 AND day = 29
ORDER BY hour ASC
LIMIT 1);

-- find thief data
SELECT * FROM people WHERE passport_number = (
SELECT passport_number FROM passengers
    WHERE passport_number IN (
        SELECT people.passport_number FROM bank_accounts
            JOIN people ON bank_accounts.person_id = people.id
            WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
            AND people.name IN (SELECT name FROM people
            JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
            WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
                AND bakery_security_logs.activity = 'exit')
                AND people.id IN (SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60)))
    AND flight_id = (SELECT id FROM flights
WHERE id IN(
    SELECT flight_id FROM passengers
    WHERE passport_number IN (
        SELECT people.passport_number FROM bank_accounts
            JOIN people ON bank_accounts.person_id = people.id
            WHERE bank_accounts.account_number IN (SELECT account_number FROM atm_transactions WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = 'Leggett Street' AND transaction_type = 'withdraw')
            AND people.name IN (SELECT name FROM people
            JOIN bakery_security_logs ON people.license_plate = bakery_security_logs.license_plate
            WHERE people.license_plate IN (SELECT license_plate FROM bakery_security_logs WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute > 10 AND minute < 30 AND activity = 'exit')
                AND bakery_security_logs.activity = 'exit')
                AND people.id IN (SELECT id FROM people WHERE phone_number IN (SELECT caller FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60))))
AND month = 7 AND day = 29
ORDER BY hour ASC
LIMIT 1)
);

-- find destination city
SELECT city FROM airports WHERE id = 4;

-- find ACCOMPLICE phone number
SELECT receiver FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60 AND caller = '(367) 555-5533';

-- find accomplice name
SELECT name FROM people WHERE phone_number = (SELECT receiver FROM phone_calls WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60 AND caller = '(367) 555-5533');