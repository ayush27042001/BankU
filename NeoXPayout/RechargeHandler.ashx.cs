using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace NeoXPayout
{
    /// <summary>
    /// Summary description for RechargeHandler
    /// </summary>
    public class RechargeHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            string action = context.Request["action"];

            if (action == "getplans")
            {
                string operatorName = context.Request["operator"];
                string circle = context.Request["circle"];
                string serviceName = context.Request["service"] ?? "PREPAID";

                string operatorCode = GetOperatorCode(operatorName);
                if (string.IsNullOrEmpty(operatorCode))
                {
                    context.Response.Write("{\"error\":\"Invalid operator\"}");
                    return;
                }

                string content = mplan(circle, operatorCode, serviceName);
                if (content == "-1")
                {
                    context.Response.Write("{\"error\":\"API call failed\"}");
                    return;
                }

                try
                {
                    JObject jObjects = JObject.Parse(content);

                    if (jObjects["STATUS"]?.ToString() != "0" || jObjects["RDATA"] == null)
                    {
                        context.Response.Write("{\"error\":\"Plans not found\"}");
                        return;
                    }

                    JObject rdataObj = (JObject)jObjects["RDATA"];
                    var plansList = new JArray();

                    if (serviceName == "DTH")
                    {
                        foreach (var category in rdataObj.Properties())
                        {
                            JArray plans = (JArray)category.Value;
                            foreach (var item in plans)
                            {
                                JArray details = (JArray)item["Details"];
                                foreach (var detail in details)
                                {
                                    JArray pricing = (JArray)detail["PricingList"];
                                    foreach (var price in pricing)
                                    {
                                        plansList.Add(new JObject
                                        {
                                            ["amount"] = price["Amount"]?.ToString(),
                                            ["validity"] = price["Month"]?.ToString(),
                                            ["description"] = detail["PlanName"]?.ToString()
                                        });
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        foreach (var arrayProp in rdataObj.Properties())
                        {
                            if (arrayProp.Value.Type != JTokenType.Array) continue;

                            JArray planArray = (JArray)arrayProp.Value;
                            foreach (JObject plan in planArray)
                            {
                                plansList.Add(new JObject
                                {
                                    ["amount"] = plan["rs"]?.ToString(),
                                    ["validity"] = plan["validity"]?.ToString(),
                                    ["description"] = plan["desc"]?.ToString()
                                });
                            }
                        }
                    }

                    context.Response.Write(JsonConvert.SerializeObject(new { plans = plansList }));
                }
                catch
                {
                    context.Response.Write("{\"error\":\"Invalid response from API\"}");
                }
            }
        }


        public bool IsReusable { get { return false; } }

        // 🔹 Function to call API
        private string mplan(string Circle, string operatorcode, string serviceName)
        {
            try
            {
                string url;
                if (serviceName == "DTH")
                {
                    url = $"https://planapi.in/api/Mobile/DthPlans?apimember_id=5758&api_password=AAnn@1122&operatorcode={operatorcode}";
                }
                else
                {
                    url = $"https://planapi.in/api/Mobile/NewMobilePlans?apimember_id=5758&api_password=AAnn@1122&operatorcode={operatorcode}&Circle={Circle}";
                }

                var client = new RestClient(url);
                var request = new RestRequest(Method.GET);
                request.AddHeader("cache-control", "no-cache");
                request.AddHeader("Accept", "application/json");
                request.AddHeader("Content-Type", "application/json");
                IRestResponse response = client.Execute(request);
                return response.Content;
            }
            catch
            {
                return "-1";
            }
        }

        // 🔹 Operator Code Mapping
        private string GetOperatorCode(string opid)
        {
            if (string.IsNullOrEmpty(opid)) return string.Empty;

            switch (opid.Trim().ToUpper())
            {
                case "AIRTEL": return "2";
                case "VI":
                case "VODAFONE IDEA": return "23";
                case "JIO":
                case "RELIANCE JIO": return "11";
                case "BSNL": return "5";

                case "AIRTEL DIGITAL TV": return "24";
                case "DISH TV": return "25";
                case "VIDEOCON D2H": return "29";
                case "SUN DIRECT": return "27";
                case "TATA PLAY": return "28";

                default: return string.Empty;
            }
        }

    }
}