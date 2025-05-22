:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).
:- use_module(library(sgml)).  % For xml_quote_attribute/2
:- dynamic count_quiz1/2, count_quiz2/2.


% Initialize counts for each quiz
count_quiz1(se, 0).
count_quiz1(bis, 0).
count_quiz1(hpc, 0).
count_quiz1(ke, 0).
count_quiz1(cn, 0).
count_quiz1(es, 0).
count_quiz1(cs, 0).

count_quiz2(se, 0).
count_quiz2(bis, 0).
count_quiz2(hpc, 0).
count_quiz2(ke, 0).
count_quiz2(cn, 0).
count_quiz2(es, 0).
count_quiz2(cs, 0).

% Define the major mappings
major_name(se, 'Software Engineering').
major_name(bis, 'Business Information Systems').
major_name(hpc, 'High Performance Computing').
major_name(ke, 'Knowledge Engineering').
major_name(cn, 'Communication and Networking Systems').
major_name(es, 'Embedded Systems').
major_name(cs, 'Cyber Security').
major_name(null, 'None whatsoever. Please answer the quiz properly!').

% Define the HTTP handlers
:- http_handler(root(home), home_page, []).
:- http_handler(root(quiz1), quiz1_form, []).
:- http_handler(root(quiz2), quiz2_form, []).
:- http_handler(root(process_quiz1), process_quiz1, [method(post)]).
:- http_handler(root(process_quiz2), process_quiz2, [method(post)]).

% Start the HTTP server on port 8080
start_server :-
    http_server(http_dispatch, [port(8080)]).

% Home page with a dropdown list and a button
home_page(_Request) :-
    format('Content-Type: text/html~n~n'),
    format('<html><head><style>~n'),
    format('body { font-family: Arial, sans-serif; text-align: center; margin: 0; padding: 50px; background-color: #f0f0f0; }~n'),
    format('h1 { font-size: 36px; margin-bottom: 20px; color: #333; }~n'),
    format('form { display: inline-block; margin-top: 30px; }~n'),
    format('select { padding: 10px; font-size: 18px; margin-bottom: 20px; }~n'),
    format('input[type="submit"] { padding: 10px 20px; font-size: 18px; color: white; background-color: #4CAF50; border: none; cursor: pointer; }~n'),
    format('input[type="submit"]:hover { background-color: #45a049; }~n'),
    format('</style></head><body>~n'),
    format('<h1>Welcome to UIT Major Selector!</h1>~n'),
    format('<form action="/take_quiz" method="GET">~n'),
    format('<b>What is your level of knowledge in the fields of Information Technology?<br>'),
    format('<br><select name="quiz">~n'),
    format('<option value="quiz1">Beginner</option>~n'),
    format('<option value="quiz2">Advanced</option>~n'),
    format('</select>~n'),
    format('<br>~n'),
    format('<input type="submit" value="Take Quiz">~n'),
    format('</form></body></html>').


% Handler for taking quiz based on selection
:- http_handler(root(take_quiz), take_quiz, []).

take_quiz(Request) :-
    http_parameters(Request, [
        quiz(Quiz, [atom])
    ]),
    (Quiz = 'quiz1' -> http_redirect(see_other, location_by_id(quiz1_form), Request);
     Quiz = 'quiz2' -> http_redirect(see_other, location_by_id(quiz2_form), Request)).

