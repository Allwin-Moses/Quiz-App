using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Quiz_app.Models;

namespace Quiz_app.Models
{
    public class Quizdataaccess
    {
        public List<Quiz> selectcategories()
        {
            List<Quiz> select = new List<Quiz>();
         
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["info"].ToString());

            con.Open();

            SqlCommand cmd = new SqlCommand("ALLCATEGORIES", con);

            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Quiz choose = new Quiz();
                choose.Id = reader.GetInt32(0);
                choose.CategoryName = reader.GetString(1);
                select.Add(choose);
            }
            con.Close();
            return select;
           
        }

        public List<Question> Getquestions(int categoryId)
        {
            List<Question> select = new List<Question>();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["info"].ToString());

            con.Open();

            SqlCommand cmd = new SqlCommand("GETQN_BYCATEGORIES", con);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@CategoryId", categoryId);

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Question qn = new Question();
                qn.Id = Convert.ToInt32(reader["QId"]);
                qn.QuestionText = reader["QnText"].ToString();
                qn.CategoryId = Convert.ToInt32(reader["CategoryId"]);
                qn.Answers = new List<Answer>();
                select.Add(qn);
            }
            con.Close();
            return select;
        }

        public List<Answer> Getanswer(int questionId)

        {
            List<Answer> answer = new List<Answer>();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["info"].ToString());

            con.Open();

            SqlCommand cmd = new SqlCommand("GETANS_BY_QID", con);

            cmd.CommandType = CommandType.StoredProcedure;


            cmd.Parameters.AddWithValue("@QuestionId",questionId);

           
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Answer ans = new Answer();
                ans.Id = Convert.ToInt32(reader["Id"]);
                ans.AnswerText = reader["AnswerText"].ToString();
                ans.IsCorrect = Convert.ToBoolean(reader["IsCorrect"]);
                answer.Add(ans);
            }
            con.Close();
            return answer;
        }
        public List<int> GetCorrectAnswerIds()
        {
            List<int> correctIds = new List<int>();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["info"].ToString());
            SqlCommand cmd = new SqlCommand("GetCorrectAnswerIds", con);
            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                correctIds.Add(reader.GetInt32(0));
            }

            con.Close();

            return correctIds;
        }
    }
}