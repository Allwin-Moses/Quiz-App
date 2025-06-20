using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quiz_app.Models;

namespace Quiz_app.Controllers
{
    public class QuizController : Controller
    {
        public ActionResult Start()
        {
            return View();
        }

        public ActionResult Select()
        {
            Quizdataaccess select = new Quizdataaccess();
            List<Quiz> categories = select.selectcategories();

            ViewBag.Categories = new SelectList(categories, "Id", "CategoryName");
            ViewBag.Message = TempData["Message"];
            return View();
        }

        public ActionResult ChooseCategory(int categoryId)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));

            Session["CategoryId"] = categoryId;
            return RedirectToAction("Startquiz");
        }

        public ActionResult Startquiz()
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));

            Session["QuizStartTime"] = DateTime.Now;
            Session["QuizCompleted"] = false;

            if (Session["CategoryId"] == null)
                return RedirectToAction("Select");

            int categoryId = (int)Session["CategoryId"];
            Quizdataaccess data = new Quizdataaccess();
            List<Question> questions = data.Getquestions(categoryId);

            if (questions.Count == 0)
            {
                TempData["Message"] = "No questions available for the selected category.";
                return RedirectToAction("Select");
            }

            foreach (var q in questions)
            {
                q.Answers = data.Getanswer(q.Id);
            }

            Session["Questions"] = questions;
            Session["CurrentQuestionIndex"] = 0;
            Session["Score"] = 0;
            Session["UserAnswers"] = new Dictionary<int, int>();

            return RedirectToAction("questions");
        }

        [HttpGet]
        public ActionResult questions()
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));

            if (Session["QuizCompleted"] != null && (bool)Session["QuizCompleted"] == true)
                return RedirectToAction("Start");

            if (Session["Questions"] == null || Session["CurrentQuestionIndex"] == null)
                return RedirectToAction("Start");

            List<Question> questions = Session["Questions"] as List<Question>;
            int index = (int)Session["CurrentQuestionIndex"];

            if (index >= questions.Count)
                return RedirectToAction("Result");

            var currentQuestion = questions[index];
            Dictionary<int, int> userAnswers = Session["UserAnswers"] as Dictionary<int, int>;

            if (userAnswers != null && userAnswers.ContainsKey(currentQuestion.Id))
                currentQuestion.SelectedAnswerId = userAnswers[currentQuestion.Id];
            else
                currentQuestion.SelectedAnswerId = null;

            return View(currentQuestion);
        }

        [HttpPost]
        public ActionResult questions(int? selectedAnswerId, string navigation)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));

            if (Session["QuizCompleted"] != null && (bool)Session["QuizCompleted"] == true)
                return RedirectToAction("Start");

            if (Session["Questions"] == null || Session["CurrentQuestionIndex"] == null)
                return RedirectToAction("Start");

            List<Question> questions = Session["Questions"] as List<Question>;
            int index = (int)Session["CurrentQuestionIndex"];
            int score = (int)Session["Score"];

            Dictionary<int, int> userAnswers = Session["UserAnswers"] as Dictionary<int, int>;
            if (userAnswers == null)
                userAnswers = new Dictionary<int, int>();

            int currentQuestionId = questions[index].Id;

            if (navigation == "next")
            {
                if (selectedAnswerId.HasValue)
                {
                    Quizdataaccess data = new Quizdataaccess();
                    List<int> correctIds = data.GetCorrectAnswerIds();

                    if (correctIds.Contains(selectedAnswerId.Value))
                    {
                        if (!userAnswers.ContainsKey(currentQuestionId))
                            score++;
                    }

                    userAnswers[currentQuestionId] = selectedAnswerId.Value;
                }

                index++;
            }
            else if (navigation == "prev")
            {
                if (selectedAnswerId.HasValue)
                    userAnswers[currentQuestionId] = selectedAnswerId.Value;

                index = Math.Max(index - 1, 0);
            }

            Session["Score"] = score;
            Session["CurrentQuestionIndex"] = index;
            Session["UserAnswers"] = userAnswers;

            if (index >= questions.Count)
                return RedirectToAction("Result");

            return RedirectToAction("questions");
        }

        public ActionResult Result()
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));

            if (Session["Score"] == null || Session["Questions"] == null)
                return RedirectToAction("Start");

            DateTime startTime = Session["QuizStartTime"] != null
                ? (DateTime)Session["QuizStartTime"]
                : DateTime.Now;

            TimeSpan elapsed = DateTime.Now - startTime;

            ViewBag.Score = Session["Score"];
            ViewBag.Total = ((List<Question>)Session["Questions"]).Count;
            ViewBag.ElapsedTime = elapsed;
            Session["Questions"] = null; 
            Session["QuizCompleted"] = true;
            Session["CurrentQuestionIndex"] = null;// ✅ Prevent going back to questions
            return View();
        }
    }
}