quiz1_form(_Request) :-
    format('Content-Type: text/html~n~n'),
    format('<html><head><style>~n'),
    format('body { font-family: Arial, sans-serif; margin: 0; padding: 50px; background-color: #f0f0f0; }~n'),
    format('h1 { font-size: 36px;  text-align: center; margin-bottom: 20px; color: #333; }~n'),
    format('form { display: inline-block; margin-top: 30px; }~n'),
    format('p { font-size: 20px; margin: 10px 0; }~n'),
    format('input[type="radio"] { margin-right: 10px; }~n'),
    format('input[type="submit"] { padding: 10px 20px; font-size: 18px; color: white; background-color: #4CAF50; border: none; cursor: pointer; }~n'),
    format('input[type="submit"]:hover { background-color: #45a049; }~n'),
    format('</style></head><body>~n'),
    format('<h1>Beginner Quiz</h1>~n'),
    format('<form action="/process_quiz1" method="POST">~n'),
     format('<p>Question 1: Are you interested in making apps or games using computers?</p>~n'),
    format('<p><input type="radio" name="answer1" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer1" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer1" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 2: Do you want to learn how the internet and Wi-Fi work?</p>~n'),
    format('<p><input type="radio" name="answer2" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer2" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer2" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 3: Are you interested in how hacking works and do you want to keep computers safe from hackers?</p>~n'),
    format('<p><input type="radio" name="answer3" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer3" value="b" required> interested</p>~n'),
        format('<p><input type="radio" name="answer3" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 4: Are you interested in how computers are built into everyday devices?</p>~n'),
    format('<p><input type="radio" name="answer4" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer4" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer4" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 5: Do you have any interest in computers that can think and solve problems like humans, such as chatGPT?</p>~n'),
    format('<p><input type="radio" name="answer5" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer5" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer5" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 6: Are you interested in how technology can help businesses make better decisions?</p>~n'),
    format('<p><input type="radio" name="answer6" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer6" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer6" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 7: Do you like the idea of using very powerful computers to solve big problems, like predicting the weather or researching new medicines?</p>~n'),
    format('<p><input type="radio" name="answer7" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer7" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer7" value="c" required> not interested</p>~n'),
    format('<br>'),


     format('<p>Question 8: Are you interested in how computers talk to each other over the internet?</p>~n'),
    format('<p><input type="radio" name="answer8" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer8" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer8" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 9: Are you interested in how coding can be integrated to vehicles such as fighter jets?</p>~n'),
    format('<p><input type="radio" name="answer9" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer9" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer9" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 10: Are you interested in how computer viruses and anti-viriuses work?</p>~n'),
    format('<p><input type="radio" name="answer10" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer10" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer10" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 11: Do you want to learn how to make gadgets that work in real-time, like a robot or a drone?</p>~n'),
    format('<p><input type="radio" name="answer11" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer11" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer11" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 12: Are you interested in learning how to make computers run faster?</p>~n'),
    format('<p><input type="radio" name="answer12" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer12" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer12" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 13: Would you like to learn how to use data to help companies make smart decisions?</p>~n'),
    format('<p><input type="radio" name="answer13" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer13" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer13" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 14: Are you interested in how computers can learn and make decisions on their own?</p>~n'),
    format('<p><input type="radio" name="answer14" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer14" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer14" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 15: Can you handle pressure when you have to react quickly to unexpected issues?</p>~n'),
    format('<p><input type="radio" name="answer15" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer15" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer15" value="c" required> not much</p>~n'),
    format('<br>'),

     format('<p>Question 16: Do you enjoy organizing information and making sure everything is in its proper place?</p>~n'),
    format('<p><input type="radio" name="answer16" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer16" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer16" value="c" required> not much</p>~n'),
    format('<br>'),

     format('<p>Question 17: Do you enjoy working with data and finding ways to make sense of it?</p>~n'),
    format('<p><input type="radio" name="answer17" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer17" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer17" value="c" required> not much</p>~n'),
    format('<br>'),

     format('<p>Question 18: Do you enjoy finding efficient ways to do things, especially when it comes to managing resources or data?</p>~n'),
    format('<p><input type="radio" name="answer18" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer18" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer18" value="c" required> not much</p>~n'),
    format('<br>'),

     format('<p>Question 19: Are you a creative thinker who likes to come up with innovative solutions to complex problems?</p>~n'),
    format('<p><input type="radio" name="answer19" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer19" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer19" value="c" required> not much</p>~n'),
    format('<br>'),

     format('<p>Question 20: Do you enjoy working as a team to solve complex technical problems?</p>~n'),
    format('<p><input type="radio" name="answer20" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer20" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer20" value="c" required> not much</p>~n'),
    format('<br>'),

     format('<p>Question 21: Are you detail oriented (i.e. do you pay close attention to detail)?</p>~n'),
    format('<p><input type="radio" name="answer21" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer21" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer21" value="c" required> not much</p>~n'),
    format('<br>'),

     format('<p>Question 22: "Do you enjoy solving complex mathematical problems?"</p>~n'),
    format('<p><input type="radio" name="answer22" value="a" required> yes</p>~n'),
    format('<p><input type="radio" name="answer22" value="b" required> kind of</p>~n'),
    format('<p><input type="radio" name="answer22" value="c" required> not much</p>~n'),
    format('<br>'),

    format('<p><input type="submit" value="Submit"></p>~n'),
    format('</form></body></html>').

