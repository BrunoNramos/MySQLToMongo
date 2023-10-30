using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Diagnostics;
using System.Text.Json.Serialization;
using WebMySQLToMongo.Models;

namespace WebMySQLToMongo.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        [HttpGet]
        public IActionResult ConvertMySQLToMongo()
        {
            List<BitCoin> bitCoins = new List<BitCoin>();
            try
            {
                
                var connString = $"Server=172.18.0.3;Port=3306;Database=dbAula;Uid=root;Pwd=secret";
                Console.WriteLine("connection");
                MySqlConnection connection = new MySqlConnection(connString);
                Console.WriteLine("pós connection");
                string sql = "SELECT data, usd, gbp, eur FROM bitcoin_rate";

                Console.WriteLine($"Status connection: {connection.State}");

                if (connection.State == ConnectionState.Closed)
                    connection.Open();

                //MySqlCommand cmd = new MySqlCommand(sql, connection);
                MySqlCommand cmd = connection.CreateCommand();
                cmd = new MySqlCommand(sql);
                cmd.CommandType = CommandType.Text;
                cmd.Connection = connection;
                Console.WriteLine("antes command");
                MySqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                Console.WriteLine("pos command");
                if (rdr.HasRows)
                {
                    while (rdr.Read())
                    {
                        BitCoin bitCoin = new BitCoin();
                        bitCoin.data = rdr.GetDateTime(0);
                        bitCoin.usd = rdr.GetDouble(1);
                        bitCoin.gbp = rdr.GetDouble(2);
                        bitCoin.eur = rdr.GetDouble(3);
                        bitCoins.Add(bitCoin);
                    }
                }
                Console.WriteLine("pos while");
                rdr.Close();

                var command = connection.CreateCommand();
            }
            catch (Exception ex)
            {
                return Json(ex.GetBaseException().Message);
            }

            return Json(JsonConvert.SerializeObject(bitCoins));
            //teste
            //teste 3
            //return Json($"Quantidade: {bitCoins.Count()}");
        }
    }
}