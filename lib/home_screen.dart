import 'package:flutter/material.dart';
import 'models.dart';
void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentQuestion = 0;
  List<Question> questionlist = getQuesion();
  Answers? selectedAnswer;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Simple Quiz App',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Text(
                'Quesion ${currentQuestion+1} / ${questionlist.length} ',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(
                height: 50,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        questionlist[currentQuestion].QuestionText,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Positioned(
                      left: -20,
                      top: 25,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                      )),
                  const Positioned(
                      right: -20,
                      top: 25,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                      )),
                  Positioned(
                    top: -27,
                    left: 0,
                    right: 0,
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 50,
                          color: Colors.green,
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  for (Answers answer
                  in questionlist[currentQuestion].AnswersList)
                    answerButton(answer),
                  nextButton()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  answerButton(Answers answer) {
    bool isSelected = answer == selectedAnswer;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        //color: isSelected?Colors.orange:Colors.white,
        width: 150,
        height: 50,
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedAnswer = answer;
              });
            },
            child: Text(
              answer.Text,
              style: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  nextButton() {
    bool isLastQuestion = false;
    if (currentQuestion == questionlist.length - 1) {
      isLastQuestion = true;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: 300,
        child: ElevatedButton(
            onPressed: () {
              if (selectedAnswer!.isCorrect) {
                score++;
              }
              if (selectedAnswer == null) {} else {
                if (isLastQuestion) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) =>
                          AlertDialog(
                              title: Text(
                                "${score >= questionlist.length * 0.8
                                    ? 'Passed !'
                                    : 'Failed'} | Score : $score",
                                style:TextStyle(
                                    color : score >= questionlist.length * 0.8? Colors.green
                                        : Colors.red
                                ),),
                              content: SizedBox(
                                height: 60,
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        score = 0;
                                        currentQuestion = 0;
                                        selectedAnswer = null;
                                      });
                                    },
                                    child: Container(
                                        height: 50,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                        child: Center(
                                          child: Text(
                                            "Restart",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ),
                              )));
                } else {
                  setState(() {
                    selectedAnswer = null;
                    currentQuestion++;
                  });
                }
              }
            },
            child: Text(isLastQuestion ? 'Submit' : 'Next')),
      ),
    );
  }
}