quiz2_form(_Request) :-
    format('Content-Type: text/html~n~n'),
    format('<html><head><style>~n'),
    format('body { font-family: Arial, sans-serif; margin: 0; padding: 50px; background-color: #f0f0f0; }~n'),
    format('h1 { font-size: 36px;  text-align: center; margin-bottom: 20px; color: #333; }~n'),
    format('form { display: inline-block; margin-top: 30px; }~n'),
    format('p { font-size: 20px; margin: 10px 0; }~n'),
    format('input[type="radio"] { margin-right: 10px; }~n'),
    format('input[type="submit"] { padding: 10px 20px; font-size: 18px; color: white; background-color: #4CAF50; border: none; cursor: pointer; }~n'),
    format('input[type="submit"]:hover { background-color: #45a049; }~n'),
    format('</style></head><body>~n'),
    format('<h1>Advanced Quiz</h1>~n'),
    format('<form action="/process_quiz2" method="POST">~n'),
    format('<p>Question 1: Are you interested in studying subjects like Machine Learning, Data Mining & Data Processing Techniques?</p>~n'),
    format('<p><input type="radio" name="answer1" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer1" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer1" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 2: Do you want to explore how marking principles can be integrated with software and technology solutions?</p>~n'),
    format('<p><input type="radio" name="answer2" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer2" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer2" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 3: Do you want to gain expertise in cryptography and understand how it is applied to secure data?</p>~n'),
    format('<p><input type="radio" name="answer3" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer3" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer3" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 4: Are you interested in understanding broadband communication and the challenges of mobile networking?</p>~n'),
    format('<p><input type="radio" name="answer4" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer4" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer4" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p>Question 5: Do you want to learn about natural language processing and how computers understand and interpret human language?</p>~n'),
    format('<p><input type="radio" name="answer5" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer5" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer5" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 6: Are you interested in working with data at scale, such as in big data analytics or cloud computing?</p>~n'),
    format('<p><input type="radio" name="answer6" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer6" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer6" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 7: Are you interested in topics like IoT integration?</p>~n'),
    format('<p><input type="radio" name="answer7" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer7" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer7" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 8: Do you want to study network and internet security to understand how to protect information in an interconnected world?</p>~n'),
    format('<p><input type="radio" name="answer8" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer8" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer8" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 9: Are you interested in learning about business analytics and using data to drive business strategies?</p>~n'),
    format('<p><input type="radio" name="answer9" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer9" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer9" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 10: Do you want to learn about advanced computing systems like grid computing, cloud computing, and fog computing?</p>~n'),
    format('<p><input type="radio" name="answer10" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer10" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer10" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 11: Are you interested in learning multiple programming languages and frameworks?</p>~n'),
    format('<p><input type="radio" name="answer11" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer11" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer11" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 12: Are you interested in computer graphics, computer vision and digital image processing?</p>~n'),
    format('<p><input type="radio" name="answer12" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer12" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer12" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 13: Are you excited about the idea of developing robotic systems that can learn and adapt based on their environment?</p>~n'),
    format('<p><input type="radio" name="answer13" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer13" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer13" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 14: Do you want to study malware taxonomy and analyze malicious software to prevent cyber-attacks?</p>~n'),
    format('<p><input type="radio" name="answer14" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer14" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer14" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 15: Do you have an interest in entrepreneurship and how technology can be used to start and grow businesses?</p>~n'),
    format('<p><input type="radio" name="answer15" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer15" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer15" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 16: Do you want to work with both hardware and software components to create integrated systems?</p>~n'),
    format('<p><input type="radio" name="answer16" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer16" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer16" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 17: Are you interested in blockchain technology?</p>~n'),
    format('<p><input type="radio" name="answer17" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer17" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer17" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 18: Do you have an interest in learning about software architecture and the various methodologies for software construction?</p>~n'),
    format('<p><input type="radio" name="answer18" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer18" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer18" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 19: Do you want to explore career opportunities in fields related to telecommunications and network management?</p>~n'),
    format('<p><input type="radio" name="answer19" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer19" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer19" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 20: Are you interested in investigating cybercrime and working with digital forensics to analyze security incidents?</p>~n'),
    format('<p><input type="radio" name="answer20" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer20" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer20" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 21: Do you have an interest in understanding how information systems can be strategically leveraged to drive business success?</p>~n'),
    format('<p><input type="radio" name="answer21" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer21" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer21" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 22: Do you enjoy solving computationally intensive problems in fields such as scientific research, finance, or data analytics?</p>~n'),
    format('<p><input type="radio" name="answer22" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer22" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer22" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 23: Would you be interested in solving problems that involve optimizing and securing complex networking systems?</p>~n'),
    format('<p><input type="radio" name="answer23" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer23" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer23" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 24: Are you interested in gaining a strong foundation in topics like Web Technology, Operating Systems and Database Management?</p>~n'),
    format('<p><input type="radio" name="answer24" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer24" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer24" value="c" required> not interested</p>~n'),
    format('<br>'),

     format('<p>Question 25: Do you want to study neural networks and understand their application in embedded systems?</p>~n'),
    format('<p><input type="radio" name="answer25" value="a" required> very interested</p>~n'),
    format('<p><input type="radio" name="answer25" value="b" required> interested</p>~n'),
    format('<p><input type="radio" name="answer25" value="c" required> not interested</p>~n'),
    format('<br>'),

    format('<p><input type="submit" value="Submit"></p>~n'),
    format('</form></body></html>').


% Handlers to process quiz results
process_quiz1(Request) :-
    http_parameters(Request, [
        answer1(Answer1, [atom]),
        answer2(Answer2, [atom]),
        answer3(Answer3, [atom]),
        answer4(Answer4, [atom]),
        answer5(Answer5, [atom]),
        answer6(Answer6, [atom]),
        answer7(Answer7, [atom]),
        answer8(Answer8, [atom]),
        answer9(Answer9, [atom]),
        answer10(Answer10, [atom]),
        answer11(Answer11, [atom]),
        answer12(Answer12, [atom]),
        answer13(Answer13, [atom]),
        answer14(Answer14, [atom]),
        answer15(Answer15, [atom]),
        answer16(Answer16, [atom]),
        answer17(Answer17, [atom]),
        answer18(Answer18, [atom]),
        answer19(Answer19, [atom]),
        answer20(Answer20, [atom]),
        answer21(Answer21, [atom]),
        answer22(Answer22, [atom])

    ]),
    reset_counts_quiz1, % Reset counts before processing
    process_answer_quiz1(1, Answer1, _),
    process_answer_quiz1(2, Answer2, _),
    process_answer_quiz1(3, Answer3, _),
    process_answer_quiz1(4, Answer4, _),
    process_answer_quiz1(5, Answer5, _),
    process_answer_quiz1(6, Answer6, _),
    process_answer_quiz1(7, Answer7, _),
    process_answer_quiz1(8, Answer8, _),
    process_answer_quiz1(9, Answer9, _),
    process_answer_quiz1(10, Answer10, _),
    process_answer_quiz1(11, Answer11, _),
    process_answer_quiz1(12, Answer12, _),
    process_answer_quiz1(13, Answer13, _),
    process_answer_quiz1(14, Answer14, _),
    process_answer_quiz1(15, Answer15, _),
    process_answer_quiz1(16, Answer16, _),
    process_answer_quiz1(17, Answer17, _),
    process_answer_quiz1(18, Answer18, _),
    process_answer_quiz1(19, Answer19, _),
    process_answer_quiz1(20, Answer20, _),
    process_answer_quiz1(21, Answer21, _),
    process_answer_quiz1(22, Answer22, _),
    % Calculate results
    count_quiz1(se, SE),
    count_quiz1(bis, BIS),
    count_quiz1(hpc, HPC),
    count_quiz1(ke, KE),
    count_quiz1(cn, CN),
    count_quiz1(es, ES),
    count_quiz1(cs, CS),
    count_quiz1(null, NULL),
    Total is SE + BIS + HPC + KE + CN + ES + CS + NULL,
    Total > 0, % Ensure that we avoid division by zero
    % Calculate percentages
    SE_Percentage is (SE / Total) * 100,
    BIS_Percentage is (BIS / Total) * 100,
    HPC_Percentage is (HPC / Total) * 100,
    KE_Percentage is (KE / Total) * 100,
    CN_Percentage is (CN / Total) * 100,
    ES_Percentage is (ES / Total) * 100,
    CS_Percentage is (CS / Total) * 100,
    NULL_Percentage is (NULL / Total) * 100,
  % Determine the major with the highest percentage
