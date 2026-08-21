using System;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace CSharpFrameworkTool
{
    public class Program
    {
        public static async Task Main(string[] args)
        {
            string baseUrl = "https://api.example.com";
            string endpoint = "/data";
            
            try
            {
                // Initialize the API client
                var client = CreateHttpClient(baseUrl);
                
                // Prepare the payload
                var payload = new { id = 123, name = "Test Item", value = 456.78 };
                string jsonPayload = JsonConvert.SerializeObject(payload);
                
                // Perform a POST request
                var response = await SendDataAsync(client, endpoint, jsonPayload, "application/json");
                
                if (response.IsSuccessStatusCode)
                {
                    string responseContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine($"Success: {responseContent}");
                }
                else
                {
                    Console.WriteLine($"Error: Status Code {response.StatusCode}");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Exception occurred: {ex.Message}");
            }
        }

        private static HttpClient CreateHttpClient(string baseUrl)
        {
            var client = new HttpClient();
            client.BaseAddress = new Uri(baseUrl);
            client.DefaultRequestHeaders.Accept.Clear();
            return client;
        }

        private static async Task<HttpResponseMessage> SendDataAsync(HttpClient client, string endpoint, string payload, string contentType)
        {
            var content = new StringContent(payload, Encoding.UTF8, contentType);
            return await client.PostAsync(endpoint, content);
        }
    }
}
