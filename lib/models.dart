class Question{
  String QuestionText;
  List<Answers> AnswersList;
  Question(this.QuestionText,this.AnswersList);
}
class Answers{
  String Text;
  bool isCorrect;
  Answers(this.Text,this.isCorrect);
}
List<Question> getQuesion(){
  List<Question> list=[];
  list.add(
      Question('Who is the owner of flutter?', [
        Answers('Google', true),
        Answers('Samsung', false),
        Answers('Facebook', false),
        Answers('Micrsoft', false),
      ])
  );
  list.add(
      Question('Which is used in Flutter', [
        Answers('C++', false),
        Answers('Java', false),
        Answers('Kotlin', false),
        Answers('Dart', true),
      ])
  );
  list.add(
      Question('Who invented the first mobile phone', [
        Answers('Intell', false),
        Answers('Samsung', false),
        Answers('Motorolla', true),
        Answers('Sony', false),
      ])
  );

  return list;
}