findall(Percent-Major, (
    member(Major-Percent, [
        se-SE_Percentage,
        bis-BIS_Percentage,
        hpc-HPC_Percentage,
        ke-KE_Percentage,
        cn-CN_Percentage,
        es-ES_Percentage,
        cs-CS_Percentage,
        null-NULL_Percentage
    ])
), Pairs),
keysort(Pairs, Sorted),
reverse(Sorted, [MaxPercentage-_|_]), % Get the highest percentage

% Find all majors with the maximum percentage
findall(Major, member(MaxPercentage-Major, Sorted), MaxMajors),

% Convert MaxMajors list to a string with all major names
maplist(major_name, MaxMajors, FullMajorNames),
atomic_list_concat(FullMajorNames, ', ', MajorNamesText),

% Define redirection links for each major
findall(option([value(Link)], MajorName),
    (
        member(Major, MaxMajors),
        ( Major = se -> Link = 'https://www.uit.edu.mm/faculty-of-information-science/software-engineering/';
          Major = bis -> Link = 'https://www.uit.edu.mm/faculty-of-information-science/business-information-system/';
          Major = hpc -> Link = 'https://www.uit.edu.mm/faculty-of-computer-science/high-performance-computing/';
          Major = ke -> Link = 'https://www.uit.edu.mm/faculty-of-computer-science/knowledge-engineering/';
          Major = cn -> Link = 'https://www.uit.edu.mm/faculty-of-computer-systems-and-technologies/communication-and-networking-systems/';
          Major = es -> Link = 'https://www.uit.edu.mm/faculty-of-computer-systems-and-technologies/embedded-systems/';
          Major = cs -> Link = 'https://www.uit.edu.mm/cyber-security/';
          Major = null -> Link = 'http://localhost:8080/home'
        ),
        major_name(Major, MajorName)
    ),
    DropdownOptions
),

% Respond with HTML, mentioning all the majors
reply_html_page(
    [ title('Your Results') ],  % Header list
    [ % Head content
        style([
            'body { font-family: Arial, sans-serif; margin: 0; padding: 50px; background-color: #f0f0f0; }',
            'h1 { font-size: 36px; text-align: center; margin-bottom: 20px; color: #333; }',
            'form { display: inline-block; margin-top: 30px; }',
            'p { font-size: 20px; margin: 10px 0; }',
            'input[type="submit"], button { padding: 10px 20px; font-size: 18px; color: white; background-color: #4CAF50; border: none; cursor: pointer; margin-top: 20px; }',
            'input[type="submit"]:hover, button:hover { background-color: #45a049; }',
            'select { padding: 10px; font-size: 18px; margin-left: 10px; }',
            'span.green { color: green; font-weight: bold; }'
        ]),
        script([
            'function redirectToMajor() {',
            '  var selectedLink = document.getElementById("majorSelect").value;',
            '  window.location.href = selectedLink;',
            '}'
        ])
    ],  % End of head content
    [ % Body content
        h1('Your Results'),
        p(['You have the highest compatibility with the following majors: ', span([class('green')], MajorNamesText)]),
        \show_results_quiz1,
        form([action('/home'), method('GET')],
            [input([type(submit), value('Go Back to Home Page')], [])]),
        button([type(button), onclick('redirectToMajor()')],
            ['View Details About Major']),
        select([id('majorSelect')], DropdownOptions)  % Dropdown for majors
    ]
).







