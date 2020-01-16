class Lessonsmodel {
  String lesson_name;
  String subject; //Konu
  // ignore: non_constant_identifier_names
  int target_question_count ;
  int solved_questions;
  String id;
//  double question_percent = (solved_questions/target_question_count)*100;


  Lessonsmodel(this.lesson_name,this.target_question_count,this.solved_questions,this.subject,this.id);
  Lessonsmodel.empty();

  Lessonsmodel.dynamicval(dynamic v){
    this.lesson_name=v['lessonName'];
    this.solved_questions=v['solvedquesiton'];
    this.target_question_count=v['targetQuestionCount'];
    //this.question_percent=v['questionpercent'];
    this.subject=v['Subject'];
    this.id=v['id'];
  }


  toJson(){
    return {
      "lessonName":lesson_name,
      "solvedquesiton":solved_questions,
      "targetQuestionCount":target_question_count,
      "Subject":subject,
      "id":id,
    };
  }


  String get lessonName => lesson_name;
  set lessonName(String value){
    lesson_name=value;
  }

  int get solvedquestion => solved_questions;
  set solvedquestion(int value){
    solved_questions=value;
  }

  int get targetQuestionCount => target_question_count;
  set targetQuestionCount(int value){
    target_question_count=value;
  }

  String get Subject => subject;
  set Subject(String value){
    subject=value;
  }


}

