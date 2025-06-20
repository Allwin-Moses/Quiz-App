using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Quiz_app.Models
{
    public class Quiz
    {
          public int Id { get; set; }
          public string CategoryName { get; set; }
        
    }
    public class Question
    {
        public int Id { get; set; }
        public string QuestionText { get; set; }
        public int CategoryId { get; set; }
        public List<Answer> Answers { get; set; }
        public int? SelectedAnswerId { get; set; }
    }
    public class Answer
    {
        public int Id { get; set; }
        public string AnswerText { get; set; }
        public bool IsCorrect { get; set; }
    }
}