process_quiz2(Request) :-
    http_parameters(Request, [
        answer1(Answer1, [atom]),
        answer2(Answer2, [atom]),
        answer3(Answer3, [atom]),
        answer4(Answer4, [atom]),
        answer5(Answer5, [atom]),
        answer6(Answer6, [atom]),
        answer7(Answer7, [atom]),
        answer8(Answer8, [atom]),
        answer9(Answer9, [atom]),
        answer10(Answer10, [atom]),
        answer11(Answer11, [atom]),
        answer12(Answer12, [atom]),
        answer13(Answer13, [atom]),
        answer14(Answer14, [atom]),
        answer15(Answer15, [atom]),
        answer16(Answer16, [atom]),
        answer17(Answer17, [atom]),
        answer18(Answer18, [atom]),
        answer19(Answer19, [atom]),
        answer20(Answer20, [atom]),
        answer21(Answer21, [atom]),
        answer22(Answer22, [atom]),
        answer23(Answer23, [atom]),
        answer24(Answer24, [atom]),
        answer25(Answer25, [atom])
    ]),
    reset_counts_quiz2, % Reset counts before processing
    process_answer_quiz2(1, Answer1, _),
    process_answer_quiz2(2, Answer2, _),
    process_answer_quiz2(3, Answer3, _),
    process_answer_quiz2(4, Answer4, _),
    process_answer_quiz2(5, Answer5, _),
    process_answer_quiz2(6, Answer6, _),
    process_answer_quiz2(7, Answer7, _),
    process_answer_quiz2(8, Answer8, _),
    process_answer_quiz2(9, Answer9, _),
    process_answer_quiz2(10, Answer10, _),
    process_answer_quiz2(11, Answer11, _),
    process_answer_quiz2(12, Answer12, _),
    process_answer_quiz2(13, Answer13, _),
    process_answer_quiz2(14, Answer14, _),
    process_answer_quiz2(15, Answer15, _),
    process_answer_quiz2(16, Answer16, _),
    process_answer_quiz2(17, Answer17, _),
    process_answer_quiz2(18, Answer18, _),
    process_answer_quiz2(19, Answer19, _),
    process_answer_quiz2(20, Answer20, _),
    process_answer_quiz2(21, Answer21, _),
    process_answer_quiz2(22, Answer22, _),
    process_answer_quiz2(23, Answer23, _),
    process_answer_quiz2(24, Answer24, _),
    process_answer_quiz2(25, Answer25, _),

    % Calculate results
    count_quiz2(se, SE),
    count_quiz2(bis, BIS),
    count_quiz2(hpc, HPC),
    count_quiz2(ke, KE),
    count_quiz2(cn, CN),
    count_quiz2(es, ES),
    count_quiz2(cs, CS),
    count_quiz2(null, NULL),
    Total is SE + BIS + HPC + KE + CN + ES + CS + NULL,
    Total > 0, % Ensure that we avoid division by zero
    % Calculate percentages
    SE_Percentage is (SE / Total) * 100,
    BIS_Percentage is (BIS / Total) * 100,
    HPC_Percentage is (HPC / Total) * 100,
    KE_Percentage is (KE / Total) * 100,
    CN_Percentage is (CN / Total) * 100,
    ES_Percentage is (ES / Total) * 100,
    CS_Percentage is (CS / Total) * 100,
    NULL_Percentage is (NULL/ Total) * 100,
   % Determine the major with the highest percentage
findall(Percent-Major, (
    member(Major-Percent, [
        se-SE_Percentage,
        bis-BIS_Percentage,
        hpc-HPC_Percentage,
        ke-KE_Percentage,
        cn-CN_Percentage,
        es-ES_Percentage,
        cs-CS_Percentage,
        null-NULL_Percentage
    ])
), Pairs),
keysort(Pairs, Sorted),
    reverse(Sorted, [MaxPercentage-_|_]), % Get the highest percentage

% Find all majors with the maximum percentage
findall(Major, member(MaxPercentage-Major, Sorted), MaxMajors),

% Convert MaxMajors list to a string with all major names
maplist(major_name, MaxMajors, FullMajorNames),
atomic_list_concat(FullMajorNames, ', ', MajorNamesText),

% Define redirection links for each major
findall(option([value(Link)], MajorName),
    (
        member(Major, MaxMajors),
        ( Major = se -> Link = 'https://www.uit.edu.mm/faculty-of-information-science/software-engineering/';
          Major = bis -> Link = 'https://www.uit.edu.mm/faculty-of-information-science/business-information-system/';
          Major = hpc -> Link = 'https://www.uit.edu.mm/faculty-of-computer-science/high-performance-computing/';
          Major = ke -> Link = 'https://www.uit.edu.mm/faculty-of-computer-science/knowledge-engineering/';
          Major = cn -> Link = 'https://www.uit.edu.mm/faculty-of-computer-systems-and-technologies/communication-and-networking-systems/';
          Major = es -> Link = 'https://www.uit.edu.mm/faculty-of-computer-systems-and-technologies/embedded-systems/';
          Major = cs -> Link = 'https://www.uit.edu.mm/cyber-security/';
          Major = null -> Link = 'http://localhost:8080/home'
        ),
        major_name(Major, MajorName)
    ),
    DropdownOptions
),

% Respond with HTML, mentioning all the majors
reply_html_page(
    [ title('Your Results') ],  % Header list
    [ % Head content
        style([
            'body { font-family: Arial, sans-serif; margin: 0; padding: 50px; background-color: #f0f0f0; }',
            'h1 { font-size: 36px; text-align: center; margin-bottom: 20px; color: #333; }',
            'form { display: inline-block; margin-top: 30px; }',
            'p { font-size: 20px; margin: 10px 0; }',
            'input[type="submit"], button { padding: 10px 20px; font-size: 18px; color: white; background-color: #4CAF50; border: none; cursor: pointer; margin-top: 20px; }',
            'input[type="submit"]:hover, button:hover { background-color: #45a049; }',
            'select { padding: 10px; font-size: 18px; margin-left: 10px; }',
            'span.green { color: green; font-weight: bold; }'
        ]),
        script([
            'function redirectToMajor() {',
            '  var selectedLink = document.getElementById("majorSelect").value;',
            '  window.location.href = selectedLink;',
            '}'
        ])
    ],  % End of head content
    [ % Body content
        h1('Your Results'),
        p(['You have the highest compatibility with the following majors: ', span([class('green')], MajorNamesText)]),
        \show_results_quiz2,
        form([action('/home'), method('GET')],
            [input([type(submit), value('Go Back to Home Page')], [])]),
        button([type(button), onclick('redirectToMajor()')],
            ['View Details About Major']),
        select([id('majorSelect')], DropdownOptions)  % Dropdown for majors
    ]
).


% Answer mapping for Quiz 1 (multiple CountVars)
answer_map_quiz1(1, a, [(se, 5), (ke, 0)]).
answer_map_quiz1(1, b, [(se, 3), (ke, 0)]).
answer_map_quiz1(1, c, [(null, 0.01), (ke, 0)]).

answer_map_quiz1(2, a, [(cn, 5), (cs, 0)]).
answer_map_quiz1(2, b, [(cn, 3), (se, 0)]).
answer_map_quiz1(2, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(3, a, [(cs, 5), (cs, 0)]).
answer_map_quiz1(3, b, [(cs, 3), (se, 0)]).
answer_map_quiz1(3, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(4, a, [(es, 5), (cs, 0)]).
answer_map_quiz1(4, b, [(es, 3), (se, 0)]).
answer_map_quiz1(4, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(5, a, [(ke, 5), (cs, 0)]).
answer_map_quiz1(5, b, [(ke, 3), (se, 0)]).
answer_map_quiz1(5, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(6, a, [(bis, 5), (cs, 0)]).
answer_map_quiz1(6, b, [(bis, 3), (se, 0)]).
answer_map_quiz1(6, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(7, a, [(hpc, 5), (cs, 0)]).
answer_map_quiz1(7, b, [(hpc, 3), (se, 0)]).
answer_map_quiz1(7, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(8, a, [(cn, 5), (cs, 0)]).
answer_map_quiz1(8, b, [(cn, 3), (cs, 0)]).
answer_map_quiz1(8, c, [(null, 0.01), (cs, 0)]).

answer_map_quiz1(9, a, [(se, 5), (cs, 0)]).
answer_map_quiz1(9, b, [(se, 3), (se, 0)]).
answer_map_quiz1(9, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(10, a, [(cs, 5), (cs, 0)]).
answer_map_quiz1(10, b, [(cs, 3), (se, 0)]).
answer_map_quiz1(10, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(11, a, [(es, 5), (cs, 0)]).
answer_map_quiz1(11, b, [(es, 3), (se, 0)]).
answer_map_quiz1(11, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(12, a, [(hpc, 5), (es, 0)]).
answer_map_quiz1(12, b, [(hpc, 3), (es, 0)]).
answer_map_quiz1(12, c, [(null, 0.01), (es, 0)]).

answer_map_quiz1(13, a, [(bis, 5), (cs, 0)]).
answer_map_quiz1(13, b, [(bis, 3), (se, 0)]).
answer_map_quiz1(13, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(14, a, [(ke, 5), (cs, 0)]).
answer_map_quiz1(14, b, [(ke, 3), (se, 0)]).
answer_map_quiz1(14, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(15, a, [(cn, 5), (cs, 0)]).
answer_map_quiz1(15, b, [(cn, 3), (cs, 0)]).
answer_map_quiz1(15, c, [(null, 0.01), (null, 0)]).

answer_map_quiz1(16, a, [(bis, 5), (cs, 5)]).
answer_map_quiz1(16, b, [(bis, 3), (cs, 3)]).
answer_map_quiz1(16, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz1(17, a, [(ke, 5), (bis, 5)]).
answer_map_quiz1(17, b, [(ke, 3), (bis, 3)]).
answer_map_quiz1(17, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz1(18, a, [(hpc, 5), (cs, 0)]).
answer_map_quiz1(18, b, [(hpc, 3), (se, 0)]).
answer_map_quiz1(18, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz1(19, a, [(es, 5), (se, 5)]).
answer_map_quiz1(19, b, [(es, 3), (se, 3)]).
answer_map_quiz1(19, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz1(20, a, [(cn, 5), (se, 5)]).
answer_map_quiz1(20, b, [(cn, 3), (se, 3)]).
answer_map_quiz1(20, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz1(21, a, [(es, 5), (cs, 5)]).
answer_map_quiz1(21, b, [(es, 3), (cs, 3)]).
answer_map_quiz1(21, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz1(22, a, [(hpc, 5), (ke, 5)]).
answer_map_quiz1(22, b, [(hpc, 3), (ke, 3)]).
answer_map_quiz1(22, c, [(null, 0.01), (null, 0.01)]).


% Answer mapping for Quiz 2 (multiple CountVars)
answer_map_quiz2(1, a, [(se, 5), (ke, 5)]).
answer_map_quiz2(1, b, [(se, 3), (ke, 3)]).
answer_map_quiz2(1, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz2(2, a, [(bis, 5), (cs, 0)]).
answer_map_quiz2(2, b, [(bis, 3), (se, 0)]).
answer_map_quiz2(2, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(3, a, [(cs, 5), (cs, 0)]).
answer_map_quiz2(3, b, [(cs, 3), (se, 0)]).
answer_map_quiz2(3, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(4, a, [(cn, 5), (cs, 0)]).
answer_map_quiz2(4, b, [(cn, 3), (se, 0)]).
answer_map_quiz2(4, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(5, a, [(ke, 5), (cs, 0)]).
answer_map_quiz2(5, b, [(ke, 3), (se, 0)]).
answer_map_quiz2(5, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(6, a, [(hpc, 5), (cs, 0)]).
answer_map_quiz2(6, b, [(hpc, 3), (se, 0)]).
answer_map_quiz2(6, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(7, a, [(es, 5), (cs, 0)]).
answer_map_quiz2(7, b, [(es, 3), (se, 0)]).
answer_map_quiz2(7, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(8, a, [(cn, 5), (cs, 5)]).
answer_map_quiz2(8, b, [(cn, 3), (cs, 3)]).
answer_map_quiz2(8, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz2(9, a, [(bis, 5), (cs, 0)]).
answer_map_quiz2(9, b, [(bis, 3), (se, 0)]).
answer_map_quiz2(9, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(10, a, [(hpc, 5), (cs, 0)]).
answer_map_quiz2(10, b, [(hpc, 3), (se, 0)]).
answer_map_quiz2(10, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(11, a, [(se, 5), (cs, 0)]).
answer_map_quiz2(11, b, [(se, 3), (se, 0)]).
answer_map_quiz2(11, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(12, a, [(ke, 5), (es, 5)]).
answer_map_quiz2(12, b, [(ke, 3), (es, 3)]).
answer_map_quiz2(12, c, [(null, 0.01), (null, 0.01)]).

answer_map_quiz2(13, a, [(ke, 5), (cs, 0)]).
answer_map_quiz2(13, b, [(ke, 3), (se, 0)]).
answer_map_quiz2(13, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(14, a, [(cs, 5), (cs, 0)]).
answer_map_quiz2(14, b, [(cs, 3), (se, 0)]).
answer_map_quiz2(14, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(15, a, [(bis, 5), (cs, 0)]).
answer_map_quiz2(15, b, [(bis, 3), (se, 0)]).
answer_map_quiz2(15, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(16, a, [(es, 5), (cs, 0)]).
answer_map_quiz2(16, b, [(es, 3), (se, 0)]).
answer_map_quiz2(16, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(17, a, [(hpc, 5), (cs, 0)]).
answer_map_quiz2(17, b, [(hpc, 3), (se, 0)]).
answer_map_quiz2(17, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(18, a, [(se, 5), (cs, 0)]).
answer_map_quiz2(18, b, [(se, 3), (se, 0)]).
answer_map_quiz2(18, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(19, a, [(cn, 5), (cs, 0)]).
answer_map_quiz2(19, b, [(cn, 3), (se, 0)]).
answer_map_quiz2(19, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(20, a, [(cs, 5), (cs, 0)]).
answer_map_quiz2(20, b, [(cs, 3), (se, 0)]).
answer_map_quiz2(20, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(21, a, [(bis, 5), (cs, 0)]).
answer_map_quiz2(21, b, [(bis, 3), (se, 0)]).
answer_map_quiz2(21, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(22, a, [(hpc, 5), (cs, 0)]).
answer_map_quiz2(22, b, [(hpc, 3), (se, 0)]).
answer_map_quiz2(22, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(23, a, [(cn, 5), (cs, 0)]).
answer_map_quiz2(23, b, [(cn, 3), (se, 0)]).
answer_map_quiz2(23, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(24, a, [(se, 5), (cs, 0)]).
answer_map_quiz2(24, b, [(se, 3), (se, 0)]).
answer_map_quiz2(24, c, [(null, 0.01), (bis, 0)]).

answer_map_quiz2(25, a, [(es, 5), (cs, 0)]).
answer_map_quiz2(25, b, [(es, 3), (se, 0)]).
answer_map_quiz2(25, c, [(null, 0.01), (bis, 0)]).

% Reset functions for each quiz
reset_counts_quiz1 :-
    retractall(count_quiz1(_, _)),
    assert(count_quiz1(se, 0)),
    assert(count_quiz1(bis, 0)),
    assert(count_quiz1(hpc, 0)),
    assert(count_quiz1(ke, 0)),
    assert(count_quiz1(cn, 0)),
    assert(count_quiz1(es, 0)),
    assert(count_quiz1(cs, 0)),
    assert(count_quiz1(null, 0)).

reset_counts_quiz2 :-
    retractall(count_quiz2(_, _)),
    assert(count_quiz2(se, 0)),
    assert(count_quiz2(bis, 0)),
    assert(count_quiz2(hpc, 0)),
    assert(count_quiz2(ke, 0)),
    assert(count_quiz2(cn, 0)),
    assert(count_quiz2(es, 0)),
    assert(count_quiz2(cs, 0)),
    assert(count_quiz2(null, 0)).


% Process answers for each quiz (multiple CountVars)
process_answer_quiz1(QNum, Answer, valid) :-
    answer_map_quiz1(QNum, Answer, Counts),
    maplist(update_count_quiz1, Counts),
    !.
process_answer_quiz1(_, _, invalid).

process_answer_quiz2(QNum, Answer, valid) :-
    answer_map_quiz2(QNum, Answer, Counts),
    maplist(update_count_quiz2, Counts),
    !.
process_answer_quiz2(_, _, invalid).

% Update count for each quiz (multiple CountVars)
update_count_quiz1((CountVar, Weight)) :-
    count_quiz1(CountVar, Count),
    NewCount is Count + Weight,
    retract(count_quiz1(CountVar, Count)),
    assert(count_quiz1(CountVar, NewCount)).

update_count_quiz2((CountVar, Weight)) :-
    count_quiz2(CountVar, Count),
    NewCount is Count + Weight,
    retract(count_quiz2(CountVar, Count)),
    assert(count_quiz2(CountVar, NewCount)).

round_to(X, N, Rounded) :-
    Factor is 10^N,
    Temp is round(X * Factor),
    Rounded is Temp / Factor.

% Show results functions for each quiz
show_results_quiz1 -->
    {
        count_quiz1(se, SE),
        count_quiz1(bis, BIS),
        count_quiz1(hpc, HPC),
        count_quiz1(ke, KE),
        count_quiz1(cn, CN),
        count_quiz1(es, ES),
        count_quiz1(cs, CS),
        count_quiz1(null, NULL),
        Total is SE + BIS + HPC + KE + CN + ES + CS + NULL,
        Total > 0, % Ensure that we avoid division by zero
        SE_Percentage is (SE / Total) * 100,
        BIS_Percentage is (BIS / Total) * 100,
        HPC_Percentage is (HPC / Total) * 100,
        KE_Percentage is (KE / Total) * 100,
        CN_Percentage is (CN / Total) * 100,
        ES_Percentage is (ES / Total) * 100,
        CS_Percentage is (CS / Total) * 100,
        NULL_Percentage is (NULL / Total) * 100,
        round_to(SE_Percentage, 2, SE_Rounded),
        round_to(BIS_Percentage, 2, BIS_Rounded),
        round_to(HPC_Percentage, 2, HPC_Rounded),
        round_to(KE_Percentage, 2, KE_Rounded),
        round_to(CN_Percentage, 2, CN_Rounded),
        round_to(ES_Percentage, 2, ES_Rounded),
        round_to(NULL_Percentage, 2, NULL_Rounded),
        round_to(CS_Percentage, 2, CS_Rounded)
    },

    html([
        p(['Software Engineering: ',' (', SE_Rounded, '%)']),
        p(['Business Information Systems: ', ' (', BIS_Rounded, '%)']),
        p(['High Performance Computing: ',  ' (', HPC_Rounded, '%)']),
        p(['Knowledge Engineering: ',  ' (', KE_Rounded, '%)']),
        p(['Communication And Networking Systems: ',  ' (', CN_Rounded, '%)']),
        p(['Embedded Systems: ',  ' (', ES_Rounded, '%)']),
        p(['Cyber Security: ',  ' (', CS_Rounded, '%)'])

    ]).


show_results_quiz2 -->
    {
        count_quiz2(se, SE),
        count_quiz2(bis, BIS),
        count_quiz2(hpc, HPC),
        count_quiz2(ke, KE),
        count_quiz2(cn, CN),
        count_quiz2(es, ES),
        count_quiz2(cs, CS),
        count_quiz2(null, NULL),
        Total is SE + BIS + HPC + KE + CN + ES + CS + NULL,
        Total > 0, % Ensure that we avoid division by zero
        SE_Percentage is (SE / Total) * 100,
        BIS_Percentage is (BIS / Total) * 100,
        HPC_Percentage is (HPC / Total) * 100,
        KE_Percentage is (KE / Total) * 100,
        CN_Percentage is (CN / Total) * 100,
        ES_Percentage is (ES / Total) * 100,
        CS_Percentage is (CS / Total) * 100,
        NULL_Percentage is (NULL / Total) * 100,
        round_to(SE_Percentage, 2, SE_Rounded),
        round_to(BIS_Percentage, 2, BIS_Rounded),
        round_to(HPC_Percentage, 2, HPC_Rounded),
        round_to(KE_Percentage, 2, KE_Rounded),
        round_to(CN_Percentage, 2, CN_Rounded),
        round_to(ES_Percentage, 2, ES_Rounded),
        round_to(CS_Percentage, 2, CS_Rounded),
        round_to(NULL_Percentage, 2, NULL_Rounded)
    },
    html([
        p(['Software Engineering: ',' (', SE_Rounded, '%)']),
        p(['Business Information Systems: ', ' (', BIS_Rounded, '%)']),
        p(['High Performance Computing: ',  ' (', HPC_Rounded, '%)']),
        p(['Knowledge Engineering: ',  ' (', KE_Rounded, '%)']),
        p(['Communication And Networking Systems: ',  ' (', CN_Rounded, '%)']),
        p(['Embedded Systems: ',  ' (', ES_Rounded, '%)']),
        p(['Cyber Security: ',  ' (', CS_Rounded, '%)'])
    ]).

% Start the server when the file is loaded
:- initialization(start_server).

























